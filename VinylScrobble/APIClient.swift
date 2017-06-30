//
//  APIClient.swift
//  VinylScrobble
//
//  Created by Haaris Muneer on 6/29/17.
//  Copyright © 2017 Haaris. All rights reserved.
//

import UIKit

class APIClient {
    
    class func getDiscogsSearchResults(query: String, completion: @escaping ([String : Any]) -> ()) {
        var urlString = "\(discogsBaseURL)/database/search?q=\(query)&type=release&key=\(discogsConsumerKey)&secret=\(discogsConsumerSecret)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: urlString)
        let params = ["q" : query, "type" : "release", "key" : discogsConsumerKey, "secret" : discogsConsumerSecret]
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                do {
                    if let responseDict = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any] {
                        print(responseDict)
                        completion(responseDict)
                    }
                    
                }
                catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            else {
                print(error?.localizedDescription)
            }
        }.resume()
    }
    
}
