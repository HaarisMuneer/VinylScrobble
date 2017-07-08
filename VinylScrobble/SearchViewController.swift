//
//  SearchViewController.swift
//  VinylScrobble
//
//  Created by Haaris Muneer on 7/8/17.
//  Copyright © 2017 Haaris. All rights reserved.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    var albums: [Album] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "basicCell")
        view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        APIClient.getDiscogsSearchResults(query: "oddisee") { (jsonResponse) in
            print(jsonResponse)
            for albumDict in jsonResponse["results"].array! {
                if let album = Album(json: albumDict.dictionaryObject!) {
                    self.albums.append(album)
                }
                
            }
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        let album  = albums[indexPath.row]
        cell.textLabel?.text = album.title
        return cell
    }
    

}
