//
//  ViewController.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/11/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

//TODO:
// create custom cell so stories may have longer titles

import UIKit

class IdeaViewController: UIViewController {
    
    let ideaTableView = UITableView()
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    static var storyArr: [Storyboard] = []
    
    override func loadView() {
        super.loadView()
        view.addSubview(ideaTableView)
        setupTableView()
        populateTableView()
        setupAddButton()
        setupInfoButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ideaTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ElementsViewController.parsedStoryDict = [:]
    }
    
    //MARK: view setup functionality
    
    func setupAddButton() {
        
        let buttonRadius = (view.frame.width * 0.15) / 2
        let button = UIButton()
        let buttonImage = UIImage(named: "addButton")
        
        button.setImage(buttonImage, for: .normal)
        button.layer.cornerRadius = buttonRadius
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addTarget(self, action: #selector(addStoryTapped), for: .touchUpInside)
        
        view.addSubview(button)
        addStoryConstraints(addStoryButton: button)
    }
    
    func setupInfoButton() {
        // Create the info button
        let infoButton = UIButton(type: .infoLight)
        
        // You will need to configure the target action for the button itself, not the bar button itemr
        infoButton.addTarget(self, action: #selector(getInfo), for: .touchUpInside)
        
        // Create a bar button item using the info button as its custom view
        let infoBarButtonItem = UIBarButtonItem(customView: infoButton)
        
        // Use it as required
        navigationItem.rightBarButtonItem = infoBarButtonItem
    }
    
    func setupNav() {
        navigationItem.title = "Story Snippets"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = .white
    }
    
    func setupTableView() {
        ideaTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        ideaTableView.delegate = self
        ideaTableView.dataSource = self
        ideaTableView.backgroundColor = .black
        ideaTableViewConstraints()
        tableViewSeperators()
    }
    
    func populateTableView() {
        let data = CoreDataManager.sharedManager.fetchStoryboards()
        guard let unwrappedData = data else {
            print("FAILURE: unable to access storyboards: \(String(describing: data))")
            return
        }
        IdeaViewController.storyArr = unwrappedData
    }
    
    func tableViewSeperators() {
        ideaTableView.separatorColor = .white
        ideaTableView.separatorInset.left = 10
        ideaTableView.separatorInset.right = 10
    }
    
    //MARK: Button functionality
    
    @objc func addStoryTapped(sender: UIGestureRecognizer) {
        let newVC = GenreViewController()
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    @objc func getInfo() {
        let newVC = HowToViewController()
        newVC.modalPresentationStyle = .overFullScreen
        present(newVC, animated: true)
    }
        
    // MARK: scrollView functionality
    
    // maintains color of title when scrolling
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}

// MARK: IdeaVC constraints

extension IdeaViewController {
    
    func ideaTableViewConstraints() {
        ideaTableView.translatesAutoresizingMaskIntoConstraints = false
        ideaTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.65).isActive = true
        ideaTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        ideaTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ideaTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func addStoryConstraints(addStoryButton: UIButton) {
        
        addStoryButton.translatesAutoresizingMaskIntoConstraints = false
        addStoryButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15).isActive = true
        addStoryButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15).isActive = true
        addStoryButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        addStoryButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
}
