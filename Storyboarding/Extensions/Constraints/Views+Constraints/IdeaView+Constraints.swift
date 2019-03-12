//
//  IdeaView+Constraints.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/11/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

extension IdeaView {
    
    func ideaTableViewConstraints() {
        ideaTableView.translatesAutoresizingMaskIntoConstraints = false
        ideaTableView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        ideaTableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
}
