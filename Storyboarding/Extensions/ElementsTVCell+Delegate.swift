//
//  ElemntsTVC+Delegate.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/18/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

extension ElementsTableViewCell: UITextViewDelegate {
    
    // update dictionary with new user written text
    func textViewDidEndEditing(_ textView: UITextView) {
        let cellText = self.cellTextView.text
        guard let unwrappedText = cellText else { return }
        let elementName = ElementsViewController.elements[currentSection]
        ElementsViewController.parsedStoryDict[elementName]![currentRow] = unwrappedText
    }
}
