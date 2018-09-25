//
//  UserSettings.swift
//  IOS Guessing Game
//
//  Created by Jacob Finn on 9/25/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import UIKit
class UserSettings: NSObject, NSCoding {
    
    
    
    
    var wins: Int 
    var loses: Int
    var colorChoice: Int
    
    
    init(wins: Int, loses: Int) {
        self.wins = wins
        self.loses = loses
        self.colorChoice = 0
    }
    init(wins: Int, loses: Int, colorChoice: Int) {
        self.wins = wins
        self.loses = loses
        self.colorChoice = colorChoice
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.wins, forKey: "wins")
        aCoder.encode(self.loses, forKey: "loses")
        aCoder.encode(self.colorChoice, forKey: "colorChoice")
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        let wins = aDecoder.decodeInteger(forKey: "wins")
        let loses = aDecoder.decodeInteger(forKey: "loses")
        let colorChoice = aDecoder.decodeInteger(forKey: "colorChoice")
        self.init(wins: wins, loses: loses, colorChoice: colorChoice)
    }
    
    
    
    
}
