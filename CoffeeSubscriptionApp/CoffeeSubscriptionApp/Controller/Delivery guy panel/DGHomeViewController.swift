//
//  DGHomeViewController.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 24/01/2022.
//

import UIKit

class DGHomeViewController: UIViewController {

    @IBOutlet weak var ordersCollectionView: UICollectionView!
    
    var orders = [Order]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ordersCollectionView.delegate = self
        ordersCollectionView.dataSource = self
        
        DatabaseManager.getTodaysOrders { orders in
            self.orders = orders
            print("hiiii", self.orders)
        }
        ordersCollectionView.reloadData()
    }

}

extension DGHomeViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        orders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.orderCellID, for: indexPath) as! OrderCell
        cell.cafeName.text = orders[indexPath.row].cafe
        cell.deliveryTime.text = orders[indexPath.row].deliveryTime
        
        print("hiii")
        print(orders[indexPath.row].cafe ?? "blaaa")
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        Plan.plan.selectedCafe = orders[indexPath.row] ?? "cafe not found"
//
//        // pass selected cafe to menu vc
//        self.performSegue(withIdentifier: K.navigateToMenu, sender: (Any).self)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 40 , height: collectionView.frame.height/8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
}
