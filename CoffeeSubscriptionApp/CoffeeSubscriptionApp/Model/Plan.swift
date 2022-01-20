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
    var startDate = ""
    var startDateDateFormat = Date()
    var deliveryTime = ""
    var planState = ""
    var orderDetails = ["1": [MenuItem](),
                        "2": [MenuItem](),
                        "3": [MenuItem](),
                        "4": [MenuItem](),
                        "5": [MenuItem]()]
    
    var userLocation : [String: Double] = ["lat": 1, "long": 1]
    
    var sameOrderForPlan = false
    var isConfirmed = false
    
    static var plan = Plan()
    
}
