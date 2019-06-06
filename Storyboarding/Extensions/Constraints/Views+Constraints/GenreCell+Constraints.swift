//
//  GenreCell+Constraints.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

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
