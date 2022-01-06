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
    
//    var cart = [MenuItem]()
//    var indexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
//        menuCollectionView.allowsMultipleSelection = true
        
        let jsonData = NetworkManager.readLocalJSONFile(forName: "menu1")
        if let data = jsonData {
            if let decodedData = NetworkManager.parseMenu(jsonData: data) {
                for item in decodedData{
                    
                    menuItems.append(item)
                    
                }
            }
        }
    }
    
//    func getSelectedItems(){
//        //        let cart = menuCollectionView.indexPathsForSelectedItems
//        //        if let selectedItems = cart {
//        //        for indexPath in selectedItems{
//        switch selectedDay.selectedSegmentIndex{
//
//        case Day.firstDay.rawValue :
//            Order.order.orderDetails[0] = [menuItems[indexPath.row]]
//            print("day 1 checkkk")
//
//        case Day.secondDay.rawValue :
//            Order.order.orderDetails[1] = [menuItems[indexPath.row]]
//
//        case Day.thirdDay.rawValue :
//            Order.order.orderDetails[2] = [menuItems[indexPath.row]]
//
//        case Day.fourthDay.rawValue :
//            Order.order.orderDetails[3] = [menuItems[indexPath.row]]
//
//        case Day.fifthDay.rawValue :
//            Order.order.orderDetails[4] = [menuItems[indexPath.row]]
//        default:
//            print("")
//        }
//
//        print(Order.order.orderDetails)
//    }
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

        Plan.plan.orderDetails.append(menuItems[indexPath.row])
        print(Plan.plan.selectedCafe)
//        self.indexPath = indexPath
        
    }
    
}

//enum Day : Int {
//    case firstDay = 0, secondDay = 1, thirdDay = 2, fourthDay = 3, fifthDay = 4
//}

