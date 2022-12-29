//
//  SignUpViewController.swift
//  UBER
//
//  Created by Admin on 29/12/22.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var phoneNoField: UITextField!
    @IBOutlet weak var crateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
       
    }
    
    func configureUI() {
           styleTextField(userNameField)
           styleTextField(emailField)
           styleTextField(passwordField)
           styleTextField(phoneNoField)
           
           
           cornerRadius(crateBtn)
           profileImage.layer.cornerRadius = profileImage.frame.width / 2
           profileImage.clipsToBounds = true
           
       }

    @IBAction func createBtnClick(_ sender: UIButton) {
        
    }
    

}
