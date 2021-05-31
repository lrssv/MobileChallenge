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
    var myArray: [String] = []
    
    func setCustomer(customer: Customer){
        if let data = UserDefaults.standard.value(forKey:"customers") as? Data {
            do {
                var customers = try PropertyListDecoder().decode(Array<Customer>.self, from: data)
                customers.append(customer)
                UserDefaults.standard.set(try PropertyListEncoder().encode(customers), forKey:"customers")
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
    
    
    
    
    
    /*
    func setClientsName(name: String) {
        myDict = defaults.dictionary(forKey: "clients")
        defaults.
    }
    
    func getClientsName() -> [String]{
        return myArray
    }*/
    
    /*
    var clientName: String {
        get {
            return defaults.string(forKey: UserDefaultsKeys.clientDocument.rawValue)!
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.clientDocument.rawValue)
        }
    }
 
    
    var clientDocument: String {
        get {
            return defaults.string(forKey: UserDefaultsKeys.clientDocument.rawValue)!
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.clientDocument.rawValue)
        }
    }
    

    
    var itemName: String {
        get {
            return defaults.string(forKey: UserDefaultsKeys.itemName.rawValue)!
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.itemName.rawValue)
        }
    }
    
    var itemValue: String {
        get {
            return defaults.string(forKey: UserDefaultsKeys.itemValue.rawValue)!
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.itemValue.rawValue)
        }
    }*/
}

