//
//  Types.swift
//  VinylScrobble
//
//  Created by Haaris Muneer on 7/7/17.
//  Copyright © 2017 Haaris. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Album {
    
//    var sides: [Side]
    var title: String
    
    init?(json: [String : Any]) {
        guard let title = json["title"] as? String else { print("there was an error initializing an album from the json object"); return nil }
        
        self.title = title
            
        
        
    }
}

struct Side {
    
    var tracks: [Track]
    
}

struct Track {
    
    var title: String
    
}
