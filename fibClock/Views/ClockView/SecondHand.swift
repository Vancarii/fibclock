//
//  SecondHand.swift
//  fibClock
//
//  Created by Yecheng Wang on 2025-04-09.
//


import SwiftUI

struct SecondHand: Shape {
    let currentTime: Date
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        let second = Calendar.current.component(.second, from: currentTime)
        
        // Each second is 6 degree
        let angle = Angle.degrees(Double(second) * 6)
        
        path.move(to: center)
        let handLength = min(rect.width, rect.height) / 2 * 0.9
        
        let x = center.x + handLength * CGFloat(sin(angle.radians))
        let y = center.y - handLength * CGFloat(cos(angle.radians))
        path.addLine(to: CGPoint(x: x, y: y))
        
        return path
    }
}
