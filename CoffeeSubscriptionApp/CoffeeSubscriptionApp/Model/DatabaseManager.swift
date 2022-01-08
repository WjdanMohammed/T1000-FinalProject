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
                
                db.collection("Users")
                    .addDocument(data:
                                    [
                                        "name" : "\(name)",
                                        "phoneNo": "\(phoneNo)",
                                        "email": "\(email)"
                                        
                                        
                                    ])
                { error in
                    if let error = error {
                        print("error\(error.localizedDescription)")
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
                print(error?.localizedDescription)
            }
        }
    }
}
