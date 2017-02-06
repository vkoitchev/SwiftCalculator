//
//  ViewController.swift
//  Calc
//
//  Created by Vladimir Koychev on 01/02/2017.
//  Copyright © 2017 Vladimir Koychev. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    private var isInTheMiddleOfTyping = false
    private let brain = CalculatorBrain()
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(describing: newValue)
        }
    }
    
    @IBAction func digitPressed(_ sender: UIButton)
    {
        if let buttonValue = sender.currentTitle
        {            
            if isInTheMiddleOfTyping
            {
                display.text = display.text! + buttonValue
            }
            else
            {
                display.text = buttonValue
            }
            
            if display.text == "0" {
                isInTheMiddleOfTyping = false
            }
            else {
                isInTheMiddleOfTyping = true
            }
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton)
    {
        if isInTheMiddleOfTyping
        {
            brain.setOperand(displayValue)
            isInTheMiddleOfTyping = false
        }
        
        if let operation = sender.currentTitle {
            brain.perform(operation: operation)
        }
        
        displayValue = brain.result
    }
    
    @IBAction func addFloatingPointIfNeeded(_ sender: UIButton)
    {
        guard let currentDisplay = display.text else {
            return
        }
        
        if !currentDisplay.contains(".")
        {
            display.text = currentDisplay + "."
            isInTheMiddleOfTyping = true
        }
    }
}

