//
//  ElementsView+DS&Delegate.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/15/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

extension ElementsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension ElementsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = elementsTableView.dequeueReusableCell(withIdentifier: ElementsTableViewCell.identifier, for: indexPath) as! ElementsTableViewCell
        return cell
    }
}

