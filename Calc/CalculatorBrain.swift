//
//  CalculatorBrain.swift
//  Calc
//
//  Created by Vladimir Koychev on 05/02/2017.
//  Copyright © 2017 Vladimir Koychev. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    private var accumulator = 0.0
    
    public lazy var displayFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.alwaysShowsDecimalSeparator = false
        formatter.maximumFractionDigits = 6
        
        return formatter
    }()

    func setOperand(_ operand: Double)
    {
        accumulator = operand
    }
    
    private enum Operations {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
        case Backspace
        case ClearDisplay
    }
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    private let operations: Dictionary<String, Operations> = [
        "√" : .UnaryOperation(sqrt),
        "±" : .UnaryOperation({-$0}),
        "+" : .BinaryOperation(+),
        "-" : .BinaryOperation(-),
        "*" : .BinaryOperation(*),
        "÷" : .BinaryOperation({$0 / $1}),
        "=" : .Equals,
        "🔙" : .Backspace,
        "AC" : .ClearDisplay
    ]
    
    func perform(operation symbol: String)
    {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            case .Backspace:
                if let displayString = displayFormatter.string(for:accumulator)
                {
                    let truncatedText = displayString.substring(to: displayString.index(before: displayString.endIndex))
                    if let truncatedNumber = displayFormatter.number(from: truncatedText) {
                        accumulator = truncatedNumber.doubleValue
                    }
                }
                break
            case .ClearDisplay:
                accumulator = 0
                pending = nil
            }
        }
    }
    
    private func executePendingBinaryOperation()
    {
        if (pending != nil)
        {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
}
