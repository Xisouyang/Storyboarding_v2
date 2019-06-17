//
//  ElementsView+DS&Delegate.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/15/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

//MARK: tableview UI
extension ElementsViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ElementsViewController.parsedStoryDict.count == 0 {
            return 5
        } else {
            return
                (ElementsViewController.parsedStoryDict[ElementsViewController.elements[section]]?.count)!
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ElementsViewController.elements.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.height / 16
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeader.reuseIdentifier) as! SectionHeader
        headerView.contentView.frame = view.frame
        headerView.label.text = ElementsViewController.elements[section]
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView:SectionHeader = view as? SectionHeader {
            headerView.label.text = ElementsViewController.elements[section] 
            headerView.button.tag = section
            headerView.button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        }
    }
}

//MARK: tableview data handling
extension ElementsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        cellID = selectCellID(indexPath: indexPath)
        let cell = elementsTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ElementsTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.currentSection = indexPath.section
        cell.currentRow = indexPath.row
        
        populateRows(cell: cell, path: indexPath)
        
        return cell
    }
    
    //Populate each cell with the parsed stories
    func populateRows(cell: ElementsTableViewCell, path: IndexPath) {
        
        let elementName = ElementsViewController.elements[path.section]
        let storyCatagory = ElementsViewController.parsedStoryDict[elementName]
        guard let unwrappedCatagory = storyCatagory else { return }
        cell.cellTextView.text = unwrappedCatagory[path.row]
    }
    
    
    func selectCellID(indexPath: IndexPath) -> String {
        
        // Need switch statement to keep cells from different sections separate from each other
 
        switch indexPath.section {
        case 0:
            cellID = ElementsViewController.elements[0]
        case 1:
            cellID = ElementsViewController.elements[1]
        case 2:
            cellID = ElementsViewController.elements[2]
        case 3:
            cellID = ElementsViewController.elements[3]
        case 4:
            cellID = ElementsViewController.elements[4]
        default:
            cellID = "cellID"
        }
        return cellID
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let sectionName = ElementsViewController.elements[indexPath.section]
            let arrayIndex = indexPath.row
            ElementsViewController.parsedStoryDict[sectionName]?.remove(at: arrayIndex)
            elementsTableView.reloadData()
        }
    }
    
    @objc func addButtonTapped(sender: UIButton) {
        let currSection = sender.tag
        addCard(section: currSection)
    }
    
    func addCard(section: Int) {
        
        // add a card to that specific section that we're in
        let categoryName = ElementsViewController.elements[section]
        ElementsViewController.parsedStoryDict[categoryName]?.insert("", at: 0)
        let path = IndexPath(row: 0, section: section)
        elementsTableView.beginUpdates()
        elementsTableView.insertRows(at: [path], with: .fade)
        elementsTableView.endUpdates()
    }
}

extension ElementsViewController {
    
    //MARK: constraints
    
    func elementsTVConstraints() {
        
        elementsTableView.translatesAutoresizingMaskIntoConstraints = false
        elementsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        elementsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        elementsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        elementsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func elementsHeaderLabelConstraints(label: UILabel, header: UIView) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        label.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
    }
    
    func sectionBtnConstraints(button: UIButton, header: UIView) {
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalTo: header.widthAnchor, multiplier: 0.115).isActive = true
        button.heightAnchor.constraint(equalTo: header.widthAnchor, multiplier: 0.115).isActive = true
        button.topAnchor.constraint(equalTo: header.topAnchor, constant: 7).isActive = true
        button.rightAnchor.constraint(equalTo: header.rightAnchor, constant: -20).isActive = true
    }
}
