//
//  ContentView.swift
//  fibClock
//
//  Created by Yecheng Wang on 2025-04-09.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ClockViewModel()
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
            
            // Stacking all elements together
            VStack {
                
                // Header - Stacking the city name and the city picker
                HStack(alignment: .center) {
                    // City name
                    Text("\(viewModel.selectedCity.name)")
                        .font(Font.custom("OPTIDanley-Medium", size: 32))
                        .fontWeight(.bold)
                    Spacer()
                    CityPickerView(viewModel: viewModel)
                }
                .padding(/*@START_MENU_TOKEN@*/.vertical, 35.0/*@END_MENU_TOKEN@*/)
                .padding(.horizontal, 30.0)
                
                // Vstack groups the clock and the icon
                VStack {
                    // Display the Sun and Moon icon
                    // on either side of the clock by checking the isNight value
                    // and showing the Spacer() on the left and right accordingly
                    HStack {
                        if viewModel.isNight {
                            Spacer()
                        }
                        SunMoonIconView(isNight: viewModel.isNight, animateIcon: $viewModel.animateIcon)
                        if !viewModel.isNight {
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 50)
                    
                    // Analog Clock
                    AnalogClockView(currentTime: viewModel.currentTime, isNight: viewModel.isNight).frame(width: 200, height: 200)
                }
                
                // Current date
                CurrentDateView(currentTime: viewModel.currentTime).padding(.top, 40)
                    
                // Stacks the alarm countdown and text together in a card
                VStack{
                    // Display alarm countdown
                    Text("Next Alarm")
                        .padding(.all)
                        .padding(.horizontal, 30.0)
                        .font(Font.custom("OPTIDanley-Medium", size: 22))
                        .foregroundColor(.accentColor)
                    
                    Divider()
                        .padding(.horizontal, 20)
                        .frame(width: 250.0)
                        
                    
                    // Countdown timer
                    Text("\(viewModel.timeUntilNextAlarm)")
                        .font(Font.custom("OPTIDanley-Medium", size: 28))
                        .padding([.leading, .bottom, .trailing], 35.0)
                        .foregroundColor(.black)
                }
                .background(Color("ClockColor"))
                .cornerRadius(15)
                .padding(.top, 50.0)
                .shadow(color: .gray.opacity(0.5), radius: 5, x: 5, y: 5)
                
            }
        }
        .alert("Alarm", isPresented: $viewModel.showAlarmAlert) {
                    Button("Dismiss", role: .cancel) {
                        viewModel.dismissAlarm()
                    }
                }
        .preferredColorScheme(viewModel.isNight ? .dark : .light)
        // Animate the entire transition between light and dark mode
        .animation(.easeInOut(duration: 0.3), value: viewModel.isNight)
        // Listens to the changes in the isNight property to toggle the icon animation
        .onChange(of: viewModel.isNight) { oldVal, _ in
                    viewModel.toggleIconAnimation()
                }
    }
    
}

#Preview {
    ContentView()
}
