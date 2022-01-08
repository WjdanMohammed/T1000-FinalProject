//
//  PlanDetailsViewController.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 04/01/2022.
//

import UIKit

class PlanDetailsViewController: UIViewController {
    
    @IBOutlet weak var orderDetailsCollectionView: UICollectionView!
    
    @IBOutlet weak var startingDate: UILabel!
    
    @IBOutlet weak var deliveryTime: UILabel!
    
    @IBOutlet weak var subTotal: UILabel!
    
    @IBOutlet weak var total: UILabel!
    
    //    var selectedItems = [MenuItem]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderDetailsCollectionView.delegate = self
        orderDetailsCollectionView.dataSource = self
        
        setup()
        
    }
    
    func setup(){
        
        //        for item in Plan.plan.orderDetails {
        //            orderDetails.text = item.name
        //        }
        //        orderDetails.text = Plan.plan.orderDetails[0].name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        startingDate.text = dateFormatter.string(from: Plan.plan.startDate)
        deliveryTime.text = Plan.plan.deliveryTime
        subTotal.text = K.priceFormatter.string(from: NSNumber(value: calculatTotal() == 0.0 ? calculatTotal() : calculatTotal() - K.deliveryFee))
        total.text =  K.priceFormatter.string(from: NSNumber(value: calculatTotal()))
        
        
    }
    
    func calculatTotal() -> Float {
        
        var singleOrderTotal : Float = 0
        var planTotal : Float = 0
        var total : Float = 0
        
        print(Plan.plan.orderDetails)
        
        for item in Plan.plan.orderDetails {
            if let price = item.price{
                singleOrderTotal += price
            }
        }

        
        // this will change if i let the user choose a deifferent order for each day 
        planTotal = singleOrderTotal * Float(Plan.plan.planDuration)

        if planTotal > 0 {
            total = ( planTotal * K.tax ) + K.deliveryFee
            return total
        }
        
        return 0.0
    }
}

extension PlanDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Plan.plan.orderDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.selectedItemCell, for: indexPath) as! SelectedItemCell
        
        cell.itemName.text = Plan.plan.orderDetails[indexPath.row].name
        if let price = Plan.plan.orderDetails[indexPath.row].price {
            cell.itemPrice.text = String(price)
        }
        
        return cell
    }
}
