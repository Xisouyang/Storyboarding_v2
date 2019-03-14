//
//  GenreCell+Constraints.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

extension GenreCell {
    
    func labelConstraints() {
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        genreLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
        genreLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }
    
    func textViewConstraints() {
        genreDescription.translatesAutoresizingMaskIntoConstraints = false
        genreDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        genreDescription.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
        genreDescription.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }
}
