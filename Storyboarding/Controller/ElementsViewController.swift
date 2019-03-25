//
//  ElementsViewController.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/14/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController {
    
    var elementView: ElementsView?
    let getService = GetServices()
    
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    var genreTitle: String!
    var saveButton: UIBarButtonItem?
    
    var storyArr = [StoryModel]()
    var parsedStoryDict = [String: [String]]()
    
    var parse: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupView()
        handleStoryData()
        
        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        parsedStoryDict = [:]
        elementView = ElementsView(frame: self.view.frame)
        view.addSubview(elementView!)
    }
    
    func setupNav() {
        navigationItem.title = genreTitle
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        
        
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
//    @objc func isExpandedButtonTapped(sender: UIButton!) {
//        
//        print("isExpanded tapped")
//        if sender.titleLabel?.text == "Collapse" {
//            sender.setTitle("Expand", for: .normal)
//        } else {
//            sender.setTitle("Collapse", for: .normal)
//        }
//    }
    
    @objc func saveTapped() {
        print("ELEMENTVC: save tapped")
        let ideaVC = IdeaViewController()
        if parse {
            ideaVC.passedStories = self.parsedStoryDict
        } else {
            print("no stories passed")
        }
        passStoryTitle(controller: ideaVC)
    }
    
    func passStoryTitle(controller: IdeaViewController) {
        
        let alert = UIAlertController(title: "Add Title", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Title Name"
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let titleName = alert.textFields?.first?.text {
                controller.passedTitle = titleName
                self.navigationController?.initRootViewController(vc: controller)
            }
        }))

        self.present(alert, animated: true)
    }
    
    func handleStoryData() {
        getService.getStories() { result in
            self.setStories(result: result)
            if self.parse {
                self.parseStories(stories: self.storyArr)
                DispatchQueue.main.async {
                    self.elementView!.parsedStories = self.parsedStoryDict
                }
            } else {
               print("no stories parsed")
            }
        }
    }
    
    func setStories(result: Result<[StoryModel]>) {
        
        switch result {
        case let .success(result):
            self.storyArr = result
        case let .failure(error):
            print(error)
        }
    }
    
    func parseStories(stories: [StoryModel]) {
        
        parsedStoryDict["Plot"] = []
        parsedStoryDict["Conflict"] = []
        parsedStoryDict["Resolution"] = []
        parsedStoryDict["Character"] = []
        parsedStoryDict["Setting"] = []
        
        for story in stories {
            if story.genre != genreTitle {
                continue
            } else {
                parsedStoryDict["Plot"]?.append(story.plot!)
                parsedStoryDict["Conflict"]?.append(story.conflict!)
                parsedStoryDict["Resolution"]?.append(story.resolution!)
                parsedStoryDict["Character"]?.append(story.character!)
                parsedStoryDict["Setting"]?.append(story.setting!)
            }
        }
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
