//
//  PlanDetailsViewController.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 04/01/2022.
//

import UIKit

class PlanDetailsViewController: UIViewController {
    
    @IBOutlet weak var firstDayCollectionView: UICollectionView!
    
    @IBOutlet weak var secondDayCollectionView: UICollectionView!
    
    @IBOutlet weak var thirdDayCollectionView: UICollectionView!
    
    @IBOutlet weak var fourthDayCollectionView: UICollectionView!
    
    @IBOutlet weak var fifthDayCollectionView: UICollectionView!
    
    @IBOutlet weak var startingDate: UILabel!
    
    @IBOutlet weak var deliveryTime: UILabel!
    
    @IBOutlet weak var subTotal: UILabel!
    
    @IBOutlet weak var total: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    @IBAction func confirmPlan(_ sender: Any) {

        DatabaseManager.checkAuthentication(completion: { authenticated in
            
            if authenticated {

                DatabaseManager.checkEligibilityToCreateAPlan(completion: { eligiable in
                    if eligiable{
                        DatabaseManager.createPlan()

                        self.performSegue(withIdentifier: K.navigateToPlanStatus, sender: self)
                    }
                    else {

                        let alert = UIAlertController(title: "You already have an active plan", message: "Do you want to view your plan?", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: nil))
                        alert.addAction(UIAlertAction(title: "dismiss", style: UIAlertAction.Style.cancel, handler: nil))

                        self.present(alert, animated: true, completion: nil)
                    }
                    
                })
                
            }
            else {
                self.performSegue(withIdentifier: K.showLogInPage, sender: self)
            }
        })
        
    }
    
    
    func setup(){
        
        firstDayCollectionView.delegate = self
        firstDayCollectionView.dataSource = self
        
        secondDayCollectionView.delegate = self
        secondDayCollectionView.dataSource = self
        
        thirdDayCollectionView.delegate = self
        thirdDayCollectionView.dataSource = self
        
        fourthDayCollectionView.delegate = self
        fourthDayCollectionView.dataSource = self
        
        fifthDayCollectionView.delegate = self
        fifthDayCollectionView.dataSource = self
        
        startingDate.text = Plan.plan.startDate
        
        deliveryTime.text = Plan.plan.deliveryTime
        
        subTotal.text = K.priceFormatter.string(from: NSNumber(value: calculatTotal() == 0.0 ? calculatTotal() : calculatTotal() - K.deliveryFee))
        
        total.text =  K.priceFormatter.string(from: NSNumber(value: calculatTotal()))
        
    }
    
    func calculatTotal() -> Float {
        
        var subtotal : Float = 0
        var total : Float = 0
        
        print(Plan.plan.orderDetails)
        
        for day in Plan.plan.orderDetails {
            for item in day.value{
                if let price = item.price{
                    subtotal += price
                }
            }
        }
        
        if subtotal > 0 {
            total = ( subtotal * K.tax ) + K.deliveryFee
            return total
        }
        
        return 0.0
    }
}

extension PlanDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == firstDayCollectionView {
            return Plan.plan.orderDetails["1"]?.count ?? 1
        }
        else if collectionView == secondDayCollectionView {
            return Plan.plan.orderDetails["2"]?.count ?? 1
        }
        else if collectionView == thirdDayCollectionView {
            return Plan.plan.orderDetails["3"]?.count ?? 1
        }
        else if collectionView == fourthDayCollectionView {
            return Plan.plan.orderDetails["4"]?.count ?? 1
        }
        else {
            return Plan.plan.orderDetails["5"]?.count ?? 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == firstDayCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.selectedItemCell, for: indexPath) as! SelectedItemCell
            if let selectedItems = Plan.plan.orderDetails["1"] {
                cell.itemName.text = selectedItems[indexPath.row].name
                cell.itemPrice.text = K.priceFormatter.string(from: NSNumber(value: selectedItems[indexPath.row].price ?? 0.00))
            }
            return cell
        }
        
        else if collectionView == secondDayCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.selectedItemCell, for: indexPath) as! SelectedItemCell
            if let selectedItems = Plan.plan.orderDetails["2"] {
                cell.itemName.text = selectedItems[indexPath.row].name
                cell.itemPrice.text = K.priceFormatter.string(from: NSNumber(value: selectedItems[indexPath.row].price ?? 0.00))
            }
            return cell
        }
        
        else if collectionView == thirdDayCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.selectedItemCell, for: indexPath) as! SelectedItemCell
            if let selectedItems = Plan.plan.orderDetails["3"] {
                cell.itemName.text = selectedItems[indexPath.row].name
                cell.itemPrice.text = K.priceFormatter.string(from: NSNumber(value: selectedItems[indexPath.row].price ?? 0.00))
            }
            return cell
        }
        
        else if collectionView == fourthDayCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.selectedItemCell, for: indexPath) as! SelectedItemCell
            if let selectedItems = Plan.plan.orderDetails["4"] {
                cell.itemName.text = selectedItems[indexPath.row].name
                cell.itemPrice.text = K.priceFormatter.string(from: NSNumber(value: selectedItems[indexPath.row].price ?? 0.00))
            }
            return cell
        }
        
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.selectedItemCell, for: indexPath) as! SelectedItemCell
            if let selectedItems = Plan.plan.orderDetails["5"] {
                cell.itemName.text = selectedItems[indexPath.row].name
                cell.itemPrice.text = K.priceFormatter.string(from: NSNumber(value: selectedItems[indexPath.row].price ?? 0.00))
            }
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width , height: 60)
    }
}
