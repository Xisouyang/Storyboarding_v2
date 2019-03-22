//
//  GenreViewController.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class GenreViewController: UIViewController {
    
    var delegate: GenreViewDelegate?
    
    var genreView: UIView!
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    var addButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        
        let collectionHeight = view.frame.height
        - navigationController!.navigationBar.frame.height
        genreView = GenreView(frame: self.view.frame, collectionHeight: collectionHeight)
        self.delegate = genreView as? GenreViewDelegate
        view.addSubview(genreView)
    }
    
    func setupNav() {
        navigationItem.title = "Genres"
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        addButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = addButtonItem
    }
    
    @objc func addTapped() {
        print("genreVC add button tapped")
        let newController = ElementsViewController()
        if self.delegate?.returnGenreTitle() == "NIL" {
            noGenreSelected()
        } else {
            newController.genreTitle = self.delegate?.returnGenreTitle()
            print(newController.genreTitle)
            self.navigationController?.pushViewController(newController, animated: true)
        }
    }
    
    func noGenreSelected() {
        let alert = UIAlertController(title: "Please select a genre", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        self.present(alert, animated: true)
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
