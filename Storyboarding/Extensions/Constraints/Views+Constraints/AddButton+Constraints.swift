//
//  AddButton+Constraints.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 6/10/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation

extension IdeaViewController {
    
    func buttonConstraints() {
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15).isActive = true
        addButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
    }
}
