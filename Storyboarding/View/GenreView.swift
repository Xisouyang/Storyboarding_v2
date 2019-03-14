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

class GenreView: UIView {
    
    var collection: UICollectionView!
    var collectionHeight: CGFloat!
    
    init(frame: CGRect, collectionHeight: CGFloat) {
        
        super.init(frame: frame)
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
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

