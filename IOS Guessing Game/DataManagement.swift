//
//  DataManagement.swift
//  IOS Guessing Game
//
//  Created by Jacob Finn on 9/25/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import Foundation

class DataManagement {
    
    static func saveData(userSettings: UserSettings) {
        let savedUserSettings = userSettings
        let userData = NSKeyedArchiver.archivedData(withRootObject: savedUserSettings)
        UserDefaults.standard.set(userData, forKey: "userData")
    }
    
    static func loadData() -> UserSettings? {
        guard let userSavedData = UserDefaults.standard.value(forKey: "userData") else {
            return nil
        }
        let userSettings = NSKeyedUnarchiver.unarchiveObject(with: userSavedData as! Data)
        return userSettings as? UserSettings
    }
    
    static func saveExists() -> Bool {
        guard UserDefaults.standard.value(forKey: "userData") != nil else {
            return false
        }
        return true
    }
    
    
    
}
