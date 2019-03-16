//
//  ElementsTVCell+Constraints.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/15/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

extension ElementsTableViewCell {
    
    func cellViewConstraints() {
        cellView.translatesAutoresizingMaskIntoConstraints = false
        
        let widthConstraint = NSLayoutConstraint(item: cellView, attribute: .width, relatedBy: .equal, toItem: self.contentView, attribute: .width, multiplier: 0.9, constant: 0)
         let heightConstraint = NSLayoutConstraint(item: cellView, attribute: .height, relatedBy: .equal, toItem: self.contentView, attribute: .height, multiplier: 0.85, constant: 0)
         let horizontalConstraint = NSLayoutConstraint(item: cellView, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1.0, constant: 0)
         let verticalConstraint = NSLayoutConstraint(item: cellView, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1.0, constant: 0)
        self.contentView.addConstraints([widthConstraint, heightConstraint, horizontalConstraint, verticalConstraint])
    }
    
    func cellTextViewConstraints() {
        
        cellTextView.translatesAutoresizingMaskIntoConstraints = false
        cellTextView.topAnchor.constraint(equalTo: cellView.topAnchor).isActive = true
        cellTextView.rightAnchor.constraint(equalTo: cellView.rightAnchor).isActive = true
        cellTextView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor).isActive = true
        cellTextView.leftAnchor.constraint(equalTo: cellView.leftAnchor).isActive = true
    }
}
