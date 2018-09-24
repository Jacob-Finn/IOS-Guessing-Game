//
//  ViewController.swift
//  IOS Guessing Game
//
//  Created by Jacob Finn on 8/19/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var actualNumber = -1
    var gameOver = false
    var randomNumber = Int(arc4random_uniform(99)) + 1
    var attempts = 0
    var finalScore = 0
    var timer: Timer? = nil
    var colorTimer: Timer? = nil
    let randomColors = [UIColor.red, UIColor.blue, UIColor.black,
                        UIColor.orange, UIColor.green, UIColor.cyan,
                        UIColor.brown, UIColor.purple, UIColor.magenta,
                        UIColor.darkGray, UIColor.yellow]
    
    @IBOutlet weak var correctBox: UIView!
    @IBOutlet weak var cheaterLabel: UILabel!
    @IBOutlet weak var attemptLabel: UILabel!
    @IBOutlet weak var ourButton: UIButton!
    @IBOutlet weak var ourTextBox: UITextField!
    @IBOutlet weak var ourLabel: UILabel!
    var userInput: String?
    
    
    
    @IBAction func Tapped(_ sender: Any) {
        if !gameOver {
        userInput = ourTextBox.text
        checkUserInput(input: userInput)
        }else {     // game is over at this point
            attempts = 0
            attemptLabel.text = String(attempts)
            ourButton.setTitle("Finalize your decision", for: UIControlState.normal)
            gameOver = false
        }
    }
    
    override func viewDidLoad() {
        cheaterLabel.text = String(randomNumber)
        correctBox.isHidden = true
    }
    
    
    func checkUserInput (input: String?)
    {
        if let userInput = Int(input!)
        {
            if userInput == randomNumber
            {
                ourLabel.text = "Good job!\nYou got it!\nReseting the number!"
                let oldNumber = randomNumber
                randomNumber = Int(arc4random_uniform(99)) + 1
                if oldNumber == randomNumber {
                    randomNumber = Int(arc4random_uniform(99)) + 1
                    
                }
                visuallyRewardUser()
                cheaterLabel.text = String(randomNumber)
                attempts = 0
                attemptLabel.text = String(attempts)
            }else if userInput < randomNumber
            {
                ourLabel.text = "Too low!"
                attempts += 1
                print(attempts)
                attemptLabel.text = String(attempts)
                checkAttempts()
                
            }else if userInput > randomNumber
            {
                ourLabel.text = "Too high!"
                attempts += 1
                attemptLabel.text = String(attempts)
                checkAttempts()
            }
        }
        else
        {
            ourLabel.text = "That's not a number!"
        }
    }
    func checkAttempts () {
        if attempts == 7 {
            gameOver = true
            ourButton.setTitle("Retry?", for: UIControlState.normal)
            ourLabel.text = "You lost!"
        }
    }
    
    
    func visuallyRewardUser() {
        correctBox.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(hideRewardBox), userInfo: nil, repeats: false)
        colorTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(randomizeColor), userInfo: nil, repeats: true)
    }
    
    @objc func randomizeColor() {
        print("changing colxor")
        let randomSelector = Int(arc4random_uniform(UInt32(randomColors.count)))
        correctBox.backgroundColor = randomColors[randomSelector]
        if correctBox.isHidden == true {
            colorTimer?.invalidate()
            
        }
    }
    
    
    @objc func hideRewardBox() {
        timer?.invalidate()
        correctBox.isHidden = true
    }
    
    
}


