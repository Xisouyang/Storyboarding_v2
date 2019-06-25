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
        setupButton()
        
        if firstLaunch() == true {
            howToUseAlert()
        }
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
    
    func firstLaunch() -> Bool {
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "launchedOnce") {
            return false
        } else {
            defaults.set(true, forKey: "launchedOnce")
            return true
        }
    }
    
    func howToUseAlert() {
        let alert = UIAlertController(title: "Hit the add button to create a new story!", message: nil, preferredStyle: .alert)
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func setupButton() {
        
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
    
    func setupNav() {
        navigationItem.title = "Story Snippets"
        navigationController?.navigationBar.barTintColor = UIColor.black
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
        ideaTableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
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
