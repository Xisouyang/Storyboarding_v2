//
//  ViewController.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 6/24/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class HowToViewController: UIViewController {
    
    var stackView: UIStackView = UIStackView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6903884243)
        instructions()
        closeButton()
        title()
    }
    
    func title() {
        let label = createHeader(label: "INFO")
        view.addSubview(label)
        headerConstraints(title: label)
    }
    
    func closeButton() {
        let startButton = createButton()
        view.addSubview(startButton)
        buttonConstraints(button: startButton)
    }
    
    func instructions() {
        let stringOne: UILabel = createString(content: "Tap Add")
        let stringTwo: UILabel = createString(content: "Select Genre")
        let stringThree: UILabel = createString(content: "Write and Save")
        let stringFour: UILabel = createString(content: "Swipe to Delete")
        
        stackView = UIStackView(arrangedSubviews: [stringOne, stringTwo, stringThree, stringFour])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.addBackground(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        view.addSubview(stackView)
        stackViewConstraints()
    }
    
    func createString(content: String) -> UILabel {
        let label = UILabel(frame: .zero)
        label.text = content
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }
    
    func createButton() -> UIButton {
        let button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.setTitle("Close", for: .normal)
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        return button
    }
    
    func createHeader(label: String) -> UILabel {
        let header = UILabel(frame: .zero)
        header.text = label
        header.textAlignment = .center
        header.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        header.font = UIFont.boldSystemFont(ofSize: 25)
        return header
    }
    
   @objc func buttonTapped() {
        self.dismiss(animated: true, completion: nil)
   }
    
    func stackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    func buttonConstraints(button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
    }
    
    func headerConstraints(title: UILabel) {
        title.translatesAutoresizingMaskIntoConstraints = false
        title.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        title.heightAnchor.constraint(equalToConstant: 40).isActive = true
        title.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -40).isActive = true
//        title.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: 20).isActive = true
        title.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.layer.cornerRadius = 6
        subView.layer.borderWidth = 1
        subView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
