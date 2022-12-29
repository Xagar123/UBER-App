//
//  menuButton.swift
//  UBER
//
//  Created by Admin on 29/12/22.
//

import Foundation
import UIKit

class MenuButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(background: UIColor) {
        self.init(frame: .zero)
        self.backgroundColor = background
    }
    
    private func configure() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
                
                //corner radius
               // button.layer.masksToBounds = true
                button.layer.cornerRadius = 30
                button.backgroundColor = .systemPink
                
             //   let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize:32 , weight: .medium ))
        
                let image = UIImage(systemName: "line.horizontal.3", withConfiguration: UIImage.SymbolConfiguration(pointSize:32 , weight: .medium ))
        
                button.setImage(image, for: .normal)
               // button.tintColor = .white
                button.tintColor = UIColor.black
                button.setTitleColor(.white, for: .normal)
                
                //adding shadow
                button.layer.shadowRadius = 10
                button.layer.shadowOpacity = 0.8
                translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
}
