//
//  GenreView+Extension.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

/*
 TODO: give proper title and description to subviews
        - create arrays to hold those strings
       create button on nav bar to save and go to next screen
 */

import UIKit

extension GenreView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? GenreCell {
            cell.genreDescription.backgroundColor = UIColor.lightGray
            cell.genreLabel.backgroundColor = UIColor.lightGray
            selectedGenre = cell.genreLabel.text
            print(selectedGenre)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? GenreCell {
            selectedGenre = cell.genreLabel.text
            cell.genreDescription.backgroundColor = .white
            cell.genreLabel.backgroundColor = .white
        }
    }
}

extension GenreView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genreTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("we in \(indexPath.row)")
        
        let cell = collection.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as! GenreCell
        cell.backgroundColor = .white
        cell.genreLabel.text = genreTitles[indexPath.row]
        cell.genreDescription.text = genreDescription[indexPath.row]
        return cell
    }
}

extension GenreView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height:
            collectionHeight / CGFloat(genreTitles.count))
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

