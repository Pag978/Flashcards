//
//  ViewController.swift
//  Flashcards
//
//  Created by Pagnar Meas on 9/13/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var answerOne: UIButton!
    @IBOutlet weak var answerTwo: UIButton!
    @IBOutlet weak var answerThree: UIButton!

    override func prepare( for segue: UIStoryboardSegue, sender: Any? ){
        
    let navigationController = segue.destination as! UINavigationController
        
    let creationController = navigationController.topViewController as! CreationViewController
        
    creationController.flashcardsController = self
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        frontLabel.isHidden = true
       
    }
    
    @IBAction func tapOnAnswerOne(_ sender: Any) {
   answerOne.backgroundColor = UIColor.red
    }
    
    
    
    
    func updateFlashcard(question: String, answer: String){
       frontLabel.text = question
      backLabel.text = answer
      
    }

    
}



