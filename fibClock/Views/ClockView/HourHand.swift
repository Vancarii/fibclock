//
//  HourHand.swift
//  fibClock
//
//  Created by Yecheng Wang on 2025-04-09.
//


import SwiftUI

struct HourHand: Shape {
    let currentTime: Date
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        // Hour + minute for partial movement
        let hour = Calendar.current.component(.hour, from: currentTime) % 12
        let minute = Calendar.current.component(.minute, from: currentTime)
        
        // Each hour is 30° + a fraction for the minutes
        let angle = Angle.degrees(Double(hour) * 30 + Double(minute) * 0.5)
        
        path.move(to: center)
        let handLength = min(rect.width, rect.height) / 2 * 0.6
        
        let x = center.x + handLength * CGFloat(sin(angle.radians))
        let y = center.y - handLength * CGFloat(cos(angle.radians))
        path.addLine(to: CGPoint(x: x, y: y))
        
        return path
    }
}