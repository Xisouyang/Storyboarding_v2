//
//  ElementsViewController.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/14/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.

// TODO:
// 1) finish commenting
// 2) implement UI alert when saving
//    - cannot save if we do not add a title for the storyboard
//    - if title is added, then send title to idea view controller screen
// 3) implement Core Data
// 4) create booleans to check for if we need to request data from api or retrieve data from Core Data
// 5) Check if we need to create a new item in the array or update the item in the array in the idea view controller
    // Just create a boolean to check whether we need to run the alert or just update using Core Data
    // compare header title with elements in ideaviewcontroller array of stories, if we find it then set the bool to false
// 6) Implement functionality to save edited text 
// 7) Implement functionality to create new cells


import UIKit

class ElementsViewController: UIViewController {
    
    static var needToCallAPI: Bool?
    var isNewStory: Bool?
    
    // Initialize neccessary variables
    
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    var saveButton: UIBarButtonItem?
    var elementsTableView: UITableView!
    var tableViewHeader: UIView!
    var headerLabel: UILabel!
    var headerTitle: String?
    
    var cellID: String = "cellID"
    static let elements = ["Plot", "Conflict", "Resolution", "Character", "Setting"]
    var allStoriesArr = [StoryModel]()
    static var parsedStoryDict: [String: [String]] = [:] 
    var returnElements: NSSet?
    
    override func loadView() {
        super.loadView()
        setupTableView()
        fetchStoryElements()
        updateIsNewStory()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false 
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: UI

    func setupNav() {
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
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
        elementsTableView.delegate = self
        elementsTableView.dataSource = self
        elementsTableView.backgroundColor = .black
        elementsTableView.separatorColor = .clear
        view.addSubview(elementsTableView)
        elementsTVConstraints()
    }
    
    func createHeaderLabel() {
        headerLabel = UILabel()
        headerLabel.textColor = .white
        headerLabel.font = UIFont.init(name: "Baskerville", size: 36)
        headerLabel.backgroundColor = .black
        headerLabel.textAlignment = .center
    }
    
    @objc func saveTapped() {
        self.view.endEditing(true)
        print("ELEMENT VIEW CONTROLLER: save tapped")
        if isNewStory == true {
            handleAlert()
        } else {
            updateBoard()
            let newVC = IdeaViewController()
            navigationController?.initRootViewController(vc: newVC)
        }
    }
}
