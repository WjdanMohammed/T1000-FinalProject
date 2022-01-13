//
//  StringExtention.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 08/01/2022.
//

import Foundation

extension String {
    
    func isValidEmail() -> Bool {
        
        let regularEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", regularEx)
        return emailPredicate.evaluate(with: self)
        
    }
    
}
