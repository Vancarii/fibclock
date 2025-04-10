//
//  HourHand.swift
//  fibClock
//
//  Created by Yecheng Wang on 2025-04-09.
//


import SwiftUI


// This struct represents the hour hand of the clock, which is a custom shape
// It uses the current time to calculate the angle of the hour hand
// The path method creates a line from the center of the clock to the calculated position of the hour hand
// The angle is calculated based on the current hour and minute
// The hour hand moves 30 degrees for each hour and an additional 0.5 degrees for each minute

struct HourHand: Shape {
    let currentTime: Date
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        let hour = Calendar.current.component(.hour, from: currentTime) % 12
        let minute = Calendar.current.component(.minute, from: currentTime)
        let angle = Angle.degrees(Double(hour) * 30 + Double(minute) * 0.5)
        
        path.move(to: center)
        let handLength = min(rect.width, rect.height) / 2 * 0.6
        
        let x = center.x + handLength * CGFloat(sin(angle.radians))
        let y = center.y - handLength * CGFloat(cos(angle.radians))
        path.addLine(to: CGPoint(x: x, y: y))
        
        return path
    }
}
