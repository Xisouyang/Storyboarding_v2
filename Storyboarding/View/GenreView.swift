//
//  GenreView.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

/* TODO:
- Fix sizing of the collection view cells - in progress
- Create custom cell that has uilabel and uitextview as subviews - done
- make cell clickable
 */

import UIKit

protocol GenreViewDelegate {
    
    func returnGenreTitle() -> String
}

class GenreView: UIView, GenreViewDelegate {
    
    var collection: UICollectionView!
    var collectionHeight: CGFloat!
    var genreTitles: [String]!
    var genreDescription: [String]!
    var selectedGenre: String?
    
    init(frame: CGRect, collectionHeight: CGFloat) {
        
        super.init(frame: frame)
        
        
        genreTitles = ["Adventure", "Horror", "Mystery", "Romance"]
        genreDescription = [
            "Fiction that usually presents danger, or gives the reader a sense of excitement",
            "Genre of speculative fiction which is intended to frighten, scare, disgust, or startle its readers by inducing feelings of horror and terror",
            "Type of fiction in which a detective, or other professional, solves a crime or series of crimes",
            "Centers around two people developing feelings for one another, usually with optimistic ending"
        ]
        
        self.collectionHeight = collectionHeight
        setupCollectionView()
        collectionConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        
        collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        addSubview(collection)

        self.collection.dataSource = self
        self.collection.delegate = self
        self.collection.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.identifier)
        self.collection.alwaysBounceVertical = true
        self.collection.backgroundColor = .black
    }
    
    func returnGenreTitle() -> String {
        
        return selectedGenre ?? "NIL"
    }
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

