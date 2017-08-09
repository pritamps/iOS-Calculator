//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Pritam Sukumar on 21/07/17.
//  Copyright © 2017 Pritam Sukumar. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform (with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private var operations: Dictionary<String, Operation> = [
        "pi": Operation.constant(Double.pi), //Double.pi
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "sin": Operation.unaryOperation(sin),
        "x": Operation.binaryOperation({ $0 * $1 }),
        "/": Operation.binaryOperation({ $0 / $1 }),
        "+": Operation.binaryOperation({ $0 + $1 }),
        "-": Operation.binaryOperation({ $0 - $1 }),
        "=": Operation.equals
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let operation):
                if let value = accumulator {
                    accumulator = operation(value)
                }
            case .binaryOperation(let operation):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: operation, firstOperand: accumulator!)
                    accumulator = nil
                }
                break
            case .equals:
                performPendingBinaryOperation()
                break
            }
        }
        
    }
    
    mutating private func performPendingBinaryOperation() {
        if accumulator != nil && pendingBinaryOperation != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
        
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
}
