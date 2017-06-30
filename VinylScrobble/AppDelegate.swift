//
//  AppDelegate.swift
//  VinylScrobble
//
//  Created by Haaris Muneer on 12/13/16.
//  Copyright © 2016 Haaris. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        APIClient.getDiscogsSearchResults(query: "oddisee") { (response) in
            
        }
        
        return true
    }
}

