//
//  HomeViewController.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 03/01/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var cafesCollectionView: UICollectionView!
    
    var cafes = [Cafe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cafesCollectionView.delegate = self
        cafesCollectionView.dataSource = self
        
        let jsonData = NetworkManager.readLocalJSONFile(forName: "cafeNames")
        if let data = jsonData {
            if let decodedData = NetworkManager.parse(jsonData: data) {
                for cafe in decodedData{
                    
                    cafes.append(cafe)
                    
                }
            }
        }
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cafes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.cafeCellID, for: indexPath) as! CafeCell
        cell.name.text = cafes[indexPath.row].cafeName
        return cell
    }
    
}
