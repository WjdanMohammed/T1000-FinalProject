//
//  ViewController.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 02/01/2022.
//

import UIKit

class MenuViewController: UIViewController {
    
//    @IBOutlet weak var selectedDay: UISegmentedControl!
//
//    @IBOutlet weak var category: UISegmentedControl!
    
    @IBOutlet weak var cafeName: UILabel!
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    var menuItems = [MenuItem]()
    
    var cart = [MenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        menuCollectionView.allowsMultipleSelection = true
        
        let jsonData = NetworkManager.readLocalJSONFile(forName: "cafeNames")
        if let data = jsonData {
            if let decodedData = NetworkManager.parse(jsonData: data) {
                for cafe in decodedData{
                    if cafe.cafeId == Plan.plan.selectedCafe{
                        
                        if let menu = cafe.menu{
                            for item in menu{
                                menuItems.append(item)
                            }
                        }
                        
                        cafeName.text = cafe.cafeName
                    }
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

extension MenuViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        menuItems.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.itemCellID, for: indexPath) as! MenuItemCell
        
        cell.itemName.text = menuItems[indexPath.row].name
        cell.itemPrice.text = K.priceFormatter.string(from: NSNumber(value: menuItems[indexPath.row].price ?? 0.00))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        cart.append(menuItems[indexPath.row])

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        cart.removeAll { $0.id == menuItems[indexPath.row].id }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: ( collectionView.frame.size.width - 20 ) / 2, height: ( collectionView.frame.size.height / 3 ) + 40)
    }
    
}


