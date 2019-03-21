//
//  ElementsViewController.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/14/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController {
    
    let getService = GetServices()
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    var genreTitle: String!
    
    
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
        let elementView = ElementsView(frame: self.view.frame)
        view.addSubview(elementView)
    }
    
    func setupNav() {
        navigationItem.title = genreTitle
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
    }
    
    @objc func isExpandedButtonTapped(sender: UIButton!) {
        
        print("isExpanded tapped")
        if sender.titleLabel?.text == "Collapse" {
            sender.setTitle("Expand", for: .normal)
        } else {
            sender.setTitle("Collapse", for: .normal)
        }
    }
    
    func handleStoryData() {
        getService.getStories() { result in
            self.setStories(result: result)
            self.parseStories(stories: self.storyArr)
        }
    }
    
    func setStories(result: Result<[StoryModel]>) {
        
        switch result {
        case let .success(result):
            self.storyArr = result
            print(self.storyArr)
            print()
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
        
        print(parsedStoryDict)
        
//        parsedStoryDict[""]
//        var plotIdeas = parsedStoryDict["Plot"]
//        for story in stories {
//            plotIdeas?.append(story.plot!)
//        }
//        parsedStoryDict["Plot"] = plotIdeas
    }
    
    func selectGenre() {
        
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
