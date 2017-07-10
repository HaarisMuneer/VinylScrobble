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
    var artist: String
    var year: String?
    var label: String
    var thumbnailURL: URL?
    
    init?(json: [String : Any]) {
        guard let titleAndArtist = json["title"] as? String else { print("there was an error initializing an album from the json object"); fatalError() }
        guard let labelArray = json["label"] as? [String] else { print("there was an error initializing an album from the json object"); fatalError() }
        guard let thumbnailURL = json["thumb"] as? String else { print("there was an error initializing an album from the json object"); fatalError() }
        
        let titleAndArtistArray = titleAndArtist.components(separatedBy: " - ")
        let title = titleAndArtistArray.last
        let artist = titleAndArtistArray.first
        
        self.title = title!
        self.artist = artist!
        self.year = json["year"] as? String
        self.label = labelArray.first!
        self.thumbnailURL = URL(string: thumbnailURL)
        
    }
}

struct Side {
    
    var tracks: [Track]
    
}

struct Track {
    
    var title: String
    
}
