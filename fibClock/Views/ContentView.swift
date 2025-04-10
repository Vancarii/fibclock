//
//  ContentView.swift
//  fibClock
//
//  Created by Yecheng Wang on 2025-04-09.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ClockViewModel()
    @State private var animateIcon = true
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack(alignment: .center) {
                    Text("\(viewModel.selectedCity.name)")
                        .font(Font.custom("OPTIDanley-Medium", size: 32))
                        .fontWeight(.bold)
                    Spacer()
                    CityPickerView(viewModel: viewModel)
                }
                .padding(/*@START_MENU_TOKEN@*/.all, 35.0/*@END_MENU_TOKEN@*/)
                
                // Vstack so the icon is not spaced apart to the clock
                VStack {
                    // Display the Sun and Moon icon
                    // on either side of the clock
                    HStack {
                        if viewModel.isNight {
                            Spacer()
                        }
                        // Icon
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
                    }
                }
        .preferredColorScheme(viewModel.isNight ? .dark : .light)
        .animation(.easeInOut(duration: 0.3), value: viewModel.isNight)
        .onChange(of: viewModel.isNight) { oldVal, _ in
                    viewModel.toggleIconAnimation()
                }
    }
    
}

#Preview {
    ContentView()
}
