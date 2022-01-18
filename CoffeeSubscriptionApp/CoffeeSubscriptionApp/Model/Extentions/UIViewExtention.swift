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
        get { return self.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    func dropShadow(scale: Bool = true) {
       layer.masksToBounds = false
//        layer.shadowColor = (UIColor(named: "shadowColor") as! CGColor)
        if window?.overrideUserInterfaceStyle == .dark {
            layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }
        else if window?.overrideUserInterfaceStyle == .light {
            layer.shadowColor = #colorLiteral(red: 0.7490196078, green: 0.7647058824, blue: 0.7960784314, alpha: 1)
        }
        
       layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowOpacity = 0.1
       layer.shadowRadius = 10

//       layer.shadowPath = UIBezierPath(rect: bounds).cgPath
       layer.shouldRasterize = true
       layer.rasterizationScale = scale ? UIScreen.main.scale : 1
     }
}
