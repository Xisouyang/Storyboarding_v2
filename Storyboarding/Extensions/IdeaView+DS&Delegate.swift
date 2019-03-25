//
//  IdeaView+DS&Delegate.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/15/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

extension IdeaView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return IdeaView.titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ideaTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = IdeaView.titleArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        var passStory = passStories(path: indexPath)
        self.delegate?.goToElementVC(passedStory: passStory)
    }
    
    func passStories(path: IndexPath) -> [String : [String]] {
        return IdeaView.storiesArr[path.row]
    }
}

extension IdeaView: UITableViewDelegate {
    
}


