//
//  ViewController.swift
//  Flashcards
//
//  Created by Pagnar Meas on 9/13/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var backLable: UILabel!
    @IBOutlet weak var frontLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapFlashCard(_ sender: Any) {
        print("Hey it works")
        frontLable.isHidden = true
    }
    
}

