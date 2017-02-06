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
    
    private lazy var displayFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.alwaysShowsDecimalSeparator = false
            formatter.maximumFractionDigits = 6
            
            return formatter
    }()
    
    private var displayValue: Double {
        get {
            guard let displayNumber = Double(display.text!) else {
                return 0.0
            }
            return displayNumber
        }
        set {
            display.text = displayFormatter.string(for: newValue)
        }
    }
    
    @IBAction func digitPressed(_ sender: UIButton)
    {
        guard let buttonValue = sender.currentTitle else
        {
            return
        }
        
        if isInTheMiddleOfTyping
        {
            if !(buttonValue == "." && display.text?.range(of: ".") != nil)
            {
                display.text = display.text! + buttonValue
            }
        }
        else
        {
            display.text = buttonValue
        }
        
        if display.text == "0" && buttonValue == "0" {
            isInTheMiddleOfTyping = false
        }
        else {
            isInTheMiddleOfTyping = true
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
}

