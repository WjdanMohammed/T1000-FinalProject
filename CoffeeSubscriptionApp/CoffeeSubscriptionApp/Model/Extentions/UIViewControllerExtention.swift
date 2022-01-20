//
//  UIViewControllerExtention.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 19/01/2022.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension Date {
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)! // to print next day date
    }
    var twoDaysAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 2, to: self)! // to print next day date
    }
    var threeDaysAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 3, to: self)! // to print next day date
    }
    var fourDaysAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 4, to: self)! // to print next day date
    }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)! // to print yesterfay date
    }
    var weekBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -7, to: self)!  // berfre 1 week
    }
    var weekBefore2Days: Date {
        return Calendar.current.date(byAdding: .day, value: -2, to: self)!  // berfre 1 week
    }
    var weekBefore3Days: Date {
        return Calendar.current.date(byAdding: .day, value: -3, to: self)!  // berfre 1 week
    }
}
