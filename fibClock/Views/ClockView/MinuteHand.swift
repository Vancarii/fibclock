//
//  MinuteHand.swift
//  fibClock
//
//  Created by Yecheng Wang on 2025-04-09.
//


import SwiftUI

// This struct defines the minute hand of the clock
// It uses a path to draw the hand based on the current time
// same as the hour hand, but the angle is calculated differently

struct MinuteHand: Shape {
    let currentTime: Date
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        let minute = Calendar.current.component(.minute, from: currentTime)
        let angle = Angle.degrees(Double(minute) * 6)
        
        path.move(to: center)
        let handLength = min(rect.width, rect.height) / 2 * 0.8
        
        let x = center.x + handLength * CGFloat(sin(angle.radians))
        let y = center.y - handLength * CGFloat(cos(angle.radians))
        path.addLine(to: CGPoint(x: x, y: y))
        
        return path
    }
}
