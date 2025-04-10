//
//  AlarmCountdownView.swift
//  fibClock
//
//  Created by Yecheng Wang on 2025-04-09.
//


import SwiftUI

// This view displays the countdown to the next alarm
// It takes a string parameter for the time until the next alarm
struct AlarmCountdownView: View {
    let timeUntilNextAlarm: String

    var body: some View {
        VStack {
            Label("Next Alarm", systemImage: "light.beacon.min.fill")
                .padding(.all)
                .padding(.horizontal, 30.0)
                .font(Font.custom("OPTIDanley-Medium", size: 32))

            Text(timeUntilNextAlarm)
                .font(Font.custom("OPTIDanley-Medium", size: 26))
                .padding(.all)
        }
        .background(Color("BackgroundColor").opacity(0.6))
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.5), radius: 5, x: 5, y: 5)
    }
}
