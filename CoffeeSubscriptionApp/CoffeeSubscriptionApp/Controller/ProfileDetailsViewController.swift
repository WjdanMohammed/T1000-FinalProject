//
//  ProfileDetailsViewController.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 17/01/2022.
//

import UIKit

class ProfileDetailsViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var phoneNoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.addPadding(.both(12))
        emailTextField.addPadding(.both(12))
        phoneNoTextField.addPadding(.both(12))
        
        nameTextField.text = User.user.name
        emailTextField.text = User.user.email
        phoneNoTextField.text = User.user.phoneNo
        
        self.hideKeyboardWhenTappedAround()

    }
    
    @IBAction func saveChangesButtonClicked(_ sender: Any) {
        
        if let name = nameTextField.text, let email = emailTextField.text, let phoneNo = phoneNoTextField.text{
            DatabaseManager.updateUsersProfile(name, email, phoneNo)
        }
        
        self.dismiss(animated: true)
        
    }
    
    
    @IBAction func deleteAccountButtonClicked(_ sender: Any) {
        
        let alert = UIAlertController(title: "Note", message: "Are you sure you want to delete your account?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
            DatabaseManager.deleteAccount()
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
//        self.dismiss(animated: true, completion: nil)
    }
    
}
