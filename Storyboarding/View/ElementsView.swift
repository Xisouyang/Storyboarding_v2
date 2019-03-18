//
//  ElementsView.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/14/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class ElementsView: UIView {
    
    var elementVC = ElementsViewController()
    
    var elementsTableView: UITableView!
    var tableViewHeader: UIView!
    var headerLabel: UILabel!
    var sectionButton: UIButton!
    
    let elements = ["Plot", "Conflict", "Resolution", "Characters", "Settings"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTableView()
    }
    
    func setupTableView() {
        elementsTableView = UITableView(frame: .zero)
        elementsTableView.register(ElementsTableViewCell.self, forCellReuseIdentifier: elements[0])
        elementsTableView.register(ElementsTableViewCell.self, forCellReuseIdentifier: elements[1])
        elementsTableView.register(ElementsTableViewCell.self, forCellReuseIdentifier: elements[2])
        elementsTableView.register(ElementsTableViewCell.self, forCellReuseIdentifier: elements[3])
        elementsTableView.register(ElementsTableViewCell.self, forCellReuseIdentifier: elements[4])
        elementsTableView.delegate = self
        elementsTableView.dataSource = self
        elementsTableView.backgroundColor = .black
        elementsTableView.separatorColor = .clear
        addSubview(elementsTableView)
        elementsTVConstraints()
    }
    
    // MARK: Header UI
    
    func createHeaderLabel() {
        headerLabel = UILabel()
        headerLabel.textColor = .white
        headerLabel.font = UIFont.init(name: "Baskerville", size: 36)
        headerLabel.backgroundColor = .black
        headerLabel.textAlignment = .center
    }
    
    func createSectionButton() {
        sectionButton = UIButton()
        sectionButton.backgroundColor = .clear
        sectionButton.setTitle("Collapse", for: .normal)
        sectionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        sectionButton.tintColor = .white
        sectionButton.sizeToFit()
        sectionButton.addTarget(elementVC, action: #selector(elementVC.isExpandedButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
