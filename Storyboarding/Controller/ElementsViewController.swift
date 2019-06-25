//
//  ElementsViewController.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/14/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.


import UIKit

class ElementsViewController: UIViewController {
    
    static var needToCallAPI: Bool?
    var isNewStory: Bool?
    
    // Initialize neccessary variables
    
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    var elementsTableView: UITableView!
    var headerTitle: String?
    
    static let elements = ["Plot", "Conflict", "Resolution", "Character", "Setting"]
    static var parsedStoryDict: [String: [String]] = [:]
    var cellID: String = "cellID"
    var allStoriesArr = [StoryModel]()
    var returnElements: NSSet?
    
    override func loadView() {
        super.loadView()
        setupTableView()
        fetchStoryElements()
        updateIsNewStory()
        handleKeyboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
    }
    
    // MARK: UI

    func setupNav() {
        
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.title = headerTitle
    }
    
    func setupTableView() {
        elementsTableView = UITableView(frame: .zero)
        elementsTableView.register(ElementsTableViewCell.self, forCellReuseIdentifier: ElementsViewController.elements[0])
        elementsTableView.register(ElementsTableViewCell.self, forCellReuseIdentifier: ElementsViewController.elements[1])
        elementsTableView.register(ElementsTableViewCell.self, forCellReuseIdentifier: ElementsViewController.elements[2])
        elementsTableView.register(ElementsTableViewCell.self, forCellReuseIdentifier: ElementsViewController.elements[3])
        elementsTableView.register(ElementsTableViewCell.self, forCellReuseIdentifier: ElementsViewController.elements[4])
        elementsTableView.register(SectionHeader.self, forHeaderFooterViewReuseIdentifier: SectionHeader.reuseIdentifier)

        elementsTableView.delegate = self
        elementsTableView.dataSource = self
        elementsTableView.backgroundColor = .black
        elementsTableView.separatorColor = .clear
        view.addSubview(elementsTableView)
        elementsTVConstraints()
    }
    
    // MARK: button functionality
    
    @objc func saveTapped() {
        self.view.endEditing(true)
        if isNewStory == true {
            handleAlert()
        } else {
            updateBoard()
            let newVC = IdeaViewController()
            navigationController?.initRootViewController(vc: newVC)
        }
    }
}
