////
////  AnalogClockView.swift
////  fibClock
////
////  Created by Yecheng Wang on 2025-04-09.
////
//
//import SwiftUI
//
//struct AnalogClockView: View {
//    let currentTime: Date
//    
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack {
//                // Clock face
//                Circle()
//                    .strokeBorder(lineWidth: 2)
//                
//                // Hour ticks
//                ForEach(0..<12) { tick in
//                    Rectangle()
//                        .frame(width: 2, height: 10)
//                        .offset(y: -geometry.size.width / 2 + 5)
//                        .rotationEffect(Angle.degrees(Double(tick) / 12.0 * 360))
//                }
//                
//                // Hour hand
//                HourHand(currentTime: currentTime)
//                    .stroke(lineWidth: 4)
//                    .foregroundColor(.primary)
//                    .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.5)
//                
//                // Minute hand
//                MinuteHand(currentTime: currentTime)
//                    .stroke(lineWidth: 2)
//                    .foregroundColor(.primary)
//                    .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.7)
//                
//                // Second hand
//                SecondHand(currentTime: currentTime)
//                    .stroke(lineWidth: 1)
//                    .foregroundColor(.red)
//                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.8)
//            }
//            .frame(width: geometry.size.width, height: geometry.size.height)
//        }
//    }
//}

import SwiftUI

struct AnalogClockView: View {
    let currentTime: Date
    let isNight: Bool  // Pass this in so we can style the clock face accordingly
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                // MARK: - Clock Background (Neumorphic Ring)
                Circle()
                    // Choose a background fill color
                    .fill(Color("ClockColor"))
                    // Add subtle shadow for a raised/sunken effect
                    .shadow(color: .black.opacity(0.2),
                            radius: 5, x: 5, y: 8)
//                    .shadow(color: isNight
//                                ? .gray.opacity(0.2)
//                                : .gray.opacity(0.2),
//                            radius: 5, x: 3, y: 3)
//                    .overlay(
//                        // A thin ring stroke for a visible outline
//                        Circle()
//                            .stroke(Color.gray.opacity(0.3), lineWidth: 2)
//                    )
                
                
                // MARK: - Ticks
                ForEach([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], id: \.self) { tick in
                    Rectangle()
                        .fill(Color.accentColor)
                        .frame(width: 1, height: geometry.size.width * 0.03)
                        // Move the tick to the top edge
                        .offset(y: -geometry.size.width / 2.2)
                        .rotationEffect(Angle.degrees(Double(tick) * 30))
                }
                
                // MARK: - Hour Hand
                HourHand(currentTime: currentTime)
                    // Make the hour hand thicker
                    .stroke(lineWidth: 5)
                    .foregroundColor(isNight ? Color(red: 0.8, green: 0.8, blue: 0.85)
                                             : Color(red: 0.2, green: 0.2, blue: 0.25))
                    .frame(width: geometry.size.width * 0.5,
                           height: geometry.size.height * 0.5)
                
                // MARK: - Minute Hand
                MinuteHand(currentTime: currentTime)
                    .stroke(lineWidth: 3)
                    .foregroundColor(isNight ? Color(red: 0.85, green: 0.85, blue: 0.9)
                                             : Color(red: 0.3, green: 0.3, blue: 0.35))
                    .frame(width: geometry.size.width * 0.7,
                           height: geometry.size.height * 0.7)
                
                // MARK: - Second Hand
                SecondHand(currentTime: currentTime)
                    .stroke(lineWidth: 2)
                    .foregroundColor(Color.accentColor)
                    .frame(width: geometry.size.width * 0.8,
                           height: geometry.size.height * 0.8)
                
                // MARK: - Center Circle (pivot)
                Circle()
                    .fill(isNight ? Color.accentColor : Color.accentColor.opacity(0.8))
                    .frame(width: 10, height: 10)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
