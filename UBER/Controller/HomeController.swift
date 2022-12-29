//
//  HomeController.swift
//  Side Menu Bar prog
//
//  Created by Admin on 25/11/22.
//

import UIKit
import MapKit
import CoreLocation
import FloatingPanel

class HomeController: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
    
    let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    
    private var direction = [String]()
    
    
    var delegate:HomeControllerDelegate!
    
    let menuButton = MenuButton(background: .systemGreen)
    let searchButton = MenuButton(background: .lightGray)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  configureNavigationBar()
        view.backgroundColor = .systemBackground
        view.addSubview(mapView)
        view.addSubview(menuButton)
        view.addSubview(searchButton)
        
        self.mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
        configureMenuButton()
        configureSearchButton()
        addPointOfInterest()
        
        let panel = FloatingPanelController()
       // panel.set(contentViewController: SearchViewController())
        panel.addPanel(toParent: self)
        
    }
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           mapView.frame = view.bounds
       }
       
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nc = segue.destination as? UINavigationController,
              let directionTVC = nc.viewControllers.first as? DirectionTableViewController
        else {
            return
        }
        
        directionTVC.directions = self.direction
    }
    
    private func addPointOfInterest() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 19.0760, longitude: 72.8777)
        self.mapView.addAnnotation(annotation)
        
        let region = CLCircularRegion(center: annotation.coordinate, radius: 200, identifier: "region")
        //when a user enter or exit the region then we will notify
        region.notifyOnEntry = true
        region.notifyOnExit = true
        
        //overlay
        self.mapView.addOverlay(MKCircle(center: annotation.coordinate, radius: 200))
        
        //monitaring the region
        self.locationManager.startMonitoring(for: region)
    }
    
    
    func configureMenuButton() {
        menuButton.addTarget(self, action: #selector(handleMenuToggle), for: .touchUpInside)
        let image = UIImage(systemName: "line.horizontal.3", withConfiguration: UIImage.SymbolConfiguration(pointSize:32 , weight: .medium ))
        menuButton.setImage(image, for: .normal)
        menuButton.tintColor = UIColor.systemBackground
        menuButton.layer.cornerRadius = 30
        menuButton.layer.shadowRadius = 10
        menuButton.layer.shadowOpacity = 0.9
        
        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80 ),
            menuButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            menuButton.widthAnchor.constraint(equalToConstant: 60),
            menuButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    @objc func handleMenuToggle(){
        print("menu button clicked")
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    func configureSearchButton() {
        searchButton.addTarget(self, action: #selector(handleSearchButton), for: .touchUpInside)
        let image = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize:32 , weight: .medium ))
        searchButton.setImage(image, for: .normal)
        searchButton.setTitle("  Where to?", for: .normal)
       searchButton.tintColor = UIColor.systemBackground
       searchButton.layer.cornerRadius = 30
       searchButton.layer.shadowRadius = 10
       searchButton.layer.shadowOpacity = 0.9
        
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            searchButton.leadingAnchor.constraint(equalTo: menuButton.trailingAnchor, constant: 40),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            searchButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
    @objc func handleSearchButton() {
        let container = SearchViewController()
        let newVC = UINavigationController(rootViewController: container)
      //  newVC.modalPresentationStyle = .fullScreen
        present(newVC, animated: true)
        
    }
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation {
            let coordinate = annotation.coordinate
            
            let destinationPlacemark = MKPlacemark(coordinate: coordinate)
            
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
            //Apple map
            MKMapItem.openMaps(with: [destinationMapItem], launchOptions: nil)
        }
    }
    
    
    //it fire when user enter a region
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("did enter region")
    }
    
    //it fire when user exit a region
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("did exit region")
    }
    
    //delegate method for overlay
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            var circleRender = MKCircleRenderer(circle: overlay as! MKCircle)
            circleRender.lineWidth = 1.0
            circleRender.strokeColor = UIColor.systemPink
            circleRender.fillColor = UIColor.systemPink
            circleRender.alpha = 0.4
            return circleRender
        }
        
        let render = MKPolylineRenderer(overlay: overlay)
        render.lineWidth = 5.0
        render.strokeColor = UIColor.systemBlue
        return render
        
        //if its not then default render
        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08))
        mapView.setRegion(region, animated: true)
    }

}

