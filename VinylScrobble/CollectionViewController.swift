//
//  CollectionViewController.swift
//  VinylScrobble
//
//  Created by Haaris Muneer on 7/8/17.
//  Copyright © 2017 Haaris. All rights reserved.
//

import UIKit
import SnapKit

class CollectionViewController: UIViewController {
    
    var user: User!
    
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.user = User()
        user.collection.append(Album())
        user.collection.append(Album())
        user.collection.append(Album())
        user.collection.append(Album())
        user.collection.append(Album())
        user.collection.append(Album())
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: Constants.albumCollectionViewIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        self.setConstraints()
        
    }
    

    func setConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.user.collection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.albumCollectionViewIdentifier, for: indexPath) as! AlbumCollectionViewCell
        cell.album = self.user.collection[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        let halfScreenWidth = screenSize.width / 2.2
        return CGSize(width: halfScreenWidth, height: halfScreenWidth + 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAlbum = user.collection[indexPath.row]
        let detailVC = AlbumDetailViewController()
        detailVC.album = selectedAlbum
        self.show(detailVC, sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}


