//
//  MenuOption.swift
//  Side Menu Bar prog
//
//  Created by Admin on 26/11/22.
//
import UIKit

enum MenuOption: Int, CustomStringConvertible {
    
    case Home
    case Service
    case Activity
    case Setting
    
    var description: String{
        switch self{
            
        case .Home: return "Home"
        case .Service: return "Service"
        case .Activity: return "Activity"
        case .Setting: return "Setting"
        }
    }
    var image: UIImage{
        switch self{
            
        case .Home: return UIImage(named: "home") ?? UIImage()
        case .Service: return UIImage(named: "Language") ?? UIImage()
        case .Activity: return UIImage(named: "download") ?? UIImage()
        case .Setting: return UIImage(named: "setting") ?? UIImage()
        }
    }
}
