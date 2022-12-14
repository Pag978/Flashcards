//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Pagnar Meas on 9/30/22.
//

import UIKit

class CreationViewController: UIViewController {
    
var flashcardsController: ViewController!
    
    @IBOutlet weak var answerThreeTextField: UITextField!
    @IBOutlet weak var answerTwoTextField: UITextField!
    @IBOutlet weak var answerOneTextField: UITextField!
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var answerTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
   
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        let answerOneText = answerOneTextField.text
        let answerTwoText = answerTwoTextField.text
        let answerThreeText = answerThreeTextField.text
        if(questionText == nil || answerText == nil || answerOneText == nil || answerTwoText == nil || answerThreeText == nil || questionText!.isEmpty || answerText!.isEmpty || answerOneText!.isEmpty || answerTwoText!.isEmpty || answerThreeText!.isEmpty){
            let alert = UIAlertController(title: "Missing Text",message:"You need to enter a question and answer!", preferredStyle: UIAlertController.Style .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            present (alert,animated: true)
            alert.addAction(okAction)
        }else{
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraAnswerOne: answerOneText!, extraAnswerTwo: answerTwoText!, extraAnswerThree: answerThreeText!)
        dismiss(animated: true)
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
