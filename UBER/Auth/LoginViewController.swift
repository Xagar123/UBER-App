//
//  ViewController.swift
//  UBER
//
//  Created by Admin on 28/12/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if FirebaseAuth.Auth.auth().currentUser == nil {
            emailField.becomeFirstResponder()
        }
    }
    func configureUI() {
       // emailField.becomeFirstResponder()
        styleTextField(emailField)
        styleTextField(passwordField)
        cornerRadius(loginBtn)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(false)
        }
    
    
    @IBAction func loginBtnClick(_ sender: UIButton) {
        guard let email = emailField.text, !email.isEmpty,
              isValid(email: email)
        else {
            showAlert(title: "Error", message: "Invalid email", in: LoginViewController())
            return
        }
        
        guard let password = passwordField.text, !password.isEmpty else {
            showAlert(title: "Error", message: "Invalid password", in: LoginViewController())
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else {return}
            guard error == nil else {
                //show account creation
                self.showCreateAccount(email: email, password: password)
                
                return
            }
            print("you have signed in")
            self.emailField.text = nil
            self.passwordField.text = nil
            self.transitionToHome()
            
        }
    }
    func showCreateAccount(email:String, password: String) {
        let alert = UIAlertController(title: "Create Account", message: "Would you like to create and account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { result, error in
                
                guard let email = self.emailField.text, !email.isEmpty,
                      isValid(email: email)
                else {
                    showAlert(title: "Error", message: "Invalid email", in: LoginViewController())
                    return
                }
                
                guard let password = self.passwordField.text, !password.isEmpty else {
                    showAlert(title: "Error", message: "Invalid password", in: LoginViewController())
                    return
                }
                
                FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
                    guard let self = self else {return}
                    guard error == nil else {
                        //show account creation
                        showAlert(title: "Error", message: "Account creation fail", in: LoginViewController())
                        return
                    }
                    print("you have signed in")
                    
                  //  self.emailField.isHidden = true
                  //  self.passwordField.isHidden = true
                    showAlert(title: "Success", message: "Sucessfully login ok to contibue ", in: LoginViewController())
                    self.transitionToHome()
                    
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancle", style: .cancel))
        

        present(alert, animated: true)
        
        }
    
    func transitionToHome(){
        let homeVC = storyboard?.instantiateViewController(withIdentifier: "ContainerController") as! ContainerController
      //  self.navigationController?.pushViewController(homeVC, animated: true)
        let container = ContainerController()
        let nav = UINavigationController(rootViewController: homeVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav,animated: true)
        
    }
    
    
    @IBAction func signUpBtnClick(_ sender: UIButton) {
       
        let secondVC = (storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController)!
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    


}

