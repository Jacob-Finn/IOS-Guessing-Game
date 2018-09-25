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
    var randomNumber = Int(arc4random_uniform(100))
    var attemptsValue: Int = 0 {
        didSet {
            attemptLabel.text = String(attemptsValue)
        }
    }
    var userSettings = UserSettings(wins: 0, loses: 0)
    var finalScore = 0
    let colorDictionary = [0: UIColor.white, 1: UIColor.red, 2: UIColor.blue, 3:UIColor.green, 4: UIColor.cyan]
    // This value will be selected from the picker later on.
    
 
    @IBOutlet weak var highestNumberSlider: UISlider!
    @IBOutlet weak var highestNumberLabel: UILabel!
    @IBOutlet weak var cheaterLabel: UILabel!
    @IBOutlet weak var attemptLabel: UILabel!
    @IBOutlet weak var ourButton: UIButton!
    @IBOutlet weak var ourTextBox: UITextField!
    @IBOutlet weak var ourLabel: UILabel!
    var userInput: String?
    
    
    
    
    
    
    
    @IBAction func ringVolumeSliderChange(_ sender: UISlider)
    {
        sender.setValue(sender.value.rounded(.down), animated: true)
    }
    
    @IBAction func maxValueChanged(_ sender: Any) {
        let sliderInt = Int(highestNumberSlider.value)
        highestNumberLabel.text = String(sliderInt)
        randomNumber = Int(arc4random_uniform(UInt32(sliderInt)))
        cheaterLabel.text = String(randomNumber)
    }
    
    
    @IBAction func Tapped(_ sender: Any) {
        if !gameOver {
        userInput = ourTextBox.text
        checkUserInput(input: userInput)
        }else {     // game is over at this point
            attemptsValue = 0
            ourButton.setTitle("Finalize your decision", for: UIControl.State.normal)
            gameOver = false
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if DataManagement.saveExists() { // The data manager checks if data exists and if it does, we try to load it
            userSettings = DataManagement.loadData()!
        }
        view.backgroundColor = colorDictionary[userSettings.colorChoice]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        cheaterLabel.text = String(randomNumber)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func checkUserInput (input: String?)
    {
        if let userInput = Int(input!)
        {
            if userInput == randomNumber
            {
                ourLabel.text = "Good job!\nYou got it!\nReseting the number!"
                let oldNumber = randomNumber
                randomNumber = Int(arc4random_uniform(100))
                userSettings.wins += 1
                DataManagement.saveData(userSettings: userSettings)
                if oldNumber == randomNumber {
                    randomNumber = Int(arc4random_uniform(100))
                    
                }
                cheaterLabel.text = String(randomNumber)
                attemptsValue = 0
            }else if userInput < randomNumber
            {
                ourLabel.text = "Too low!"
                attemptsValue += 1
                checkAttempts()
                
            }else if userInput > randomNumber
            {
                ourLabel.text = "Too high!"
                attemptsValue += 1
                checkAttempts()
            }
        }
        else
        {
            ourLabel.text = "That's not a number!"
        }
    }
    func checkAttempts () {
        if attemptsValue == 7 {
            gameOver = true
            ourButton.setTitle("Retry?", for: UIControl.State.normal)
            ourLabel.text = "You lost!"
            userSettings.loses += 1
            DataManagement.saveData(userSettings: userSettings)
        }
    }
    
  
    
    
    
    /*
    func visuallyRewardUser() {
        correctBox.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(hideRewardBox), userInfo: nil, repeats: false)
        colorTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(randomizeColor), userInfo: nil, repeats: true)
    }
    
    @objc func randomizeColor() {
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
    
*/
}


