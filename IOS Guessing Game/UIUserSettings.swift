//
//  UIUserSettings.swift
//  IOS Guessing Game
//
//  Created by Jacob Finn on 9/25/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//


import UIKit
class UIUserSettings: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let colorNames = ["White", "Red", "Blue", "Green", "Cyan"]
    let colorData = [UIColor.white, UIColor.red, UIColor.blue, UIColor.green, UIColor.cyan]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return colorData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colorNames[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userSettings.colorChoice = row
    }
    

    
    var userSettings = UserSettings(wins: 0, loses: 0)

    @IBOutlet weak var loseValueLabel: UILabel!
    @IBOutlet weak var winValueLabel: UILabel!
    @IBOutlet weak var colorPicker: UIPickerView!
    
    func setWinsValue(to value: Int) {
        winValueLabel.text = "\(value)"
    }
    func setLosesValue(to value: Int) {
        loseValueLabel.text = String(value)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if DataManagement.saveExists() {
            userSettings = DataManagement.loadData()!
        }
        colorPicker.dataSource = self
        colorPicker.delegate = self
        colorPicker.selectRow(userSettings.colorChoice, inComponent: 0, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setWinsValue(to: userSettings.wins)
        setLosesValue(to: userSettings.loses)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DataManagement.saveData(userSettings: userSettings)
    }
    
    
}
