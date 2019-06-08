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

// MARK: handle data
extension ElementsViewController {
    
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
        ElementsViewController.parsedStoryDict["Plot"] = []
        ElementsViewController.parsedStoryDict["Conflict"] = []
        ElementsViewController.parsedStoryDict["Resolution"] = []
        ElementsViewController.parsedStoryDict["Character"] = []
        ElementsViewController.parsedStoryDict["Setting"] = []
        
        for story in stories {
            if story.genre != headerTitle {
                continue
            } else {
                if let unwrappedPlot = story.plot {
                    ElementsViewController.parsedStoryDict["Plot"]?.append(unwrappedPlot)
                }
                if let unwrappedConflicts = story.conflict {
                    ElementsViewController.parsedStoryDict["Conflict"]?.append(unwrappedConflicts)
                }
                if let unwrappedResolutions = story.resolution {
                    ElementsViewController.parsedStoryDict["Resolution"]?.append(unwrappedResolutions)
                }
                if let unwrappedChars = story.character {
                    ElementsViewController.parsedStoryDict["Character"]?.append(unwrappedChars)
                }
                if let unwrappedSettings = story.setting {
                    ElementsViewController.parsedStoryDict["Setting"]?.append(unwrappedSettings)
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
        ElementsViewController.parsedStoryDict["Plot"] = []
        ElementsViewController.parsedStoryDict["Conflict"] = []
        ElementsViewController.parsedStoryDict["Resolution"] = []
        ElementsViewController.parsedStoryDict["Character"] = []
        ElementsViewController.parsedStoryDict["Setting"] = []
        
        for item in elements {
            let element = item as! Elements
            guard let unwrappedContent = element.content else { return }
            guard let unwrappedType = element.type else { return }
            
            switch unwrappedType {
            case "Plot":
                ElementsViewController.parsedStoryDict["Plot"]?.append(unwrappedContent)
            case "Conflict":
                ElementsViewController.parsedStoryDict["Conflict"]?.append(unwrappedContent)
            case "Resolution":
                ElementsViewController.parsedStoryDict["Resolution"]?.append(unwrappedContent)
            case "Character":
                ElementsViewController.parsedStoryDict["Character"]?.append(unwrappedContent)
            case "Setting":
                ElementsViewController.parsedStoryDict["Setting"]?.append(unwrappedContent)
            default:
                print("No more elements to parse")
            }
        }
    }
}

// MARK: Handle saving data
extension ElementsViewController {
    
    // function to check if we useAlertController or not
    func updateIsNewStory() {
        
        if IdeaViewController.storyArr.count == 0 {
            isNewStory = true
        } else {
            for item in IdeaViewController.storyArr {
                let title = item.title
                if headerTitle == title {
                    isNewStory = false
                    return
                }
            }
            isNewStory = true
        }
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
                CoreDataManager.sharedManager.createElement(type: key, content: item, storyboard: storyboard as! Storyboard)
                // to do that I need to access the story's title
                // I can pass that story's title by clicking on the tableview cell in the first screen
                // need to set booleans to check if we're adding brand new storyboard or if we're visiting an old one
            }
        }
    }
    
    func updateBoard() {
        guard let unwrappedTitle = headerTitle else { return }
        let test = CoreDataManager.sharedManager.fetchStoryboard(boardName: headerTitle!) as! Storyboard
        CoreDataManager.sharedManager.removeItem(objectID: test.objectID)
        CoreDataManager.sharedManager.createStoryboard(storyName: unwrappedTitle)
        saveBoard(storyboard: ElementsViewController.parsedStoryDict, name: unwrappedTitle)
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
            
            // check to see if title is valid
            let genreVC = GenreViewController()
            for item in genreVC.genreTitles {
                if unwrappedText == item {
                    self.wrongTitleAlert(text: unwrappedText)
                    return
                }
            }
            
            // save text title to Core Data
            CoreDataManager.sharedManager.createStoryboard(storyName: unwrappedText)
            
            // save story elements
            self.saveBoard(storyboard: ElementsViewController.parsedStoryDict, name: unwrappedText)
            
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
    
    func wrongTitleAlert(text: String) {
        
        let alert = UIAlertController(title: "Please enter valid title", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
