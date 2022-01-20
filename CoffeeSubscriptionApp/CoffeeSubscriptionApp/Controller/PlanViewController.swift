//
//  PlanViewController.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 20/01/2022.
//

import UIKit

class PlanViewController: UIViewController{
    
//    @IBOutlet weak var cafeName: UILabel!
//
//    @IBOutlet weak var startingDate: UILabel!
//
//    @IBOutlet weak var deliveryTime: UILabel!
//
//    @IBOutlet weak var planState: UILabel!
//
//    @IBOutlet weak var currentPlanView: UIView!
    
    @IBOutlet weak var cafeName: UILabel!
    
    @IBOutlet weak var startingDate: UILabel!
    
    @IBOutlet weak var deliveryTime: UILabel!
    
    @IBOutlet weak var planState: UILabel!
    
    @IBOutlet weak var currentPlanView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
    }
    
    func setup(){

        DatabaseManager.getPlanInfo { infoAvailable in
            if infoAvailable{
                
                self.cafeName.text = Plan.plan.selectedCafe
                self.startingDate.text = Plan.plan.startDate
                self.deliveryTime.text = Plan.plan.deliveryTime
                self.planState.text = Plan.plan.planState
                
            }
            else{
                self.currentPlanView.isHidden = true
            }
        }
    }
    @IBAction func pausePlanbuttonClicked(_ sender: Any) {
        
        DatabaseManager.pausePlan()
        setup()
        
    }
}
