//
//  IdeaView.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/11/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class IdeaView: UIView {
    
    let ideaTableView = UITableView()
    var passedStories: [String: [String]]? {
        didSet {
            if let unwrappedStories = passedStories {
                print()
                print("Idea View => \(unwrappedStories)")
            } else {
                print("IdeaView: stories not passed => \(String(describing: passedStories))")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView() {
        ideaTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        ideaTableView.delegate = self
        ideaTableView.dataSource = self
        addSubview(ideaTableView)
        ideaTableViewConstraints()
        tableViewSeperators()
    }
    
    func tableViewSeperators() {
        ideaTableView.separatorColor = .black
        ideaTableView.separatorInset.left = 10
        ideaTableView.separatorInset.right = 10
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}


