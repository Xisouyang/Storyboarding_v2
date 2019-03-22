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
        if parsedStories == nil {
            return 5
        } else {
            return (parsedStories![elements[section]]?.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        cellID = selectCellID(indexPath: indexPath)
        let cell = elementsTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ElementsTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.currentSection = indexPath.section
        cell.currentRow = indexPath.row
        
        populateRows(cell: cell, path: indexPath)
        
        return cell
    }
    
    func populateRows(cell: ElementsTableViewCell, path: IndexPath) {
        
        if parsedStories == nil {
            cell.cellTextView.text = "loading..."
        } else {
            
            if parsedStories![elements[path.section]]?.count == 0 {
                cell.cellTextView.text = ""
            } else {
                print(path.section)
                cell.cellTextView.text = parsedStories![elements[path.section]]![path.row]
            }
        }
    }
    
    
    func selectCellID(indexPath: IndexPath) -> String {
        
        /*
         Need switch statement to keep cells from different sections seperate from each other
         */
        
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
        return cellID
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            parsedStories![elements[indexPath.section]]?.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
}
