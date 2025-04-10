//
//  CityPickerView.swift
//  fibClock
//
//  Created by Yecheng Wang on 2025-04-09.
//


import SwiftUI

struct CityPickerView: View {
    @ObservedObject var viewModel: ClockViewModel

    var body: some View {
        Menu {
            ForEach(viewModel.cities) { city in
                Button(action: {
                    viewModel.selectCity(city)
                }) {
                    Text(city.name)
                }
            }
        } label: {
            Label("Change City", systemImage: "location")
                .font(Font.custom("OPTIDanley-Medium", size: 16))
                .fontWeight(.bold)
                .padding(8.0)
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                .shadow(color: viewModel.isNight ? .white : .gray.opacity(0.4), radius: 5, x: 5, y: 5)
        }
    }
}
