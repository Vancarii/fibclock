//
//  AnalogClockView.swift
//  fibClock
//
//  Created by Yecheng Wang on 2025-04-09.
//

import SwiftUI

// This view displays an analog clock with hour, minute, and second hands
// It uses a GeometryReader to adjust the size and position of the clock hands
// The clock hands are drawn using custom shapes for hour, minute, and second hands

struct AnalogClockView: View {
    let currentTime: Date
    let isNight: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                // Background Circle
                Circle()
                    .fill(Color("ClockColor"))
                    .shadow(color: .black.opacity(0.2),
                            radius: 5, x: 5, y: 8)
                
                // Ticks
                ForEach([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], id: \.self) { tick in
                    Rectangle()
                        .fill(Color.accentColor)
                        .frame(width: 1, height: geometry.size.width * 0.03)
                        // Move the tick to the top edge
                        .offset(y: -geometry.size.width / 2.2)
                        .rotationEffect(Angle.degrees(Double(tick) * 30))
                }
                
                // Hour Hand
                HourHand(currentTime: currentTime)
                    // Make the hour hand thicker
                    .stroke(lineWidth: 5)
                    .foregroundColor(isNight ? Color(red: 0.8, green: 0.8, blue: 0.85)
                                             : Color(red: 0.2, green: 0.2, blue: 0.25))
                    .frame(width: geometry.size.width * 0.5,
                           height: geometry.size.height * 0.5)
                
                // Minute Hand
                MinuteHand(currentTime: currentTime)
                    .stroke(lineWidth: 3)
                    .foregroundColor(isNight ? Color(red: 0.85, green: 0.85, blue: 0.9)
                                             : Color(red: 0.3, green: 0.3, blue: 0.35))
                    .frame(width: geometry.size.width * 0.7,
                           height: geometry.size.height * 0.7)
                
                // Second Hand
                SecondHand(currentTime: currentTime)
                    .stroke(lineWidth: 2)
                    .foregroundColor(Color.accentColor)
                    .frame(width: geometry.size.width * 0.8,
                           height: geometry.size.height * 0.8)
                
                // Center Circle
                Circle()
                    .fill(isNight ? Color.accentColor : Color.accentColor.opacity(0.8))
                    .frame(width: 10, height: 10)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
