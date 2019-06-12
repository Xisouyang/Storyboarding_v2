//
//  ElementVC+Save.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 6/12/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

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
