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
        
        var firstDayOrderDetails = [Any]()
        var secondDayOrderDetails = [Any]()
        var thirdDayOrderDetails = [Any]()
        var fourthDayOrderDetails = [Any]()
        var fifthDayOrderDetails = [Any]()

//
        let planDays = [Formatter.format(date: Plan.plan.startDateDateFormat),
                        Formatter.format(date: Plan.plan.startDateDateFormat.dayAfter),
                        Formatter.format(date: Plan.plan.startDateDateFormat.twoDaysAfter),
                        Formatter.format(date: Plan.plan.startDateDateFormat.threeDaysAfter),
                        Formatter.format(date: Plan.plan.startDateDateFormat.fourDaysAfter)]
//
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
        
        for day in Plan.plan.orderDetails{
            
            switch day.key {
                
            case "1" :
                    for item in day.value {
                        
                        do {
                            let jsonData = try JSONEncoder().encode(item)
                            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                            firstDayOrderDetails.append(jsonObject)
                        }
                        catch {
                            // handle error
                        }
                    }
                
                case "2" :
                    for item in day.value {
                        
                        do {
                            let jsonData = try JSONEncoder().encode(item)
                            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                            secondDayOrderDetails.append(jsonObject)
                        }
                        catch {
                            // handle error
                        }
                    }
                
            case "3" :
                    for item in day.value {
                        
                        do {
                            let jsonData = try JSONEncoder().encode(item)
                            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                            thirdDayOrderDetails.append(jsonObject)
                        }
                        catch {
                            // handle error
                        }
                    }
                
            case "4" :
                    for item in day.value {
                        
                        do {
                            let jsonData = try JSONEncoder().encode(item)
                            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                            fourthDayOrderDetails.append(jsonObject)
                        }
                        catch {
                            // handle error
                        }
                    }
                
            default :
                    for item in day.value {
                        
                        do {
                            let jsonData = try JSONEncoder().encode(item)
                            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                            fifthDayOrderDetails.append(jsonObject)
                        }
                        catch {
                            // handle error
                        }
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
                "planStatus" : "Confirmed",
                "planState" : "active"
                
            ]){ error in
                if let error = error {
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
                "planStatus" : "Confirmed",
                "planState" : "active"
                
            ]) { error in
                if let error = error {
                    print(error.localizedDescription)
                }

            }
            
            for day in planDays.enumerated() {
                
                switch day.offset {
                case 0 :
                    db.collection("Orders").addDocument(data: [
                        "userID" : uid,
                        "selectedCafe" : Plan.plan.selectedCafe,
                        "deliveryDay" : day.element,
                        "deliveryTime" : Plan.plan.deliveryTime,
                        "orderDetails" : firstDayOrderDetails,
                        "lat" : Plan.plan.userLocation["lat"] as Any,
                        "long" : Plan.plan.userLocation["long"] as Any,
                        "deliveryStatus" : "",
                        "planState" : "active"
                        
                    ]) { error in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                        
                    }
                    
                case 1 :
                    db.collection("Orders").addDocument(data: [
                        "userID" : uid,
                        "selectedCafe" : Plan.plan.selectedCafe,
                        "deliveryDay" : day.element,
                        "deliveryTime" : Plan.plan.deliveryTime,
                        "orderDetails" : secondDayOrderDetails,
                        "lat" : Plan.plan.userLocation["lat"] as Any,
                        "long" : Plan.plan.userLocation["long"] as Any,
                        "deliveryStatus" : "",
                        "planState" : "active"
                        
                    ]) { error in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                        
                    }
                    
                case 2 :
                    db.collection("Orders").addDocument(data: [
                        "userID" : uid,
                        "selectedCafe" : Plan.plan.selectedCafe,
                        "deliveryDay" : day.element,
                        "deliveryTime" : Plan.plan.deliveryTime,
                        "orderDetails" : thirdDayOrderDetails,
                        "lat" : Plan.plan.userLocation["lat"] as Any,
                        "long" : Plan.plan.userLocation["long"] as Any,
                        "deliveryStatus" : "",
                        "planState" : "active"
                        
                    ]) { error in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                        
                    }
                    
                case 3 :
                    db.collection("Orders").addDocument(data: [
                        "userID" : uid,
                        "selectedCafe" : Plan.plan.selectedCafe,
                        "deliveryDay" : day.element,
                        "deliveryTime" : Plan.plan.deliveryTime,
                        "orderDetails" : fourthDayOrderDetails,
                        "lat" : Plan.plan.userLocation["lat"] as Any,
                        "long" : Plan.plan.userLocation["long"] as Any,
                        "deliveryStatus" : "",
                        "planState" : "active"
                        
                    ]) { error in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                        
                    }
                    
                case 4 :
                    db.collection("Orders").addDocument(data: [
                        "userID" : uid,
                        "selectedCafe" : Plan.plan.selectedCafe,
                        "deliveryDay" : day.element,
                        "deliveryTime" : Plan.plan.deliveryTime,
                        "orderDetails" : fifthDayOrderDetails,
                        "lat" : Plan.plan.userLocation["lat"] as Any,
                        "long" : Plan.plan.userLocation["long"] as Any,
                        "deliveryStatus" : "",
                        "planState" : "active"
                        
                    ]) { error in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                        
                    }
                    
                default :
                    print("error")
                }
            }
        }
        Plan.plan.isConfirmed = true
    }
    
    //MARK: Check eligibility to create a new plan
    static func checkEligibilityToCreateAPlan(completion: @escaping( Bool ) -> Void){
        
        
        let db = Firestore.firestore()
        
        if let uid = Auth.auth().currentUser?.uid{
            
            db.collection("Users").document(uid).collection("Plan").getDocuments{ querySnapshot, error in
                
                if error == nil {
                    
                    if let docs = querySnapshot?.documents, !docs.isEmpty{
                        completion(false)
                    }
                    else{
                        completion(true)
                    }
                }
            }
        }
    }
    
    //MARK: get plan info
    static func getPlanInfo(completion: @escaping( Bool ) -> Void){
        
        let db = Firestore.firestore()
        
        if let uid = Auth.auth().currentUser?.uid{

            db.collection("Users").document(uid).collection("Plan").addSnapshotListener{ querySnapshot, error in
                
                if error != nil {
                    print("error")
                }

                if let querySnapshotDocs = querySnapshot?.documents, !querySnapshotDocs.isEmpty {
                    
                    Plan.plan.selectedCafe = querySnapshotDocs[0].get("selectedCafe") as! String

                    Plan.plan.deliveryTime = querySnapshotDocs[0].get("deliveryTime") as! String

                    Plan.plan.startDate = querySnapshotDocs[0].get("startDate") as! String

                    Plan.plan.planState = querySnapshotDocs[0].get("planState") as! String
                    
                    completion(true)
                }
                else{
                    completion(false)
                }
                
            }
   
        }
        
    }
    //MARK: Pause plan
    
    static func pausePlan(){
        
        let db = Firestore.firestore()
        if let uid = Auth.auth().currentUser?.uid{
            db.collection("Users").document(uid).collection("Plan").document().updateData([
                
                "planState" : "paused",
                
            ]) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document successfully updated")
                }
            }
        }
        
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
    
    
    //MARK: get todays orders
    
    static func getTodaysOrders(completion: @escaping( [Order] ) -> Void){
        
        let db = Firestore.firestore()
        
        var orders = [Order]()
        
        db.collection("Orders").whereField("planState", isEqualTo: "active").getDocuments { querySnapshot, error in
//        whereField("deliveryDay", isEqualTo: Formatter.format(date: Date())).
//        whereField("planState", isEqualTo: "active").
//        whereField("deliveryStatus", isEqualTo: "").
            
            
            if error != nil {
                print("errorrr")
            }
            
            if let docs = querySnapshot?.documents{
                print(docs[0].get("selectedCafe") as? String as Any)
                for doc in docs{
                    
                    let order = Order.init(cafe: doc.get("selectedCafe") as? String,
                                           deliveryTime: doc.get("deliveryTime") as? String,
                                           lat: doc.get("lat") as? Double,
                                           long: doc.get("long") as? Double
                                           //                          ,orderDetails: docs[0].get("selectedCafe") as? [MenuItem]
                    )

                    orders.append(order)
                }
                
                completion(orders)
            }
            else{
                //                completion(false)
            }
            
        }
        
    }
}
