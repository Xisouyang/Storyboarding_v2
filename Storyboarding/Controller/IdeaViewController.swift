//
//  ViewController.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/11/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

protocol IdeaVCDelegate {
    func goToElementVC()
}

class IdeaViewController: UIViewController, IdeaVCDelegate {
    
    var addButtonItem: UIBarButtonItem!
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    
    var passedStories: [String: [String]]? {
        didSet {
            if let unwrappedStories = passedStories {
                print()
                print("IdeaViewController passed story => \(unwrappedStories)")
                IdeaView.storiesArr.append(unwrappedStories)
            } else {
                print("IdeaViewController: story not passed => \(String(describing: passedStories))")
            }
        }
    }
    
    var passedTitle: String? {
        didSet {
            if let unwrappedTitle = passedTitle {
                print()
                print("IdeaViewController passed title => \(unwrappedTitle)")
                IdeaView.titleArr.append(unwrappedTitle)
            } else {
                print("IdeaViewController: title not passed => \(String(describing: passedTitle))")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
        setupNav()
    }
    
    //MARK: view setup functionality
    
    func setupView() {
        let mainViewFrame = UIScreen.main.bounds
        let ideaView = IdeaView()
        ideaView.delegate = self
        ideaView.passedStories = passedStories
        ideaView.frame = mainViewFrame
        view.addSubview(ideaView)
    }
    
    func setupNav() {
        navigationItem.title = "Storyboarding"
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        addButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = addButtonItem
        navigationController?.navigationBar.tintColor = .white
    }
    
    //MARK: button functionality
    
    @objc func addTapped() {
        print("ideaVC add button tapped")
        let newController = GenreViewController()
        self.navigationController?.pushViewController(newController, animated: true)
    }
    
    //MARK: scrollView functionality
    
    /* maintains color of title when scrolling */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        navigationItem.rightBarButtonItem = addButtonItem
    }
    
    func goToElementVC() {
        let elementVC = ElementsViewController()
        elementVC.parse = false
        navigationController?.pushViewController(elementVC, animated: true)
    }
}


