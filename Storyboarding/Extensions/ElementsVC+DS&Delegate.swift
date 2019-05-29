//
//  ElementsView+DS&Delegate.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/15/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

extension ElementsViewController: UITableViewDelegate {
    
    //MARK: tableview UI
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 4
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
        return tableViewHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.height / 16
    }
}

//MARK: tableview data handling
extension ElementsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if parsedStoryDict.count == 0 {
            return 5
        } else {
            return (parsedStoryDict[elements[section]]?.count)!
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
    
    //Populate each cell with the parsed stories or loading text if fetching
    func populateRows(cell: ElementsTableViewCell, path: IndexPath) {
        
        let storyCatagory = parsedStoryDict[elements[path.section]]
        if storyCatagory?.count == 0 {
            cell.cellTextView.text = "loading..."
        } else {
            guard let unwrappedCatagory = storyCatagory else { return }
            cell.cellTextView.text = unwrappedCatagory[path.row]
        }
    }
    
    
    func selectCellID(indexPath: IndexPath) -> String {
        
        
        //Need switch statement to keep cells from different sections separate from each other
 
        
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
            
        }
    }
    
    //MARK: constraints
    
    func elementsTVConstraints() {
        
        elementsTableView.translatesAutoresizingMaskIntoConstraints = false
        elementsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        elementsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        elementsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        elementsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func elementsHeaderLabelConstraints() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.leftAnchor.constraint(equalTo: tableViewHeader.leftAnchor).isActive = true
        headerLabel.topAnchor.constraint(equalTo: tableViewHeader.topAnchor).isActive = true
        headerLabel.rightAnchor.constraint(equalTo: tableViewHeader.rightAnchor).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: tableViewHeader.bottomAnchor).isActive = true
    }
}
