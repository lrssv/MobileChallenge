//
//  Configuration.swift
//  MobileChallenge
//
//  Created by Larissa Silva | Gerencianet on 31/05/21.
//

import Foundation


enum UserDefaultsKeys: String {
    case clientName = "clientName"
    case clientDocument = "clientDocument"
    case itemName = "itemName"
    case itemValue = "itemValue"
}

class Configuration {
    
    let userDefaults = UserDefaults.standard
    static var shared: Configuration = Configuration()
    
    func setCustomer(customer: Customer){
        if let data = UserDefaults.standard.value(forKey:"customers") as? Data {
            do {
                var customers = try PropertyListDecoder().decode(Array<Customer>.self, from: data)
                if !customers.contains(customer) {
                    customers.append(customer)
                    UserDefaults.standard.set(try PropertyListEncoder().encode(customers), forKey:"customers")
                }
            } catch {
                print("error")
            }
        } else {
            UserDefaults.standard.set(try? PropertyListEncoder().encode([customer]), forKey:"customers")
        }
    }
    
    func getCustomer() -> [Customer]? {
        if let data = UserDefaults.standard.value(forKey:"customers") as? Data {
            let customers = try? PropertyListDecoder().decode(Array<Customer>.self, from: data)
            return customers
        }
        return nil
    }
    
    func setItem(item: Items){
        if let data = UserDefaults.standard.value(forKey:"items") as? Data {
            do {
                var items = try PropertyListDecoder().decode(Array<Items>.self, from: data)
                if !items.contains(item) {
                    items.append(item)
                    UserDefaults.standard.set(try PropertyListEncoder().encode(items), forKey:"items")
                }
            } catch {
                print("error")
            }
        } else {
            UserDefaults.standard.set(try? PropertyListEncoder().encode([item]), forKey:"items")
        }
    }
    
    func getItem() -> [Items]? {
        if let data = UserDefaults.standard.value(forKey:"items") as? Data {
            let items = try? PropertyListDecoder().decode(Array<Items>.self, from: data)
            return items
        }
        return nil
    }
    
    var access_token: String {
        get {
            return userDefaults.string(forKey: "access_token")!
        }
        
        set {
            userDefaults.set(newValue, forKey: "access_token")
        }
    }
}

