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
        print("current section: \(currentSection), current row: \(currentRow!)")
        return true
    }
}
