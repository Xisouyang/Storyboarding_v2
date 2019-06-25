//
//  SmartHeader.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 6/14/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class SectionHeader: UITableViewHeaderFooterView {

    static let reuseIdentifier: String = "SectionHeader"
    var label: UILabel
    var button: UIButton

    
    override init(reuseIdentifier: String?) {
        self.label = UILabel()
        self.button = UIButton()
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.addSubview(label)
        self.contentView.backgroundColor = .black
        
        label = createHeaderLabel()
        button = createButton()
        
        self.addSubview(label)
        self.addSubview(button)
        
        elementsHeaderLabelConstraints(label: label, header: self)
        sectionBtnConstraints(button: button, header: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func createButton() -> UIButton {
        
        let button = UIButton(frame: .zero)
        let buttonImage = UIImage(named: "addButton")
        button.setImage(buttonImage, for: .normal)
        button.layer.cornerRadius = (self.contentView.frame.width)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        return button
    }
    
    func createHeaderLabel() -> UILabel {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = UIFont.init(name: "Baskerville", size: 36)
        label.textAlignment = .center
        return label
    }
}

extension SectionHeader {
    
    func elementsHeaderLabelConstraints(label: UILabel, header: UIView) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        label.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
    }
    
    func sectionBtnConstraints(button: UIButton, header: UIView) {
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalTo: header.widthAnchor, multiplier: 0.1).isActive = true
        button.heightAnchor.constraint(equalTo: header.widthAnchor, multiplier: 0.1).isActive = true
        button.topAnchor.constraint(equalTo: header.topAnchor, constant: 7).isActive = true
        button.rightAnchor.constraint(equalTo: header.rightAnchor, constant: -20).isActive = true
    }
}
