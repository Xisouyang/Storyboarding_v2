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
        ideaVC.passedStories = self.parsedStoryDict
        self.navigationController?.initRootViewController(vc: ideaVC)
    }
    
//    func returnStories() -> [String : [String]] {
//        guard let passedStories = self.elementView?.parsedStories else {
//            print("error: no stories to pass => \(String(describing: self.elementView?.parsedStories))")
//            return ["No Stories": ["sorry"]]
//        }
//        return passedStories
//    }
    
    func handleStoryData() {
        getService.getStories() { result in
            self.setStories(result: result)
            self.parseStories(stories: self.storyArr)
            DispatchQueue.main.async {
                self.elementView!.parsedStories = self.parsedStoryDict
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
