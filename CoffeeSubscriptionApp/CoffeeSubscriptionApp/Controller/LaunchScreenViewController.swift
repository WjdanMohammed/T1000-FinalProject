//
//  LaunchScreenViewController.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 20/01/2022.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: K.getStarted, sender: self)
        }
        
    }
    
}
