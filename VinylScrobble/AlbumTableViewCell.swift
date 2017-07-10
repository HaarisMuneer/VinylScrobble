//
//  AlbumTableViewCell.swift
//  VinylScrobble
//
//  Created by Haaris Muneer on 7/9/17.
//  Copyright © 2017 Haaris. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage


class AlbumTableViewCell: UITableViewCell {
    
    var albumArtImageView = UIImageView()
    var titleLabel = UILabel()
    var artistLabel = UILabel()
    var labelAndYearLabel = UILabel()
    var labelsStackView = UIStackView()
    
    var album: Album! {
        didSet {
            fillOutCellFields()
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        labelsStackView = UIStackView(arrangedSubviews: [titleLabel, artistLabel, labelAndYearLabel])
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .fillProportionally
        
        self.addSubview(albumArtImageView)
        self.addSubview(labelsStackView)
        
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func setConstraints() {
        albumArtImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.75)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(self.albumArtImageView.snp.height)
        }
        
        labelsStackView.snp.makeConstraints { (make) in
            make.left.equalTo(albumArtImageView.snp.right).offset(10)
            make.height.equalTo(albumArtImageView)
            make.centerY.equalToSuperview()
        }
    }
    
    fileprivate func fillOutCellFields() {
        self.artistLabel.text = self.album.artist
        self.titleLabel.text = self.album.title
        self.labelAndYearLabel.text = "\(self.album.label) (\(self.album.year))"
        self.albumArtImageView.sd_setImage(with: self.album.thumbnailURL)
    }
    
}
