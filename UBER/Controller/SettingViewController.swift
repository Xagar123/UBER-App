//
//  SettingViewController.swift
//  UBER
//
//  Created by Admin on 29/12/22.
//

import UIKit
import FirebaseAuth

class SettingViewController: UIViewController {
    
    
    let signOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Sign Out", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(signOutButton)
        signOut()
        
    }
    

    func signOut () {
        if FirebaseAuth.Auth.auth().currentUser != nil {
            view.addSubview(signOutButton)
            signOutButton.frame = CGRect(x: 20, y: 100, width: view.frame.size.width-40, height: 50)
            signOutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        }
    }
    
    @objc func logoutButtonTapped() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
           // navigationController?.popViewController(animated: true)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let scene = UIApplication.shared.connectedScenes.first
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                guard let loginVC = loginVC else {return}
                sd.window?.rootViewController = loginVC
            }
        
        } catch {
            print(error.localizedDescription)
        }
    }

}
