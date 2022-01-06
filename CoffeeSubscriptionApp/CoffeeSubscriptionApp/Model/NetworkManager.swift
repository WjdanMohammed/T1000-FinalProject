//
//  NetworkManager.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 03/01/2022.
//

import Foundation

class NetworkManager {
    
    static func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error.localizedDescription)")
        }
        return nil
    }
    
    static func parseCafe(jsonData: Data) -> [Cafe]? {
        do {
            let decodedData = try JSONDecoder().decode([Cafe].self, from: jsonData)
            return decodedData
        } catch {
            print("error: \(error.localizedDescription)")
        }
        return nil
    }
    
    static func parseMenu(jsonData: Data) -> [MenuItem]? {
        do {
            let decodedData = try JSONDecoder().decode([MenuItem].self, from: jsonData)
            return decodedData
        } catch {
            print("error: \(error.localizedDescription)")
        }
        return nil
    }
    
    
}
