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
    var genreLabel: UILabel!
    var genreDescription: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLabel()
        setTextView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabel() {
        genreLabel = UILabel(frame: .zero)
        genreLabel.textAlignment = .center
        genreLabel.font = UIFont.boldSystemFont(ofSize: 24)
        contentView.addSubview(genreLabel)
        labelConstraints()
    }
    
    func setTextView() {
        genreDescription = UITextView()
        genreDescription.font = UIFont.init(name: "Times New Roman", size: 18)
        contentView.addSubview(genreDescription)
        textViewConstraints()
    }
}
