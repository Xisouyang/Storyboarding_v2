//
//  GenreViewController.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class GenreViewController: UIViewController {
    
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
        // Do any additional setup after loading the view.
    }
    
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
        addButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = addButtonItem
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
    
    func collectionConstraints() {
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collection.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collection.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc func addTapped() {
        print("genreVC add button tapped")
        let newController = ElementsViewController()
        if returnGenreTitle() == "NIL" {
            noGenreSelected()
        } else {
            newController.headerTitle = returnGenreTitle()
            self.navigationController?.pushViewController(newController, animated: true)
        }
    }
    
    func returnGenreTitle() -> String {
        
        return selectedGenre ?? "NIL"
    }
    
    func noGenreSelected() {
        let alert = UIAlertController(title: "Please select a genre", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        self.present(alert, animated: true)
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
