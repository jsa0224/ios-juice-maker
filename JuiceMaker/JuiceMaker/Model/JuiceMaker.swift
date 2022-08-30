//
//  JuiceMaker - JuiceMaker.swift
//  Created by som, LJ. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

// 쥬스 메이커 타입
struct JuiceMaker {
    let fruitStorage = FruitStore(defaultStack: 10)
    
    func grindFruit(juice: Juice) {
        for (fruit, fruitAmount) in juice.recipeOFJuice {
            if let stackEnough = fruitStorage.stack[fruit] {
                fruitStorage.stack.updateValue(stackEnough - fruitAmount, forKey: fruit)
            }
        }
    }
    
    func checkFruitStock(fruit: Fruit, amount: Int) throws {
        guard let fruitStack = fruitStorage.stack[fruit] else {
            throw OrderError.unknown
        }
        guard fruitStack >= amount else {
            throw OrderError.outOfStack
        }
    }
}
