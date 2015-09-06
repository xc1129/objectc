//
//  ViewController.swift
//  Calculator
//
//  Created by Spirit_xc on 15/9/5.
//  Copyright (c) 2015年 Spirit_xc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    

    var userIsInTheMiddleOfTypingANumber = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit;
        }
        else {
            display.text = digit;
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
            case "✕": performOperation(mutiply)
            case "÷": performOperation(divide)
            case "+": performOperation(plus)
            case "-": performOperation(minus)
            case "√": performOperation(square)
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2  {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1  {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    func mutiply(op1: Double,op2: Double) -> Double {
        return op1 * op2
    }
    
    func divide(op1: Double,op2: Double) -> Double {
        return op2 / op1
    }
    
    func plus(op1: Double,op2: Double) -> Double {
        return op1 + op2
    }
    
    func minus(op1: Double,op2: Double) -> Double {
        return op1 - op2
    }
    
    func square(op1: Double) ->Double {
        return sqrt(op1);
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        println(operandStack);
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }

}

