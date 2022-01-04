//
//  HomeViewController.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 03/01/2022.
//

import UIKit

class HomeViewController: UIViewController {
  
    @IBOutlet weak var cafesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cafesCollectionView.delegate = self
        cafesCollectionView.dataSource = self
        
        
//        let jsonData = NetworkManager.readLocalJSONFile(forName: "cafeNames")
//        if let data = jsonData {
//            if let sampleRecordObj = NetworkManager.parse(jsonData: data) {
//                print("users list: \(sampleRecordObj.cafe)")
//                
//            }
//        }
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.cafeCellID, for: indexPath) as! CafeCell
        cell.name.text = "cafe 1"
        return cell
    }
    
    
}
