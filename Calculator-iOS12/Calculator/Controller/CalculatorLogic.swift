//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Synerg IITBombay on 03/07/20.
//  Copyright © 2020 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    var number:Double?
    
    private var calcTuple: (n1: Double, method: String)?
    
    mutating func setNumber(_ number : Double) {
        self.number = number
    }
    
    mutating func calculate(symbol: String) -> Double? {
        if let num = number{
            if(symbol == "+/-"){
                return num * -1
            }else if(symbol == "AC"){
                return 0
            }else if(symbol == "%"){
                return num * 0.01
            }else if(symbol == "="){
                if let calcT = calcTuple{
                    print(calcT.method)
                    return getResult(num1: calcT.n1,num2: num, method: calcT.method)
                }
            }else{
                calcTuple = (n1:num,method: symbol)
                return 0
            }
            return nil
        }
        
        return nil
    }
    
    private func getResult(num1: Double,num2: Double,method: String)->Double{
        switch method {
        case "+":
            return num1 + num2
        case "-":
            return num1 - num2
        case "÷":
            return num1 / num2
        case "×":
            return num1 * num2
        default:
            return 0
        }
    }
    
}
