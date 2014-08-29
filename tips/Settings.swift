//
//  Settings.swift
//  tips
//
//  Created by Dan Schultz on 8/27/14.
//  Copyright (c) 2014 Dan Schultz. All rights reserved.
//

import Foundation

class Settings {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var tipAmount: Double {
        get {
            return defaults.doubleForKey("tipAmount")
        }
        set(value) {
            defaults.setDouble(value, forKey: "tipAmount");
        }
    }
    
    let defaultPercentages = [0.18, 0.20, 0.22]
    
    init() {
        defaults.registerDefaults(["tipAmount": 0.18])
    }
    
    func save() {
        defaults.synchronize()
    }
}