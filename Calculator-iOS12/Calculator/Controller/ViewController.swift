//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var isFinishedTypNum:Bool = true
    private var isDouble:Bool = false
    
    
    private var displayValue:Double {
        get {
            guard let num = Double(displayLabel.text!) else {
                fatalError("Cannot Convert Label Text To A Number")
            }
            return num
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    private var calculator = CalculatorLogic()
    
    @IBOutlet weak var displayLabel: UILabel!
    
    
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
        isFinishedTypNum = true
        calculator.setNumber(displayValue)
        if let calcButton = sender.currentTitle {
            guard  let result = calculator.calculate(symbol: calcButton) else {
                fatalError("Calculate returned nil")
            }
            displayValue = result
        }
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
        if let numPressed = sender.currentTitle {
            if isFinishedTypNum {
                isDouble=false
                displayLabel.text = numPressed
                isFinishedTypNum = false
            }else{
                if numPressed == "." {
                    
                    isDouble = floor(displayValue) != displayValue
                    if isDouble {
                        return
                    }
                       
                }
                displayLabel.text = displayLabel.text! + numPressed
            }
        }
        
    
    }

}

