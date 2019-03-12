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
        navigationItem.rightBarButtonItem = addButtonItem
        navigationItem.rightBarButtonItem?.tintColor = .white
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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ideaTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}


