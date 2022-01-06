//
//  PlanDurationViewController.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 04/01/2022.
//

import UIKit

class PlanDurationViewController: UIViewController {
    
    @IBOutlet weak var startingDate: UIDatePicker!
    
    @IBOutlet weak var deliveryTimePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    @IBAction func continueToPlanDetailsButtonClicked(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        timeFormatter.timeStyle = .short
        
        print(dateFormatter.string(from: startingDate.date))
        print(timeFormatter.string(from: deliveryTimePicker.date))
        
        Plan.plan.startDate = startingDate.date

        Plan.plan.deliveryTime = timeFormatter.string(from: deliveryTimePicker.date)
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
