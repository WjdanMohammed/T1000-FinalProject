//
//  PlanCreationStatusViewController.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 16/01/2022.
//

import UIKit
import Lottie
import SwiftUI

class PlanCreationStatusViewController: UIViewController {
    
    @IBOutlet weak var successAnimationView: AnimationView!
    
    @IBOutlet weak var failureAnimationView: AnimationView!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var statusDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true

        if Plan.plan.isConfirmed {

            setupSuccessAnimation()
            setupViews(message: "Confirmed", description: " can't wait to see you!")
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {

                self.navigationController?.popToRootViewController(animated: true)

            }
        }
        else{

            setupFailedAnimation()
            setupViews(message: "oops!", description: "somthing went wrong")
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {

                self.navigationController?.popToRootViewController(animated: true)

            }
        }
    }
    
    func setupViews(message: String, description: String){
        
        statusLabel.text = message
        statusDescription.text = description
        
    }
    
    func setupSuccessAnimation(){
        
        failureAnimationView.isHidden = true
        successAnimationView.isHidden = false
        successAnimationView?.loopMode = .loop
        successAnimationView?.animationSpeed = 0.8
        successAnimationView?.play()
        
    }
    
    func setupFailedAnimation(){
        
        successAnimationView.isHidden = true
        failureAnimationView.isHidden = false
        failureAnimationView?.loopMode = .loop
        failureAnimationView?.animationSpeed = 1
        failureAnimationView?.play()
        
    }
}
