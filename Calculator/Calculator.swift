//
//  Calculator.swift
//  Calculator
//
//  Created by Ruben Ernst on 05-08-16.
//  Copyright © 2016 Ruben Ernst. All rights reserved.
//

import Foundation

class Calculator {
    private var accumulator = 0.0
    private var description = ""
    private var pendingBinaryOperation: PendingBinaryOperationInfo?

    private var operations: Dictionary<String, Operation> = [
            "π": Operation.Constant(M_PI),
            "e": Operation.Constant(M_E),
            "√": Operation.UnaryOperator(sqrt),
            "x": Operation.BinaryOperator({ $0 * $1 }),
            "-": Operation.BinaryOperator({ $0 - $1 }),
            "+": Operation.BinaryOperator({ $0 + $1 }),
            "/": Operation.BinaryOperator({ $0 / $1 }),
            "=": Operation.Equals
    ]

    private enum Operation {
        case Constant(Double);
        case UnaryOperator((Double) -> Double)
        case BinaryOperator((Double, Double) -> Double)
        case Equals
    }

    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }

    func setOperand(operand: Double) {
        accumulator = operand;
    }

    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch (operation) {
            case .Constant(let value): accumulator = value
            case .UnaryOperator(let function): accumulator = function(accumulator)
            case .BinaryOperator(let function): pendingBinaryOperation = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                if (pendingBinaryOperation != nil) {
                    accumulator = pendingBinaryOperation!.binaryFunction(pendingBinaryOperation!.firstOperand, accumulator)
                    pendingBinaryOperation = nil
                }
            }
        }
    }

    var result: Double {
        get {
            return accumulator;
        }
    }
}
