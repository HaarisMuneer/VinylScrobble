//
//  SearchViewController.swift
//  VinylScrobble
//
//  Created by Haaris Muneer on 7/8/17.
//  Copyright © 2017 Haaris. All rights reserved.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    var searchField = UISearchBar()
    var tableView = UITableView()
    var albums: [Album] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let navBarHeight = self.navigationController?.navigationBar.frame.height
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: Constants.albumTableViewIdentifier)
        view.addSubview(self.tableView)
        
        self.searchField.delegate = self
        
        
        
        view.addSubview(searchField)
        
        self.searchField.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(Constants.statusBarHeight + navBarHeight!)
        }
        
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchField.snp.bottom).offset(10)
            make.left.bottom.right.equalToSuperview()
        }
        
        
        
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.albumTableViewIdentifier, for: indexPath) as! AlbumTableViewCell
        cell.album = self.albums[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? AlbumTableViewCell {
            cell.albumArtImageView.image = nil
            cell.albumArtImageView.sd_cancelCurrentImageLoad()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAlbum = albums[indexPath.row]
        let detailVC = AlbumDetailViewController()
        detailVC.album = selectedAlbum
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        APIClient.getDiscogsSearchResults(query: searchBar.text!) { (jsonResponse) in
            self.albums.removeAll()
            for albumJSON in jsonResponse["results"].array! {
                let albumDict = albumJSON.dictionaryObject
                let albumFormats = albumDict!["format"] as? [String]
                if let album = Album(json: albumDict!) {
                    if albumFormats!.contains("Vinyl") {
                        self.albums.append(album)
                    }
                }
                
            }
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
            
        }
    }
}
