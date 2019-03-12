//
//  ViewController.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/11/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class IdeaViewController: UIViewController {
    
    var addButtonItem: UIBarButtonItem!
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
        setupNav()
    }
    
    //MARK: view setup functionality
    
    func setupView() {
        let mainViewFrame = UIScreen.main.bounds
        let ideaView = IdeaView()
        ideaView.frame = mainViewFrame
        view.addSubview(ideaView)
    }
    
    func setupNav() {
        navigationItem.title = "Storyboarding"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.rightBarButtonItem = addButtonItem
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    //MARK: scrollView functionality
    
    /* maintains color of title when scrolling */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        navigationItem.rightBarButtonItem = nil
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        navigationItem.rightBarButtonItem = addButtonItem
    }
}

/*
 Placed here because this block has to do with functionality 
 */
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


