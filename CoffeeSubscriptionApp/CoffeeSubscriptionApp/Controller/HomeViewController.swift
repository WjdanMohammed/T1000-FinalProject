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
    var selectedCafe = ""
    
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


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cafes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.cafeCellID, for: indexPath) as! CafeCell
        cell.logo.image = Images.logos[indexPath.row]
        cell.name.text = cafes[indexPath.row].cafeName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Plan.plan.selectedCafe = cafes[indexPath.row].cafeId ?? "cafe not found"
        
        // pass selected cafe to menu vc
        self.performSegue(withIdentifier: K.navigateToMenu, sender: (Any).self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 40 , height: collectionView.frame.height/8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}
