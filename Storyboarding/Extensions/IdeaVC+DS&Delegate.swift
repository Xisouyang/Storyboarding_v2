//
//  IdeaVC+DS&Delegate.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 5/29/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

// handles how user interacts with data
extension IdeaViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // pass cell's text (title of the storyboard) to the element view controller screen
        
        // access cell
        let cell = tableView.cellForRow(at: indexPath)
        
        // set new variable equal to cell's text
        let titleText = cell?.textLabel?.text
        
        // create new controller to go to
        let newVC = ElementsViewController()
        ElementsViewController.needToCallAPI = false
        newVC.headerTitle = titleText
        navigationController?.pushViewController(newVC, animated: true)
    }
}

// handles how data is displayed in tableview
extension IdeaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IdeaViewController.storyArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        print(IdeaViewController.storyArr[indexPath.row])
        cell.textLabel?.text = IdeaViewController.storyArr[indexPath.row].title
        cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return cell
    }
}
