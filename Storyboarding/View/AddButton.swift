//
//  AddButton.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 6/10/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class AddButton: UIView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCircle()
        setupPlusSymbol()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func setupCircle() {
        
        self.backgroundColor = .black
        self.isUserInteractionEnabled = true
        self.clipsToBounds = true
        self.layer.borderWidth = 3
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func setupPlusSymbol() {
        
        let lineOne = UIView(frame: .zero)
        let lineTwo = UIView(frame: .zero)
        
        lineOne.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.addSubview(lineOne)
        lineOneConstraints(line: lineOne)
        
        lineTwo.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.addSubview(lineTwo)
        lineTwoConstraints(line: lineTwo)
    }
    
    func lineOneConstraints(line: UIView) {
        line.translatesAutoresizingMaskIntoConstraints = false
        line.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        line.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        line.heightAnchor.constraint(equalToConstant: 2).isActive = true
        line.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    func lineTwoConstraints(line: UIView) {
        
        line.translatesAutoresizingMaskIntoConstraints = false
        line.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        line.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        line.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        line.widthAnchor.constraint(equalToConstant: 2).isActive = true
    }
}


