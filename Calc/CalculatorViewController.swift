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
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(describing: newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
            
            isInTheMiddleOfTyping = true
        }
    }

}

