//
//  ViewController.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 02/01/2022.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var selectedDay: UISegmentedControl!
    
    @IBOutlet weak var category: UISegmentedControl!
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    var menuItems = [MenuItem]()
    
    var cart = [MenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        menuCollectionView.allowsMultipleSelection = true
        
        let jsonData = NetworkManager.readLocalJSONFile(forName: "menu1")
        if let data = jsonData {
            if let decodedData = NetworkManager.parseMenu(jsonData: data) {
                for item in decodedData{
                    
                    menuItems.append(item)
                    
                }
            }
        }
    }
    
    @IBAction func confirmSelectionButtonClicked(_ sender: Any) {

        Plan.plan.orderDetails.removeAll()
        Plan.plan.orderDetails.append(contentsOf: cart)
        performSegue(withIdentifier: K.navigateToPlanSetup, sender: self)
        
    }
   
}

extension MenuViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        menuItems.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.itemCellID, for: indexPath) as! MenuItemCell
        
        cell.itemName.text = menuItems[indexPath.row].name
        cell.itemPrice.text = "\(menuItems[indexPath.row].price ?? 0.00) SAR"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        cart.append(menuItems[indexPath.row])

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        cart.removeAll { $0.id == menuItems[indexPath.row].id }
    }
    
}


