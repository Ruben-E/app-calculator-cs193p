//
//  ViewController.swift
//  Calculator
//
//  Created by Ruben Ernst on 05-08-16.
//  Copyright © 2016 Ruben Ernst. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var display: UILabel!

    private var calculator: Calculator = Calculator()
    private var userIsTyping = false
    
    @IBAction private func didTouchDigit(sender: UIButton) {
        if let digit = sender.currentTitle {
            if (digit == "." && (!userIsTyping || userIsTyping && containsDot())) {
                return;
            }

            var newDisplayText = digit;
            let currentText: String? = readDisplay()
            if (userIsTyping && currentText != nil) {
                newDisplayText = currentText! + digit
            }

            setDisplayTo(newDisplayText)
            userIsTyping = true
        }
    }

    @IBAction private func performOperation(sender: UIButton) {
        if let symbol = sender.currentTitle {
            calculator.performOperation(symbol)
        }

        setDisplayTo(calculator.result)
        reset();
    }

    private func containsDot() -> Bool {
        if let currentText: String = readDisplay() {
            return currentText.rangeOfString(".") != nil
        }
    }

    private func setDisplayTo(value: String) {
        display.text = value;
        calculator.setOperand(Double(value)!)
    }

    private func setDisplayTo(value: Double) {
        setDisplayTo(String(value))
    }

    private func readDisplay() -> Double? {
        if let text: String = readDisplay() {
            return Double(text)
        }

        return nil
    }

    private func readDisplay() -> String? {
        return display.text
    }
    
    private func reset() {
        userIsTyping = false;
    }
}

