//
//  ElementsView+Constraints.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/15/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

extension ElementsView {
    
    func elementsTVConstraints() {
        
        elementsTableView.translatesAutoresizingMaskIntoConstraints = false
        elementsTableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        elementsTableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        elementsTableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        elementsTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    func elementsHeaderLabelConstraints() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.leftAnchor.constraint(equalTo: tableViewHeader.leftAnchor).isActive = true
        headerLabel.topAnchor.constraint(equalTo: tableViewHeader.topAnchor).isActive = true
        headerLabel.rightAnchor.constraint(equalTo: tableViewHeader.rightAnchor).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: tableViewHeader.bottomAnchor).isActive = true
    }
    
    func sectionButtonConstraints() {
        sectionButton.translatesAutoresizingMaskIntoConstraints = false
        sectionButton.widthAnchor.constraint(equalTo: tableViewHeader.widthAnchor, multiplier: 0.3).isActive = true
        sectionButton.heightAnchor.constraint(equalTo: tableViewHeader.heightAnchor, multiplier: 0.9).isActive = true
        sectionButton.rightAnchor.constraint(equalTo: tableViewHeader.rightAnchor).isActive = true
    }
}
