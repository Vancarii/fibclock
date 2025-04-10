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
                    
                    cityPicker().fontWeight(.bold).font(.footnote)
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
                        sunMoonIcon
                            .font(.largeTitle)
                        if !viewModel.isNight {
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 50)
                            
                    // Analog Clock
                    AnalogClockView(currentTime: viewModel.currentTime, isNight: viewModel.isNight).frame(width: 200, height: 200)
                }
                
                // Current date
                currentDateText.padding(.top, 40.0)
                    
                
                VStack{
                    // Display alarm countdown
                    Label("Next Alarm", systemImage: "light.beacon.min.fill")
                        .padding(.all)
                        .padding(.horizontal, 30.0)
                        .font(Font.custom("OPTIDanley-Medium", size: 32))
                        
                        
                    Text("\(viewModel.timeUntilNextAlarm)")
                        .font(Font.custom("OPTIDanley-Medium", size: 26))
                        .padding(.all)
                }
                .background(Color("BackgroundColor").opacity(0.6))
                .cornerRadius(15)
                .padding(.top, 50.0)
                .shadow(color: .gray.opacity(0.5), radius: 5, x: 5, y: 5)
                
            }
        }
        .preferredColorScheme(viewModel.isNight ? .dark : .light)
    }
    
        
    private func cityPicker() -> some View {
        Menu {
            ForEach(viewModel.cities) { city in
                Button(action: {
                    viewModel.selectCity(city)
                }) {
                    Text(city.name)
                }
            }
        } label: {
            Label("Select City", systemImage: "location")
                .font(Font.custom("OPTIDanley-Medium", size: 16))
                .fontWeight(.bold)
                .padding(8.0)
                .background(Color.white.opacity(0.8)).cornerRadius(10)
                .shadow(color: viewModel.isNight ? .white : .gray.opacity(0.4), radius: 5, x: 5, y: 5)
        }
    }
    
    private var currentDateText: some View {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        return Text(dateFormatter.string(from: viewModel.currentTime))
            .font(Font.custom("OPTIDanley-Medium", size: 20))
            .padding(.top, 10)
    }
       
   private var sunMoonIcon: some View {
       Image(systemName: viewModel.isNight ? "moon.fill" : "sun.max.fill")
           .foregroundColor(viewModel.isNight ? .white : .yellow)
           .shadow(color: viewModel.isNight ? .white : .yellow.opacity(0.6), radius: 10, x: 1, y: 1)
           .offset(y: animateIcon ? 0 : 50)
           .opacity(animateIcon ? 1 : 0)
           .onChange(of: viewModel.isNight) { oldValue, newValue in
               
               animateIcon = false
               
               withAnimation(.easeInOut(duration: 0.7)) {
                   animateIcon = true
               }
           }
   }
}

#Preview {
    ContentView()
}
