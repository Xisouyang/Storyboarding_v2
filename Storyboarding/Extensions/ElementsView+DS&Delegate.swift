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
        return self.frame.height / 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        tableViewHeader = UIView()
        tableViewHeader.backgroundColor = .clear
        createHeaderLabel()
        headerLabel.text = elements[section]
        tableViewHeader.addSubview(headerLabel)
        elementsHeaderLabelConstraints()
        
        createSectionButton()
        tableViewHeader.addSubview(sectionButton)
        sectionButtonConstraints()
        
        return tableViewHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.frame.height / 16
    }
}

extension ElementsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
            Need switch statement to keep cells from different sections seperate from each other
         */
        
        var cellID = ""
        
        switch indexPath.section {
        case 0:
            cellID = elements[0]
        case 1:
            cellID = elements[1]
        case 2:
            cellID = elements[2]
        case 3:
            cellID = elements[3]
        case 4:
            cellID = elements[4]
        default:
            cellID = "cellID"
        }
        let cell = elementsTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ElementsTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.currentSection = indexPath.section
        cell.currentRow = indexPath.row
    
        return cell
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = elementsTableView.dequeueReusableCell(withIdentifier: ElementsTableViewCell.identifier, for: indexPath) as! ElementsTableViewCell
//        cell.selectionStyle = UITableViewCell.SelectionStyle.none
//        return cell
//    }
}
