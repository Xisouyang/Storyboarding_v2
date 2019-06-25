//
//  ElementsTableViewCell.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/15/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class ElementsTableViewCell: UITableViewCell {
    
    var cellView: UIView!
    var cellTextView: UITextView!
    
    var currentSection: Int = 0
    var currentRow: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .black
        createCellView()
        createCellTextView()
        cellTextView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func createCellView() {
        cellView = UIView(frame: .zero)
        cellView.backgroundColor = .white
        cellView.layer.cornerRadius = 6
        cellView.layer.masksToBounds = true
        contentView.addSubview(cellView)
        cellViewConstraints()
    }
    
    func createCellTextView() {
        cellTextView = UITextView()
        cellTextView.font = UIFont.init(name: "Times New Roman", size: 18)
        cellTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        cellView.addSubview(cellTextView)
        cellTextViewConstraints()
    }
}

extension ElementsTableViewCell {
    
    func cellViewConstraints() {
        
        cellView.translatesAutoresizingMaskIntoConstraints = false
        
        let widthConstraint = NSLayoutConstraint(item: cellView, attribute: .width, relatedBy: .equal, toItem: self.contentView, attribute: .width, multiplier: 0.9, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: cellView, attribute: .height, relatedBy: .equal, toItem: self.contentView, attribute: .height, multiplier: 0.9, constant: 0)
        let horizontalConstraint = NSLayoutConstraint(item: cellView, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1.0, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: cellView, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1.0, constant: 0)
        self.contentView.addConstraints([widthConstraint, heightConstraint, horizontalConstraint, verticalConstraint])
    }
    
    func cellTextViewConstraints() {
        
        cellTextView.translatesAutoresizingMaskIntoConstraints = false
        cellTextView.topAnchor.constraint(equalToSystemSpacingBelow: cellView.topAnchor, multiplier: 0.8).isActive = true
        cellTextView.rightAnchor.constraint(equalTo: cellView.rightAnchor).isActive = true
        cellTextView.bottomAnchor.constraint(equalToSystemSpacingBelow: cellView.bottomAnchor, multiplier: 0.8).isActive = true
        cellTextView.leftAnchor.constraint(equalTo: cellView.leftAnchor).isActive = true
        
    }
}



