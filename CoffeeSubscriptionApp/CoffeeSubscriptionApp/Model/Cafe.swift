//
//  Cafe.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 03/01/2022.
//

import Foundation


struct Cafe : Codable{
    
    var cafeName: String?
    var cafeId : String?
    var menu : [MenuItem]?
}


struct Order : Codable {
    
    var cafe : String?
    var deliveryTime : String?
    var lat : Double?
    var long : Double?
//    var orderDetails : [MenuItem]?
    
}
