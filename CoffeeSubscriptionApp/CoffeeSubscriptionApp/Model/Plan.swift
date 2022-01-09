//
//  Order.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 05/01/2022.
//

import Foundation

class Plan {
    
    var userID = ""
    var selectedCafe = ""
    var planDuration = 5
    var startDate = Date()
    var deliveryTime = Date()
    var orderDetails = [MenuItem]()
    
    var userLocation : [String: Double] = ["lat": 1, "long": 1]
    
    var orderStatus = ""
    
    static var plan = Plan()
    
}
