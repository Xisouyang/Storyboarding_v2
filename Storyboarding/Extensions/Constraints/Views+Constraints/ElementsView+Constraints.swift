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
}
