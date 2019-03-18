//
//  ElementsTableViewCell.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/15/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class ElementsTableViewCell: UITableViewCell {
    
    static var identifier: String = "elementCell"
    var cellView: UIView!
    var cellTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .black
        createCellView()
        createCellTextField()
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
    
    func createCellTextField() {
        cellTextView = UITextView()
//        cellTextView.layer.backgroundColor = UIColor.clear.cgColor
        cellTextView.font = UIFont.init(name: "Times New Roman", size: 18)
        cellView.addSubview(cellTextView)
        cellTextViewConstraints()
    }
}
