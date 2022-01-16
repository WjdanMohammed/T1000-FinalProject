//
//  DatabaseManager.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 08/01/2022.
//

import Foundation
import Firebase

class DatabaseManager {
    
    static func signUp(email : String, password : String, name : String, phoneNo : String){
        
        let db = Firestore.firestore()
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if error == nil {
                if let uid = Auth.auth().currentUser?.uid{
                    db.collection("Users").document(uid).setData([
                        
                        "name" : "\(name)",
                        "phoneNo": "\(phoneNo)",
                        "email": "\(email)"
                        
                    ])
                    { error in
                        if let error = error {
                            print("error\(error.localizedDescription)")
                        }
                    }
                }
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    static func logIn(email : String, password : String, completion: @escaping( Bool ) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { results, error in
            
            if error == nil {
                // get user's info
                completion(true)
            }
            else {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    static func createPlan() -> Bool {
        
        let db = Firestore.firestore()
        
        var status = true
        
        var orderDetails = ["1":[Any](),
                            "2":[Any](),
                            "3":[Any](),
                            "4":[Any](),
                            "5":[Any]()]

        for day in Plan.plan.orderDetails {
            
            for item in day.value{
                
                do {
                    let jsonData = try JSONEncoder().encode(item)
                    let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    orderDetails[day.key]?.append(jsonObject)
                    
                }
                catch {
                    // handle error
                }
            }
        }
        
        if let uid = Auth.auth().currentUser?.uid{
            
            db.collection("Users").document(uid).collection("Plan").addDocument(data: [
                
                "selectedCafe" : Plan.plan.selectedCafe,
                "planDuration" : Plan.plan.planDuration,
                "startDate" : Plan.plan.startDate,
                "deliveryTime" : Plan.plan.deliveryTime,
                "orderDetails" : orderDetails,
                "lat" : Plan.plan.userLocation["lat"] as Any,
                "long" : Plan.plan.userLocation["long"] as Any,
                "orderStatus" : Plan.plan.orderStatus
                
            ]){ error in
                if let error = error {
                    status = false
                    print(error.localizedDescription)
                }
            }
                
                db.collection("Plans").addDocument(data: [
                    "userID" : uid,
                    "selectedCafe" : Plan.plan.selectedCafe,
                    "planDuration" : Plan.plan.planDuration,
                    "startDate" : Plan.plan.startDate,
                    "deliveryTime" : Plan.plan.deliveryTime,
                    "orderDetails" : orderDetails,
                    "lat" : Plan.plan.userLocation["lat"] as Any,
                    "long" : Plan.plan.userLocation["long"] as Any,
                    "orderStatus" : Plan.plan.orderStatus
                    
                ]) { error in
                    if let error = error {
                        status = false
                        print(error.localizedDescription)
                    }
                }
            }
        return status
    }
}
