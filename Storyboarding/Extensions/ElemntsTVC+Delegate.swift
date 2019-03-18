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
        print("current section: \(currentSection!), current row: \(currentRow!)")
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        
//        var sections = [0, 1, 2, 3, 4]
//        for section in sections {
//            if section = sections[
//        }
//
//
//        textView.isEditable = false
//
//        print("we are editing")
//        print(currentSection)
//        if (currentSection != nil) {
//            if !(currentSection != nil) {
//                textView.isEditable = false
//            }
//            textView.isEditable = true
//        }
    }
}
