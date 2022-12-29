//
//  Utility.swift
//  messaging App
//
//  Created by Admin on 27/12/22.
//

import Foundation
import UIKit

    func cornerRadius(_ view: UIView) {
            view.layer.cornerRadius = 25
            view.layer.masksToBounds = true
    }

 func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
//        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
     bottomLine.backgroundColor = UIColor.black.cgColor
        // Remove border on text field
        textfield.borderStyle = .none
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
    }
    
func isValid(email: String) -> Bool {
    let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let test = NSPredicate(format: "SELF MATCHES %@", regex)
    let result = test.evaluate(with: email)
    return result
}

func isValid(phone: String) -> Bool {
    let regex = "[0-9]{10,}"
    let test = NSPredicate(format: "SELF MATCHES %@", regex)
    let result = test.evaluate(with: phone)
    return result
}

func showAlert(title:String, message:String, in vc: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alert.addAction(action)
    vc.present(alert, animated: true)
}

func instantiateViewController(identifier: String, animated: Bool, by vc: UIViewController, completion: (() -> Void)?) {
    let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    newViewController.modalPresentationStyle = .fullScreen
    vc.present(newViewController, animated: animated, completion: completion)
}
 
// if the picture is blank then we are adding the name in pictue
func imageFromInitials(name:String, withBlock:@escaping (_ image: UIImage) -> Void) {
    
    var string: String!
    var size = 36
    
    let delimiter = ""
    let token = name.components(separatedBy: delimiter)
    let firstName = token[0]
    var lastName = ""
    if token.count > 1 {
        lastName = token[1]
    }
    if firstName != "" && lastName != "" {
        string = String(firstName.first!).uppercased() + String(lastName.first!).uppercased()
    } else {
        string = String(firstName.first!).uppercased()
        size = 72
    }
    let lblNameInitialize = UILabel()
    lblNameInitialize.frame.size = CGSize(width: 100, height: 100)
    lblNameInitialize.textColor = .white
    lblNameInitialize.font = UIFont(name: lblNameInitialize.font.fontName, size: CGFloat(size))
    lblNameInitialize.text = string
    lblNameInitialize.textAlignment = NSTextAlignment.center
    lblNameInitialize.backgroundColor = UIColor.lightGray
    lblNameInitialize.layer.cornerRadius = 25
    
    UIGraphicsBeginImageContext(lblNameInitialize.frame.size)
    lblNameInitialize.layer.render(in: UIGraphicsGetCurrentContext()!)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    withBlock(image!)
    
}

private let dateFormate = "yyyyMMddHHmmss"

func dateFormatter() -> DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(secondsFromGMT: TimeZone.current.secondsFromGMT())
    dateFormatter.dateFormat = dateFormate
    return dateFormatter
}
