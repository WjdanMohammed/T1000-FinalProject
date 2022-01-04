//
//  Cafe.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 03/01/2022.
//

import Foundation

struct Cafe : Codable{
    
    var cafe: [CafeName]
    
}

struct CafeName :Codable{
    var cafeName : String
}
