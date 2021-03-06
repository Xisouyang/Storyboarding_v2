//
//  GenreViewController.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class GenreViewController: UIViewController {
    
    //initialize neccessary variables

    var collection: UICollectionView!
    var collectionHeight: CGFloat!
    var genreTitles: [String] = ["Adventure", "Horror", "Mystery", "Romance"]
    var genreDescription: [String] = [
        "Fiction that usually presents danger, or gives the reader a sense of excitement",
        "Genre of speculative fiction which is intended to frighten, scare, disgust, or startle its readers by inducing feelings of horror and terror",
        "Type of fiction in which a detective, or other professional, solves a crime or series of crimes",
        "Centers around two people developing feelings for one another, usually with optimistic ending"
    ]
    var selectedGenre: String?
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    var addButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ElementsViewController.parsedStoryDict = [:]
    }
    
    //MARK: UI
    
    func setupView() {
        
        collectionHeight = view.frame.height
        - navigationController!.navigationBar.frame.height
        setupCollectionView()
        collectionConstraints()
    }
    
    func setupNav() {
        navigationItem.title = "Genres"
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
    }
    
    func setupCollectionView() {
        
        collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collection)
        
        self.collection.dataSource = self
        self.collection.delegate = self
        self.collection.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.identifier)
        self.collection.alwaysBounceVertical = true
        self.collection.backgroundColor = .black
    }
    
    //MARK: Button functionality
    
    func returnGenreTitle() -> String {
        
        return selectedGenre ?? "NIL"
    }
}

extension GenreViewController {
    
    func collectionConstraints() {
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collection.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collection.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
