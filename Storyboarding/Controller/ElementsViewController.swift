//
//  ElementsViewController.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/14/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit



class ElementsViewController: UIViewController {
    
    
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    var genreTitle: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupView()

        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        let elementView = ElementsView(frame: self.view.frame)
        view.addSubview(elementView)
    }
    
    func setupNav() {
        navigationItem.title = genreTitle
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
    }
    
    @objc func isExpandedButtonTapped(sender: UIButton!) {
        
        print("isExpanded tapped")
        if sender.titleLabel?.text == "Collapse" {
            sender.setTitle("Expand", for: .normal)
        } else {
            sender.setTitle("Collapse", for: .normal)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
