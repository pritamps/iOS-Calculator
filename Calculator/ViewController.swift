//
//  ViewController.swift
//  Calculator
//
//  Created by Pritam Sukumar on 21/07/17.
//  Copyright © 2017 Pritam Sukumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var calcDisplay: UILabel!
    var userTyping = false
    
    private var brain = CalculatorBrain()
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!;
        let text = calcDisplay.text!
        if userTyping {
            calcDisplay.text = text + digit
        }
        else {
            calcDisplay.text = digit
            userTyping = true
        }
    }
    
    var displayValue : Double {
        get {
            return Double(calcDisplay.text!)!
        }
        set {
            calcDisplay.text = String(newValue)
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userTyping {
            brain.setOperand(displayValue)
            
        }
        userTyping = false
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
            if let result = brain.result {
                displayValue = result
            }
        }
    }
}

