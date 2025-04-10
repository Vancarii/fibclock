//
//  CurrentDateView.swift
//  fibClock
//
//  Created by Yecheng Wang on 2025-04-09.
//


import SwiftUI

// This view displays the current date in a specific format
// This is added on top of the app requirements so that the user
// can see if the selected city is ahead of behind

struct CurrentDateView: View {
    let currentTime: Date

    var body: some View {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none

        return Text(dateFormatter.string(from: currentTime))
            .font(Font.custom("OPTIDanley-Medium", size: 20))
            .padding(.top, 10)
    }
}
