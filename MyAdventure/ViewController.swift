//
//  ViewController.swift
//  MyAdventure
//
//  Created by Ben Hardy on 6/16/23.
//

import UIKit
struct Question {
    
    init(_ ques: String, _ o_one:String, _ o_two: String, _ ans: String) {
        question = ques
        option_one = o_one
        option_two = o_two
        answer = ans
    }
    
    var question: String
    var answer: String
    var option_one: String
    var option_two: String
    
}


class ViewController: UIViewController {
    
    
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var optionOne: UIButton!
    
    @IBOutlet weak var optionTwo: UIButton!
    
    var questionIndex : Int = 0
    
    let question = [
                Question("Your uncle Bilbo has left you his old ring, what should you do with it?",
                         "Throw it away.",
                         "Keep it Secret. Keep it Safe.",
                         "Keep it Secret. Keep it Safe."),
                Question("You were to meet Gandalf at the Prancing Pony, but he has not yet arrived. What will you do?",
                         "Trust in the mysterious stranger, Strider.",
                         "Head off alone.",
                         "Trust in the mysterious stranger, Strider."),
                Question("Oh No! You've been stabbed by a morgul blade on Weathertop. Where should they take you?",
                         "The Last Homely House, Rivendell.",
                         "The local urgent care.",
                         "The Last Homely House, Rivendell."),
                Question("The council of Elrond agrees that the rings must be destroyed. How do you respond?",
                         "But it is a gift! A gift to the foes of Mordor.",
                         "I will take it! I will take the ring to Mordor.",
                         "I will take it! I will take the ring to Mordor.")
            ]

        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            updateUI()
        }
    
        
    @IBAction func answerSubmitted(_ sender: UIButton) {
        let answerSubmitted = sender.titleLabel!.text!
        let isCorrect = compareUserAnswer(answerSubmitted)
        
        if isCorrect {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
            background.image = UIImage(named: "lose_bg")
            endGameLose()
            return
        }
        
        increaseIndex()
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    @objc func updateUI() {
        questionLabel.text = question[questionIndex].question
        //background.image = UIImage(named: String(questionIndex + 1))
        optionOne.setTitle(question[questionIndex].option_one, for: .normal)
        optionTwo.setTitle(question[questionIndex].option_two, for: .normal)
        
        optionOne.backgroundColor = UIColor.clear
        optionTwo.backgroundColor = UIColor.clear


    }
    
    func compareUserAnswer(_ response : String) -> Bool {
        if response == question[questionIndex].answer {
            return true
        } else {
            return false
        }
    }
    
    func increaseIndex() {
        questionIndex += 1

            if questionIndex == question.count {
                endGameWin()
                return
            }
    }
    
    func endGameWin() {
        questionLabel.text = "You've chosen wisely. The Fellowship of the Ring heads south."
        background.image = UIImage(named: "win_bg")
        optionOne.isEnabled = false
        optionTwo.isEnabled = false
    }
    func endGameLose() {
        questionLabel.text = "You've chosen poorly. The ring has fallen into enemy hands."
           
           // Disable the option buttons
           optionOne.isEnabled = false
           optionTwo.isEnabled = false
    }

}

