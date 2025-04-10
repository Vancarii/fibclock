//
//  SunMoonIconView.swift
//  fibClock
//
//  Created by Yecheng Wang on 2025-04-09.
//


import SwiftUI

// This view displays a sun or moon icon based on the time of day

struct SunMoonIconView: View {
    let isNight: Bool
    @Binding var animateIcon: Bool

    var body: some View {
        Image(systemName: isNight ? "moon.fill" : "sun.max.fill")
            .foregroundColor(.yellow)
            .shadow(color: isNight ? .white : .yellow.opacity(0.6), radius: 10, x: 1, y: 1)
            .offset(y: animateIcon ? 0 : 50)
            .opacity(animateIcon ? 1 : 0)
            .font(.largeTitle)
    }
}
