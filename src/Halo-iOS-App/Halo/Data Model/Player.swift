//
//  Player.swift
//  Halo
//
//  Created by Sattawat Suppalertporn on 24/7/17.
//  Copyright © 2017 dashboardearth. All rights reserved.
//

import Foundation

class Player {
    public var userName:String = ""
    public var firstName:String = ""
    public var lastName:String = ""
    public var activeDays:Double = 0
    public var firstSeenDate:Date = Date()
    public var score:Int = 0
}

extension Player {
    
    private static var s_player:Player?
    private static let defaultsKeyForUserName:String = "PlayerUserName"
    private static let defaultsKeyForFirstSeenDate:String = "PlayerFirstSeenDate"
    private static let defaultsKeyIsFirstLaunchCompleted:String = "PlayerIsFirstLaunchCompleted"
    
    class func SharedInstance() -> Player {
        if Player.s_player == nil {
            let p = Player()
            let defaults = UserDefaults.standard
            
            if let userName = defaults.string(forKey: Player.defaultsKeyForUserName) {
                p.userName = userName
            } else {
                p.userName = "oneCodeSlinger"
            }
            
            if let firstSeenDate = defaults.object(forKey: Player.defaultsKeyForFirstSeenDate) as? Date {
                p.firstSeenDate = firstSeenDate
            } else {
                let firstSeenDate = Date()
                defaults.set(firstSeenDate, forKey: Player.defaultsKeyForFirstSeenDate)
                p.firstSeenDate = firstSeenDate
            }
            
            p.activeDays = (Date().timeIntervalSince(p.firstSeenDate) / (24.0 * 60.0 * 60.0)) + 1.0; // adding one to start from 1 day
            
            Player.s_player = p
        }
        return Player.s_player!
    }
    
    class func isFirstLaunchCompleted() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: Player.defaultsKeyIsFirstLaunchCompleted)
    }
    
    class func setIsFirstLaunchCompleted() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: Player.defaultsKeyIsFirstLaunchCompleted)
    }
    
    
}
