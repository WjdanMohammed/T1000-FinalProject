//
//  DatabaseManager.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 08/01/2022.
//

import Foundation
import Firebase

class DatabaseManager {
    
    //MARK: Sign up
    
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
    
    //MARK: Log in
    
    static func logIn(email : String, password : String, completion: @escaping( Bool ) -> Void){
        
        let db = Firestore.firestore()
        
        Auth.auth().signIn(withEmail: email, password: password) { results, error in
            
            if error == nil {
                db.collection("Users").whereField("email", isEqualTo: email).getDocuments { querySnapshot, error in
                    
                    if let querySnapshotDocs = querySnapshot?.documents {
                        User.user.name = querySnapshotDocs[0].get("name") as! String
                        User.user.email = querySnapshotDocs[0].get("email") as! String
                        User.user.phoneNo = querySnapshotDocs[0].get("phoneNo") as! String
                    }
                    
                }
                
                completion(true)
            }
            else {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    //MARK: Check authentication
    
    static func checkAuthentication(completion: @escaping( Bool ) -> Void) {
        Auth.auth().addStateDidChangeListener() { _, user in
            if user != nil {
                completion( true )
            }
            else{
                completion( false )
            }
        }
    }
    
    //MARK: Update user's info
    
    static func updateUsersProfile(_ name : String ,_ email : String ,_ phoneNo : String ){
        
        let db = Firestore.firestore()
        if let uid = Auth.auth().currentUser?.uid{
            db.collection("Users").document(uid).updateData([
                
                "name" : "\(name)",
                "phoneNo": "\(phoneNo)",
                "email": "\(email)"
                
            ]) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document successfully updated")
                }
            }
        }
    }
    
    //MARK: Create a plan
    
    static func createPlan() {
        
        let db = Firestore.firestore()
        
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
                "orderStatus" : "Confirmed"
                
            ]){ error in
                if let error = error {
                    print(error.localizedDescription)
                }
//                else{
//                    Plan.plan.isConfirmed = true
//                }
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
                "orderStatus" : "Confirmed"
                
            ]) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
//                else{
//                    Plan.plan.isConfirmed = true
//                }
            }
        }
        Plan.plan.isConfirmed = true
        
    }
    
    //MARK: Sign out
    
    static func signOut(){
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    //MARK: Delete account
    
    static func deleteAccount(){
        
        let db = Firestore.firestore()
        
        Auth.auth().currentUser?.delete { error in
            if error != nil {
                // handle errror
            } else {
                // Account deleted.
            }
        }
        
        if let uid = Auth.auth().currentUser?.uid {
            db.collection("Users").document(uid).delete()
        }
        
    }
}
