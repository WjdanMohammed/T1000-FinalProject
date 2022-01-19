//
//  MenuItemCell.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 04/01/2022.
//

import UIKit

class MenuItemCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var itemPrice: UILabel!
    
    @IBOutlet weak var selectedTag: UIImageView!
    
//    @IBOutlet weak var contentView: UIView!
    
    override var isSelected: Bool {
            didSet {
                if self.isSelected {
                    backgroundColor = #colorLiteral(red: 0.8182985187, green: 0.9071113467, blue: 1, alpha: 1)
                    selectedTag.isHidden = false
                }
                else {
                    backgroundColor = .white
                    selectedTag.isHidden = true
                }
            }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dropShadow()
    }
}
