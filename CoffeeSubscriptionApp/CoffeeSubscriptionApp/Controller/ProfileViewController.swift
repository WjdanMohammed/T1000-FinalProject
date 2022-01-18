//
//  ProfileViewController.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 16/01/2022.
//

import UIKit
import Lottie
import Firebase

class ProfileViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var profileAnimationView: AnimationView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var authenticationView: UIStackView!
    
    @IBOutlet weak var profileView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DatabaseManager.checkAuthentication(completion: { authenticated in
            if authenticated {
                self.authenticationView.isHidden = true
                self.profileView.isHidden = false
                self.username.text = User.user.name
            }
            else {
                self.profileView.isHidden = true
                self.authenticationView.isHidden = false
                self.username.text = "hi there! "
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        setupViews()
        
    }
    
    func setupViews(){
        profileAnimationView?.loopMode = .playOnce
        profileAnimationView?.animationSpeed = 0.8
        profileAnimationView?.play()
    
    }
    
    
    
    @IBAction func navigateToLogInButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: K.navigateToLogIn, sender: self)
    }
    
    @IBAction func navigateToSignUpButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: K.navigateToSignUp, sender: self)
    }
    
    
    @IBAction func navigateToProfileDetailsButtonClicked(_ sender: Any) {
        
        performSegue(withIdentifier: K.navigateToProfileDetails, sender: self)
    }
    
    
    @IBAction func logOutButtonClicked(_ sender: Any) {
        
        DatabaseManager.signOut()
        
    }
    
    
    
}
