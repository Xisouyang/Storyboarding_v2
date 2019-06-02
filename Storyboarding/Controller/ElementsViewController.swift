//
//  ElementsViewController.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/14/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//


// TODO:
// 1) finish commenting
// 2) implement UI alert when saving
//    - cannot save if we do not add a title for the storyboard
//    - if title is added, then send title to idea view controller screen
// 3) implement Core Data
// 4) create booleans to check for if we need to request data from api or retrieve data from Core Data
// 5) Implement functionality to create new cells


import UIKit

class ElementsViewController: UIViewController {
    
    static var needToCallAPI: Bool?
    
    // Initialize neccessary variables
    
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
    var returnElements: NSSet?
    
    override func loadView() {
        super.loadView()
        setupTableView()
        fetchStoryElements()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        print(ElementsViewController.needToCallAPI)
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
    
    // MARK: handle data
    
    func fetchStoryElements() {
        guard let unwrappedBool = ElementsViewController.needToCallAPI else { return }
        if unwrappedBool {
            fetchFromAPI()
        } else {
            fetchFromCoreData()
            guard let unwrappedData = returnElements else { return }
            parseFromCoreData(elements: unwrappedData)
        }
    }
    
    func fetchFromAPI() {
        ServiceLayer.request(router: Router.getAllStories) { (result: Result<[StoryModel]>) in
            switch result {
            case .success(let result):
                self.allStoriesArr = result
                self.parseFromAPI(stories: self.allStoriesArr)
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    // parse converted JSON data
    func parseFromAPI(stories: [StoryModel]) {
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
    
    func fetchFromCoreData() {
        guard let unwrappedTitle = headerTitle else { return }
        let story = CoreDataManager.sharedManager.fetchStoryboard(boardName: unwrappedTitle) as! Storyboard
        let storyElements = story.elements
        guard let unwrappedElements = storyElements else { return }
        returnElements = unwrappedElements
    }
    
    func parseFromCoreData(elements: NSSet) {
        parsedStoryDict["Plot"] = []
        parsedStoryDict["Conflict"] = []
        parsedStoryDict["Resolution"] = []
        parsedStoryDict["Character"] = []
        parsedStoryDict["Setting"] = []
        
        for item in elements {
            let element = item as! Elements
            guard let unwrappedContent = element.content else { return }
            guard let unwrappedType = element.type else { return }
            
            switch unwrappedType {
            case "Plot":
                parsedStoryDict["Plot"]?.append(unwrappedContent)
            case "Conflict":
                parsedStoryDict["Conflict"]?.append(unwrappedContent)
            case "Resolution":
                parsedStoryDict["Resolution"]?.append(unwrappedContent)
            case "Character":
                parsedStoryDict["Character"]?.append(unwrappedContent)
            case "Setting":
                parsedStoryDict["Setting"]?.append(unwrappedContent)
            default:
                print("No more elements to parse")
            }
        }
    }
    
    @objc func saveTapped() {
        print("ELEMENT VIEW CONTROLLER: save tapped")
        handleAlert()
    }
    
    func saveBoard(storyboard: Dictionary<String, [String]>, name: String) {
        
        // loop through each key in the dictionary
        // loop through each element in the array
        // call function to save element
        // function will take in parameters type: (dictionary key) and content: (element)
        for key in storyboard.keys {
            guard let unwrappedElementArr = storyboard[key] else {
                print("ERROR: unable to access story elements: \(String(describing: storyboard[key]))")
                return
            }
            for item in unwrappedElementArr {
                // call Core Data
                    // fetch specific storyboard
                let storyboard = CoreDataManager.sharedManager.fetchStoryboard(boardName: name)
                guard let unwrappedBoard = storyboard else { return }
                CoreDataManager.sharedManager.createElement(type: key, content: item, storyboard: storyboard as! Storyboard)
                    // to do that I need to access the story's title
                    // I can pass that story's title by clicking on the tableview cell in the first screen
                    // need to set booleans to check if we're adding brand new storyboard or if we're visiting an old one
            }
        }
    }

    func handleAlert() {
        // create alert
        // create ok and cancel buttons
        // create textfield
        // add notification center to handle checking whether text field is empty or not
        
        // create alert controller
        let alert = UIAlertController(title: "Please enter a title", message: nil, preferredStyle: .alert)
        
        // create action
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            let newVC = IdeaViewController()
            guard let unwrappedTextFields = alert.textFields else { return }
            guard let unwrappedText = unwrappedTextFields[0].text else { return }
            
            // save text title to Core Data
            CoreDataManager.sharedManager.createStoryboard(storyName: unwrappedText)
            
            let storyboard: Storyboard = CoreDataManager.sharedManager.fetchStoryboard(boardName: unwrappedText) as! Storyboard
            print(storyboard)
            // save story elements
            self.saveBoard(storyboard: self.parsedStoryDict, name: unwrappedText)
            
            self.navigationController?.initRootViewController(vc: newVC)
        })
        okAction.isEnabled = false
        alert.addAction(okAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // add textfield to alert
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input Title"
            
            // add notification center to check when text field changes
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main, using: {_ in
                
                // code in here executes when notification is fired
                
                let textCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
                let textNotEmpty = textCount > 0
                okAction.isEnabled = textNotEmpty
            })
        })
        self.present(alert, animated: true)
    }
}
