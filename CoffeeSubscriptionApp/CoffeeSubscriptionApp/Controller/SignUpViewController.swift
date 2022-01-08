//
//  SignUpViewController.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 08/01/2022.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var phoneNoTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func signUp(_ sender: Any) {
        
        if let name = nameTextField.text , let email = emailTextField.text, let phoneNo = phoneNoTextField.text , let password = passwordTextField.text {
            
            // check email format & password validation
            if email.isValidEmail(){
                DatabaseManager.signUp(email: email, password: password, name: name, phoneNo: phoneNo)
                
                let tabBar = self.storyboard?.instantiateViewController(withIdentifier: K.tabBarID) as! TabBarViewController
                self.present(tabBar, animated: true, completion: nil)
            }
            
        }
        
    }
    
}
