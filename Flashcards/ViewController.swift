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
    var answerOne: String
    var answerTwo: String
    var answerThree: String
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var answerOne: UIButton!
    @IBOutlet weak var answerThree: UIButton!
    @IBOutlet weak var answerTwo: UIButton!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var card: UIView!
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
            updateFlashcard(question: "What is the Captial of Japan", answer: "Tokyo", extraAnswerOne: "Seoul", extraAnswerTwo: "Beijing", extraAnswerThree: "Tokyo")
        }else{
            updateLabels()
            updatePrevNextButtons()
        }
        // Do any additional setup after loading the view.
    }
    func showAnswers(){
        answerOne.isHidden = false
        answerTwo.isHidden = false
    }
    func showQuestion(){
        frontLabel.isHidden = false
    }
    
    @IBAction func didTapOnAnswerOne(_ sender: Any) {
        answerOne.isHidden = true
    }
    
    @IBAction func didTapOnAnswerTwo(_ sender: Any) {
        answerTwo.isHidden = true
    }
    
    @IBAction func didTapOnAnswerThree(_ sender: Any) {
        flipFlashcard()
        
    }
    func cardIn(){
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        UIView.animate(withDuration: 0.3){
            self.card.transform = CGAffineTransform.identity
            self.updateLabels()
        }
    }
    
    func cardOut(x: Float , y: Float ){
        UIView.animate(withDuration: 0.3,animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        }, completion: { finshed in
            self.updateLabels()
            self.cardIn()
        })
    }
    func flipFlashcard(){
        UIView.transition(with: card, duration: 0.3,options: .transitionFlipFromRight) {
            self.frontLabel.isHidden = !self.frontLabel.isHidden
        }
        
    }
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return["question": card.question, "answer": card.answer, "extraAnswerOne": card.answerOne, "extraAnswerTwo": card.answerTwo,"extraAnswerThree": card.answerThree]
        }
        UserDefaults.standard.set(flashcards, forKey: "flashcards")
        print("We saved flashcards on to UserDefaults")
    }
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as?[[String: String]]{
            let savedCards = dictionaryArray.map { dictionary -> Flashcards in
                return Flashcards(question: dictionary["question"]!, answer: dictionary["answer"]!,answerOne: dictionary["extraAnswerOne"]!,answerTwo: dictionary["extraAnswerTwo"]!,answerThree: dictionary["extraAnswerThree"]!)
            }
            flashcards.append(contentsOf: savedCards)
            }
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
       flipFlashcard()
    }
    @IBAction func didtTapOnPrev(_ sender: Any) {
      currentIndex = currentIndex - 1
        updatePrevNextButtons()
        cardIn()
    }
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        updatePrevNextButtons()
        cardOut(x:-300.0, y: 0.0)
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
        showAnswers()
        showQuestion()
    }
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
       }
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String, extraAnswerTwo: String, extraAnswerThree: String){
        let flashcard = Flashcards(question: question, answer: answer, answerOne: extraAnswerOne,answerTwo: extraAnswerTwo,answerThree: extraAnswerThree)
        frontLabel.text = question
        backLabel.text = answer
        answerOne.setTitle(extraAnswerOne,for:.normal)
        answerTwo.setTitle(extraAnswerTwo,for:.normal)
        answerThree.setTitle(extraAnswerThree,for:.normal)
        flashcards.append(flashcard)
        print("Added a new flashcard, take a look ->",flashcards)
        print("We have \(flashcards.count) flashcards")
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        updatePrevNextButtons()
        updateLabels()
        showAnswers()
        showQuestion()
      
    }

    
}



