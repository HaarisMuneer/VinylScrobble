//
//  AlbumCollectionViewCell.swift
//  VinylScrobble
//
//  Created by Haaris Muneer on 7/10/17.
//  Copyright © 2017 Haaris. All rights reserved.
//

import UIKit
import SnapKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    var albumArtImageView: UIImageView!
    var titleLabel: UILabel!
    var artistLabel: UILabel!
    var labelAndYearLabel: UILabel!
    var labelsStackView: UIStackView!
    
    var album: Album! {
        didSet {
            self.fillOutCellFields()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = .white
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        artistLabel = UILabel()
        artistLabel.font = UIFont.systemFont(ofSize: 12)
        labelAndYearLabel = UILabel()
        labelAndYearLabel.font = UIFont.systemFont(ofSize: 12)
        
        labelsStackView = UIStackView(arrangedSubviews: [titleLabel, artistLabel, labelAndYearLabel])
        labelsStackView.axis = .vertical
        labelsStackView.alignment = .center
        labelsStackView.distribution = .fillProportionally
        
        albumArtImageView = UIImageView()
        self.addSubview(albumArtImageView)
        self.addSubview(labelsStackView)
        
        self.layer.cornerRadius = 5
        
        setConstraints()
    }
    
    func setConstraints() {
        albumArtImageView.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(albumArtImageView.snp.width)
        }
        
        labelsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(albumArtImageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            
        }
    }
    
    
    fileprivate func fillOutCellFields() {
        self.artistLabel.text = self.album.artist
        self.titleLabel.text = self.album.title
        var labelAndYear = self.album.label
        if let year = self.album.year { labelAndYear = labelAndYear + " (\(year))" }
        self.labelAndYearLabel.text = labelAndYear
        self.albumArtImageView.sd_setImage(with: self.album.thumbnailURL)
    }
}
