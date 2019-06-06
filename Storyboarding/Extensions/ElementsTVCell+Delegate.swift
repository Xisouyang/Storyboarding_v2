//
//  ElemntsTVC+Delegate.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/18/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

extension ElementsTableViewCell: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {

        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let cellText = self.cellTextView.text
        guard let unwrappedText = cellText else { return }
        let elementName = ElementsViewController.elements[currentSection]
        ElementsViewController.parsedStoryDict[elementName]![currentRow] = unwrappedText
    }
}
