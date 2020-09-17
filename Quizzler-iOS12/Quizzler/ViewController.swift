//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    var allQuestions = QuestionBank();
    var currentQuestion:Int = 0;
    var score:Int = 0;
    var givenAnswer:Bool = false
    var totalQuestions:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalQuestions = allQuestions.list.count
        nextQuestion()
        
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if(sender.tag == 1) {
            givenAnswer = true;
        }else {
            givenAnswer = false;
        }
        checkAnswer()
        
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score : \(score)"
        progressLabel.text = "\(currentQuestion+1)/\(totalQuestions)"
        progressBar.frame.size.width = (view.frame.width/CGFloat(totalQuestions)) * CGFloat(currentQuestion)
    }
    

    func nextQuestion() {
        if currentQuestion <= 12{
            questionLabel.text = allQuestions.list[currentQuestion].questionText;
            updateUI()
        }else {
            let finishedAlert = UIAlertController(title: "Awesome!", message: "You have answered all the questions! start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {
                (UIAlertAction) in
                self.startOver()
            }  )
            finishedAlert.addAction(restartAction)
            present(finishedAlert, animated: true)
            print("end")
        }
    }
    
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[currentQuestion].answer
        if(givenAnswer == correctAnswer) {
            ProgressHUD.showSuccess("Correct!")
            currentQuestion += 1;
            score += 1;
            nextQuestion()
        }else {
            ProgressHUD.showError("Incorrect!")
            print("wrong answer")
        }
        
    }
    
    
    func startOver() {
        currentQuestion = 0;
        score = 0;
        nextQuestion()
    }
    

    
}
