//
//  CafeCell.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 03/01/2022.
//

import UIKit

class CafeCell: UICollectionViewCell {
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        dropShadow()
    }
}
