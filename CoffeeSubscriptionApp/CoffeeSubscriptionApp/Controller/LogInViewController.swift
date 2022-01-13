//
//  LogInViewController.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 08/01/2022.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.addPadding(.both(12))
        passwordTextField.addPadding(.both(12))
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logIn(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            DatabaseManager.logIn(email: email, password: password) { result in
                if result {
                    
                    let tabBar = self.storyboard?.instantiateViewController(withIdentifier: K.tabBarID) as! TabBarViewController
                    self.present(tabBar, animated: true, completion: nil)
                    
                }
            }
        }
    }
}
