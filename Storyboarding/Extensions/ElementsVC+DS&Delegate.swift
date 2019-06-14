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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ElementsViewController.parsedStoryDict.count == 0 {
            return 5
        } else {
            // change this to be randomized to 5 different ones each time
            return (ElementsViewController.parsedStoryDict[ElementsViewController.elements[section]]?.count)!
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ElementsViewController.elements.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.height / 16
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let tableViewHeader = UIView()
        tableViewHeader.backgroundColor = .clear
        
        let headerLabel = createHeaderLabel()
        headerLabel.text = ElementsViewController.elements[section]
        tableViewHeader.addSubview(headerLabel)
        elementsHeaderLabelConstraints(label: headerLabel, header: tableViewHeader)
        
        let headerButton = createButton(section: section)
        headerButton.tag = section
        tableViewHeader.addSubview(headerButton)
        sectionBtnConstraints(button: headerButton, header: tableViewHeader)
        
        return tableViewHeader
    }
    
    func createButton(section: Int) -> UIButton {
        
        let button = UIButton(frame: .zero)
        let buttonImage = UIImage(named: "addButton")
        button.setImage(buttonImage, for: .normal)
        button.layer.cornerRadius = (view.frame.width * 0.115) / 2
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }
    
    func createHeaderLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.init(name: "Baskerville", size: 36)
        label.backgroundColor = .black
        label.textAlignment = .center
        return label
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
//        print(sender.tag)
        let currSection = sender.tag
        addCard(section: currSection)
    }
    
    func addCard(section: Int) {
        // add a card to that specific section that we're in
        let categoryName = ElementsViewController.elements[section]
        ElementsViewController.parsedStoryDict[categoryName]?.append("")
        guard let unwrappedCount = ElementsViewController.parsedStoryDict[categoryName]?.count else { return }
        let rowToInsert = unwrappedCount - 1
        let path = IndexPath(row: rowToInsert, section: section)

        elementsTableView.beginUpdates()
        elementsTableView.insertRows(at: [path], with: .fade)
        elementsTableView.endUpdates()
        
        
        // determine which section we're in based on the name of the header
        // using header title, access the specific array within the parsed story dictionary
        // add an empty string into that array
        // can use a switch statement to determine which section we're in based on the header title
        // create a new index path using the (array.count - 1) for row and the section number
        // insert row in tableview using that indexPath
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
