//
//  ElementVC+Fetch&Parse.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 6/12/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

// MARK: handle fetching/parsing data

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
    
    func loading() {
        let alert = UIAlertController(title: nil, message: "LOADING", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: {
            self.fetchStoryElements()
        })
    }
    
    func fetchFromAPI() {
        ServiceLayer.request(router: Router.getAllStories) { (result: Result<[StoryModel]>) in
            switch result {
            case .success(let result):
                self.allStoriesArr = result
                self.allStoriesArr.shuffle()
                self.parseFromAPI(stories: self.allStoriesArr)
            case .failure(let error):
                print("\(error)")
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    // parse converted JSON data
    func parseFromAPI(stories: [StoryModel]) {
        
        var plotCount = 0
        var conflictCount = 0
        var resolutionCount = 0
        var characterCount = 0
        var settingCount = 0
        
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
                    if plotCount == 1 { continue }
                    ElementsViewController.parsedStoryDict["Plot"]?.append(unwrappedPlot)
                    plotCount += 1
                }
                if let unwrappedConflicts = story.conflict {
                    if conflictCount == 1 { continue }
                    ElementsViewController.parsedStoryDict["Conflict"]?.append(unwrappedConflicts)
                    conflictCount += 1
                }
                if let unwrappedResolutions = story.resolution {
                    if resolutionCount == 1 { continue }
                    ElementsViewController.parsedStoryDict["Resolution"]?.append(unwrappedResolutions)
                    resolutionCount += 1
                }
                if let unwrappedChars = story.character {
                    if characterCount == 1 { continue }
                    ElementsViewController.parsedStoryDict["Character"]?.append(unwrappedChars)
                    characterCount += 1
                }
                if let unwrappedSettings = story.setting {
                    if settingCount == 1 { continue }
                    ElementsViewController.parsedStoryDict["Setting"]?.append(unwrappedSettings)
                    settingCount += 1
                }
            }
        }
        
        DispatchQueue.main.async {
            self.elementsTableView.reloadData()
            self.elementsTableView.isScrollEnabled = true
            self.dismiss(animated: true, completion: nil)
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
        self.elementsTableView.isScrollEnabled = true
    }
}
