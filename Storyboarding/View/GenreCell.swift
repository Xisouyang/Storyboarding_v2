//
//  GenreCell.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class GenreCell: UICollectionViewCell {
    
    static var identifier: String = "cell"
    var genreView: UIView!
    var genreLabel: UILabel!
    var genreDescription: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setGenreView()
        setLabel()
        setTextView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setGenreView() {
        genreView = UIView(frame: .zero)
        genreView.layer.cornerRadius = 6
        genreView.layer.masksToBounds = true
        genreView.backgroundColor = .white
        contentView.addSubview(genreView)
        genreViewConstraints()
    }
    
    func setLabel() {
        genreLabel = UILabel(frame: .zero)
        genreLabel.textAlignment = .center
        genreLabel.font = UIFont.boldSystemFont(ofSize: 24)
        genreView.addSubview(genreLabel)
        labelConstraints()
    }
    
    func setTextView() {
        genreDescription = UILabel(frame: .zero)
        genreDescription.font = UIFont.init(name: "Times New Roman", size: 18)
        genreView.addSubview(genreDescription)
        genreDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
        genreDescription.numberOfLines = 0
        textViewConstraints()
    }
}
