//
//  GenreCell.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class GenreCell: UICollectionViewCell {
    
    //initialize neccessary variables
    
    static var identifier: String = "genreCell"
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
    
    //MARK: Cell UI elements
    
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
        descriptionConstraints()
    }
}

extension GenreCell {
    
    func genreViewConstraints() {
        genreView.translatesAutoresizingMaskIntoConstraints = false
        genreView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        genreView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        genreView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        genreView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func labelConstraints() {
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        genreLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
        genreLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }
    
    func descriptionConstraints() {
        genreDescription.translatesAutoresizingMaskIntoConstraints = false
        genreDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        genreDescription.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6).isActive = true
        genreDescription.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9).isActive = true
        genreDescription.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
}
