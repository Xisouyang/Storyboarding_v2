//
//  ViewController.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/11/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class IdeaViewController: UIViewController {
    
    let ideaTableView = UITableView()
    var addButtonItem: UIBarButtonItem!
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(ideaTableView)
        setupNav()
        setupTableView()
    }
    
    //MARK: view setup functionality
    
    func setupNav() {
        navigationItem.title = "Storyboarding"
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        addButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = addButtonItem
        navigationController?.navigationBar.tintColor = .white
    }
    
    func setupTableView() {
        ideaTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        ideaTableView.backgroundColor = .black
        ideaTableViewConstraints()
        tableViewSeperators()
    }
    
    func tableViewSeperators() {
        ideaTableView.separatorColor = .white
        ideaTableView.separatorInset.left = 10
        ideaTableView.separatorInset.right = 10
    }
    
    func ideaTableViewConstraints() {
        ideaTableView.translatesAutoresizingMaskIntoConstraints = false
        ideaTableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        ideaTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    //MARK: button functionality
    
    @objc func addTapped() {
        print("IDEA VIEW CONTROLLER add button tapped")
        let newController = GenreViewController()
        self.navigationController?.pushViewController(newController, animated: true)
    }
    
    //MARK: scrollView functionality
    
    /* maintains color of title when scrolling */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        navigationItem.rightBarButtonItem = addButtonItem
    }
}


