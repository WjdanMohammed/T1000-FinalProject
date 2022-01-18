//
//  Constants.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 04/01/2022.
//

import Foundation

class K {
    
    static let cafeCellID = "cafeCellID"
    static let itemCellID = "itemCellID"
    static let navigateToSignUp = "signUp"
    static let navigateToLogIn = "logIn"
    static let navigateToProfileDetails = "profileDetails"
    static let navigateToMenu = "menu"
    static let navigateToPlanSetup = "planSetup1"
    static let navigateToPlanDetails = "planDetails"
    static let navigateToPlanStatus = "showStatus"
    static let selectedItemCell = "selectedItemCell"
    static let tabBarID = "tabBarID"
    
    static let tax : Float = 1.15
    static let deliveryFee : Float = 18
    
    static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "SAR"

        return formatter
    }()
}
