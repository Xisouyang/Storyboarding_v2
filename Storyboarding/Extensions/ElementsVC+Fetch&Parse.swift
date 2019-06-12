//
//  ElementVC+Fetch&Parse.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 6/12/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation

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
