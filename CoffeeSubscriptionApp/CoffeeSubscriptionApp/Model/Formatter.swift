//
//  DateFormatter.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 09/01/2022.
//

import Foundation

class Formatter {
    
    static func format(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: date)
        
    }
    
    static func format(time: Date) -> String {
        
        let timeFormatter = DateFormatter()

        timeFormatter.timeStyle = .short
        
        return timeFormatter.string(from: time)
        
    }
    
}
