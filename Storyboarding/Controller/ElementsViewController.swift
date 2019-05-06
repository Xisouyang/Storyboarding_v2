//
//  ElementsViewController.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/14/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController {
    
//    static var needToCallAPI = true
    
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    var saveButton: UIBarButtonItem?
    var elementsTableView: UITableView!
    var tableViewHeader: UIView!
    var headerLabel: UILabel!
    var headerTitle: String?
    
    var cellID: String = "cellID"
    let elements = ["Plot", "Conflict", "Resolution", "Character", "Setting"]
    var allStoriesArr = [StoryModel]()
    var parsedStoryDict: [String: [String]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupTableView()
        
        ServiceLayer.request(router: Router.getAllStories) { (result: Result<[StoryModel]>) in
            switch result {
            case .success(let result):
                self.allStoriesArr = result
                self.parseStories(stories: self.allStoriesArr)
            case .failure(let error):
                print("\(error)")
            }
        }
        // Do any additional setup after loading the view.
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
        elementsTableView.register(ElementsTableViewCell.self, forCellReuseIdentifier: elements[0])
        elementsTableView.register(ElementsTableViewCell.self, forCellReuseIdentifier: elements[1])
        elementsTableView.register(ElementsTableViewCell.self, forCellReuseIdentifier: elements[2])
        elementsTableView.register(ElementsTableViewCell.self, forCellReuseIdentifier: elements[3])
        elementsTableView.register(ElementsTableViewCell.self, forCellReuseIdentifier: elements[4])
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
    
    func parseStories(stories: [StoryModel]) {
        parsedStoryDict["Plot"] = []
        parsedStoryDict["Conflict"] = []
        parsedStoryDict["Resolution"] = []
        parsedStoryDict["Character"] = []
        parsedStoryDict["Setting"] = []
        
        for story in stories {
            if story.genre != headerTitle {
                continue
            } else {
                if let unwrappedPlot = story.plot {
                    parsedStoryDict["Plot"]?.append(unwrappedPlot)
                }
                if let unwrappedConflicts = story.conflict {
                    parsedStoryDict["Conflict"]?.append(unwrappedConflicts)
                }
                if let unwrappedResolutions = story.resolution {
                    parsedStoryDict["Resolution"]?.append(unwrappedResolutions)
                }
                if let unwrappedChars = story.character {
                    parsedStoryDict["Character"]?.append(unwrappedChars)
                }
                if let unwrappedSettings = story.setting {
                    parsedStoryDict["Setting"]?.append(unwrappedSettings)
                }
            }
        }
        DispatchQueue.main.async {
            self.elementsTableView.reloadData()
        }
    }
    
    @objc func saveTapped() {
        print("ELEMENT VIEW CONTROLLER: save tapped")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
