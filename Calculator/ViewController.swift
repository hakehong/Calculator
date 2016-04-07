//
//  ViewController.swift
//  Calculator
//
//  Created by hongqing on 15/8/1.
//  Copyright © 2015年 hongqing. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var userIsInTheMiddleOfTypingANumber=false
    
    @IBOutlet weak var display: UILabel!
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit=sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
        display.text=display.text! + digit
        }
        else{
            display.text=digit
            userIsInTheMiddleOfTypingANumber=true
        }
         //print("digit=\(digit)")
    }
    
    @IBAction func operate(sender: UIButton)
    {
        let operation=sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber
        {
            enter()
        }
        switch operation
        {
        case "×":performOperation{$0*$1}
        case "÷":performOperation{$1/$0}
        case "+":performOperation{$0+$1}
        case "−":performOperation{$1-$0}
        case "√":performOperations{sqrt($0)}
        default:break
        
        }
    }
    func performOperation(operation:(Double,Double)->Double)
    {
        if operandStack.count>=2
        {
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    /*
    *****显然你这个类继承了一个Objective-C的类，Objective-C不支持方法重载，而这两个方法的selector是一样的，所以就错了
    */
    func performOperations(operation: Double -> Double )
    {
        if operandStack.count>=1
        {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    var operandStack=Array<Double>()
        
     @IBAction func enter()
     {
        userIsInTheMiddleOfTypingANumber=false
        operandStack.append(displayValue)
        print("operandStack=\(operandStack)")
    }
    var displayValue:Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text="\(newValue)"
            userIsInTheMiddleOfTypingANumber=false
        }
    }
    


}

