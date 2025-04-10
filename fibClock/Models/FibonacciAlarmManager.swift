//
//  FibonacciAlarmManager.swift
//  fibClock
//
//  Created by Yecheng Wang on 2025-04-09.
//

import Foundation

// Refactered this to use DP instead of looping to index everytime

struct FibonacciAlarmManager {
    private var memo: [Int: Int] = [0: 0, 1: 1]

    mutating func hours(for index: Int) -> Int {
        guard index >= 0 else { return 1 }

        if let result = memo[index] {
            return result
        }

        let result = hours(for: index - 1) + hours(for: index - 2)
        memo[index] = result
        return result
    }
}
