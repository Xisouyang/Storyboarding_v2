//
//  IdeaView+DS&Delegate.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/15/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

extension IdeaView: UITableViewDataSource {
    
    func setupTableView() {
        ideaTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        ideaTableView.delegate = self
        ideaTableView.dataSource = self
        addSubview(ideaTableView)
        ideaTableViewConstraints()
        tableViewSeperators()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ideaTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}

extension IdeaView: UITableViewDelegate {
    
}


