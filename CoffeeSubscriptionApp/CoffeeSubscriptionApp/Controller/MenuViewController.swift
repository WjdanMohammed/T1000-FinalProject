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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
    }
}

extension MenuViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.itemCellID, for: indexPath) as! MenuItemCell
        
        return cell
    }
    
    
}


