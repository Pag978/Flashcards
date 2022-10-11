//
//  ViewController.swift
//  Flashcards
//
//  Created by Pagnar Meas on 9/13/22.
//

import UIKit

struct Flashcards{
    var question:String
    var answer: String
    
}

class ViewController: UIViewController {
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    var flashcards = [Flashcards]()
    var currentIndex = 0

    override func prepare( for segue: UIStoryboardSegue, sender: Any? ){
        
    let navigationController = segue.destination as! UINavigationController
        
    let creationController = navigationController.topViewController as! CreationViewController
        
    creationController.flashcardsController = self
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         readSavedFlashcards()
        if flashcards.count == 0{
            updateFlashcard(question: "What is the Captial of Japan", answer: "Tokyo")
        }else{
            updateLabels()
            updatePrevNextButtons()
        }
        // Do any additional setup after loading the view.
    }
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return["question": card.question, "answer": card.answer]
        }
        UserDefaults.standard.set(flashcards, forKey: "flashcards")
        print("We saved flashcards on to UserDefaults")
    }
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as?[[String: String]]{
            let savedCards = dictionaryArray.map { dictionary -> Flashcards in
                return Flashcards(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            flashcards.append(contentsOf: savedCards)
            }
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        frontLabel.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: { [self] in
            self.frontLabel.isHidden = false
})
                                      }
    
  @IBAction func didtTapOnPrev(_ sender: Any) {
      currentIndex = currentIndex - 1
          updateLabels()
          updatePrevNextButtons()
      
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        updateLabels()
        updatePrevNextButtons()
    }
    func updatePrevNextButtons(){
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        }else{
            nextButton.isEnabled = true
        }
        if currentIndex == 0 {
            prevButton.isEnabled = false
        }else{
            prevButton.isEnabled = true
        }
    }
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        
    }
    
    
    func updateFlashcard(question: String, answer: String){
        let flashcard = Flashcards(question: question, answer: answer)
        frontLabel.text = question
        backLabel.text = answer
        flashcards.append(flashcard)
        print("Added a new flashcard, take a look ->",flashcards)
        print("We have \(flashcards.count) flashcards")
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        updatePrevNextButtons()
        updateLabels()
      
    }

    
}



