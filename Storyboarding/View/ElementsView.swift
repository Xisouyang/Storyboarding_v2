//
//  ElementsView.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/14/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class ElementsView: UIView {
    
    var elementsTableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView() {
        elementsTableView = UITableView(frame: .zero)
        elementsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "elementCell")
        elementsTableView.delegate = self
        elementsTableView.dataSource = self
        addSubview(elementsTableView)
        elementsTVConstraints()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
