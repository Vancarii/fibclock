//
//  FibonacciAlarmManager.swift
//  fibClock
//
//  Created by Yecheng Wang on 2025-04-09.
//

import Foundation

struct FibonacciAlarmManager {
    
    func hours(for index: Int) -> Int {
            guard index >= 0 else { return 1 }
            
            var a = 0
            var b = 1
            
            for _ in 0..<index {
                let temp = a + b
                a = b
                b = temp
            }
            
            return b
        }
}
        
