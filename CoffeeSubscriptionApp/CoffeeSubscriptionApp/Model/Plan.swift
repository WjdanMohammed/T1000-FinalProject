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
    var deliveryTime = ""
    var orderDetails = [MenuItem]()
    
//    var orderDetails = [0 : [MenuItem](),
//                        1 : [MenuItem](),
//                        2 : [MenuItem](),
//                        3 : [MenuItem](),
//                        4 : [MenuItem]()]
    
    var orderStatus = ""
    
    static var plan = Plan()
    
}
