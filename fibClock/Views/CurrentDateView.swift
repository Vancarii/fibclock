//
//  CurrentDateView.swift
//  fibClock
//
//  Created by Yecheng Wang on 2025-04-09.
//


import SwiftUI

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