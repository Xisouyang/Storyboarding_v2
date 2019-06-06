//
//  ElementsTableViewCell.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/15/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class ElementsTableViewCell: UITableViewCell {
    
//    static var identifier: String = "plotCell"
    var cellView: UIView!
    var cellTextView: UITextView!
    
    var currentSection: Int = 0
    var currentRow: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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

        // Configure the view for the selected state
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


