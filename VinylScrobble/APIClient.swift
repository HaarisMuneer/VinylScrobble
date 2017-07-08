//
//  APIClient.swift
//  VinylScrobble
//
//  Created by Haaris Muneer on 6/29/17.
//  Copyright © 2017 Haaris. All rights reserved.
//

import UIKit
import SwiftyJSON

class APIClient {
    
    class func getDiscogsSearchResults(query: String, completion: @escaping (JSON) -> ()) {
        var urlString = "\(discogsBaseURL)/database/search?q=\(query)&type=release&key=\(discogsConsumerKey)&secret=\(discogsConsumerSecret)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("There was an error: \(error.localizedDescription)")
            }
            if let data = data {
                completion(JSON(data))
            }
        }.resume()
    }
    
}
