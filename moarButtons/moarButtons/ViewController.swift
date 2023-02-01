//
//  ViewController.swift
//  moarButtons
//
//  Created by Anastasia Nevodchikova on 09.01.2023.
//

import UIKit

class ViewController: UIViewController {
    enum Operators {
        case plus, minus, divided, multiply
    }
    
    var currentOperator: Operators? = nil
    
    
    //Int8 - tests
    var currentValue: Int8? = 0
    
    var savedValue: (Int8, Operators)?
    
    var previousInputIsNumber = false

    @IBOutlet weak var resultLabel: UILabel!
    
    func    inputNumber(number: String) {
        if (resultLabel.text == "0" || previousInputIsNumber == false ) {
            resultLabel.text = number
            previousInputIsNumber = true
        }
        else {
            resultLabel.text?.append(number)
        }
    }
    
    @IBAction func oneNumberButton(_ sender: UIButton) {
        print("Number one")
        inputNumber(number: "1")
    }
    
    @IBAction func twoNumberButton(_ sender: UIButton) {
        print("Number two")
        inputNumber(number: "2")
    }
    
    @IBAction func threeNumberButton(_ sender: UIButton) {
        print("Number three")
        inputNumber(number: "3")
    }
    
    @IBAction func fourNumberButton(_ sender: UIButton) {
        print("Number four")
        inputNumber(number: "4")
    }
    
    @IBAction func fiveNumberButton(_ sender: UIButton) {
        print("Number five")
        inputNumber(number: "5")
    }
    
    @IBAction func sixNumberButton(_ sender: UIButton) {
        print("Number six")
        inputNumber(number: "6")
    }
    
    @IBAction func sevenNumberButton(_ sender: UIButton) {
        print("Number seven")
        inputNumber(number: "7")
    }
    
    @IBAction func eightNumberButton(_ sender: UIButton) {
        print("Number eight")
        inputNumber(number: "8")
    }
    
    @IBAction func nineNumberButton(_ sender: UIButton) {
        print("Number nine")
        inputNumber(number: "9")
    }
    
    @IBAction func zeroNumberButton(_ sender: UIButton) {
        print("Number zero")
        inputNumber(number: "0")
    }
    
    @IBAction func acButton(_ sender: UIButton) {
        print("Reset the calculator")
        resultLabel.text = "0"
        currentValue = 0
        currentOperator = nil
        previousInputIsNumber = false
        savedValue = nil
    }
    
    @IBAction func negButton(_ sender: UIButton) {
        print("Change the sign of the current number")
        if let result = Int8(resultLabel.text!)
        {
            if (result > 0) {
                resultLabel.text?.insert("-", at: resultLabel.text!.startIndex)
            }
            else if (result < 0)
            {
                resultLabel.text?.remove(at: resultLabel.text!.startIndex)
            }
        }
        currentValue = Int8(resultLabel.text!)!
        previousInputIsNumber = false

    }
    
    func    getSavedValue() -> Int8 {
        let tmpValue = currentValue
        currentValue = savedValue!.0
        return tmpValue!
    }
    
    func    printResultCalculate (result: Int8) {
        resultLabel.text = String(currentValue!)
    }
    
    func calculate(operatorState: Operators, value: Int8) throws -> Int8 {
        guard currentValue != nil else { throw NSError(domain: "Error current value", code: 1) }
            switch operatorState {
            case .plus:
                    return currentValue! + value;
                case .minus:
                    return currentValue! - value;
                case .multiply:
                    return currentValue! * value;
                case .divided:
                    guard value != 0 else { throw NSError(domain: "Divided by 0", code: 2) }
                    return currentValue! / value;
        }
    }
    
    func    initSavedValue() throws
    {
        savedValue = (currentValue!, currentOperator!)
        guard Int8(resultLabel.text!) != nil else { throw NSError(domain: "Error overflows", code: 3) }
        currentValue = Int8(resultLabel.text!)!
    }
    
    func processingError(error: Error) {
        print(error.localizedDescription)
        resultLabel.text = "Error"
        currentValue = nil
    }
    

    
    func    processingOperator() throws {
        if currentValue == 0 {
            guard Int8(resultLabel.text!) != nil else { throw NSError(domain: "Error overflows", code: 3) }
            currentValue = Int8(resultLabel.text!)!
        }
        previousInputIsNumber = false
    }
    
    @IBAction func plusButton(_ sender: UIButton) {
        print("Addition operation")
        if (previousInputIsNumber == true) {
            do {
                try processingOperator()
                if (resultLabel.text != nil && currentOperator != nil) {
                        currentValue = try calculate(operatorState: currentOperator!, value: Int8(resultLabel.text!)!)
                        if (savedValue != nil) {
                            currentValue = try calculate(operatorState: savedValue!.1, value: getSavedValue())
                        }
                        printResultCalculate(result: currentValue!)
                }
            }
            catch let error {
                    processingError(error: error)
            }
        }
        currentOperator = Operators.plus
    }
    
    @IBAction func multiplyButton(_ sender: UIButton) {
        print("Multiplication operation")
        if (previousInputIsNumber == true) {
            do {
                try processingOperator()
                if (currentOperator == .plus || currentOperator == .minus) {
                
                    try initSavedValue()
                }
                else {
                    if (resultLabel.text != nil && currentOperator != nil) {
                            currentValue = try calculate(operatorState: currentOperator!, value: Int8(resultLabel.text!)!)
                            if (savedValue != nil) {
                                currentValue = try calculate(operatorState: savedValue!.1, value: getSavedValue())
                            }
                            printResultCalculate(result: currentValue!)
                        }
                }
            }
            catch let error {
                processingError(error: error)
            }
        }
        currentOperator = Operators.multiply
    }
    
    @IBAction func minusButton(_ sender: UIButton) {
        print("Subtraction operation")
        if (previousInputIsNumber == true) {
            do {
                try processingOperator()
                if (resultLabel.text != nil && currentOperator != nil) {
                        currentValue = try calculate(operatorState: currentOperator!, value: Int8(resultLabel.text!)!)
                        if (savedValue != nil) {
                            currentValue = try calculate(operatorState: savedValue!.1, value: getSavedValue())
                        }
                        printResultCalculate(result: currentValue!)
                    }
            }
            catch let error {
                processingError(error: error)
            }
        }
        currentOperator = Operators.minus
    }
    
    @IBAction func dividedButton(_ sender: UIButton) {
        print("Division operation")
        if (previousInputIsNumber == true) {
            do {
                try processingOperator()
                if (currentOperator == .plus || currentOperator == .minus) {
                    try initSavedValue()
                }
                else {
                    if (resultLabel.text != nil && currentOperator != nil) {
                            currentValue = try calculate(operatorState: currentOperator!, value: Int8(resultLabel.text!)!)
                            if (savedValue != nil) {
                                currentValue = try calculate(operatorState: savedValue!.1, value: getSavedValue())
                            }
                            printResultCalculate(result: currentValue!)
                        }
                }
            }
            catch let error {
                processingError(error: error)
            }
        }
        currentOperator = Operators.divided
    }
    
    @IBAction func equalsButton(_ sender: UIButton) {
        print("Compute the operation with the 2 operands")
        do {
            try processingOperator()
            if (resultLabel.text != nil && currentOperator != nil) {
                    currentValue = try calculate(operatorState: currentOperator!, value: Int8(resultLabel.text!)!)
                    if (savedValue != nil) {
                        currentValue = try calculate(operatorState: savedValue!.1, value: getSavedValue())
                    }
                    printResultCalculate(result: currentValue!)
                }
        }
        catch let error {
            processingError(error: error)
        }
        currentOperator = nil
        savedValue = nil
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

