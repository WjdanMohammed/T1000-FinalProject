//
//  UIViewExtention.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 11/01/2022.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius : CGFloat {
        get { return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    func dropShadow(scale: Bool = true) {
       layer.masksToBounds = false
       layer.shadowColor = #colorLiteral(red: 0.6575599313, green: 0.6575599909, blue: 0.6575599909, alpha: 1)
        
       layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowOpacity = 0.4
       layer.shadowRadius = 10

//       layer.shadowPath = UIBezierPath(rect: bounds).cgPath
       layer.shouldRasterize = true
       layer.rasterizationScale = scale ? UIScreen.main.scale : 1
     }
}
