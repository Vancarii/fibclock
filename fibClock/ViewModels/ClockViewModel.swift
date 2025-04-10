//
//  ClockViewModel.swift
//  fibClock
//
//  Created by Yecheng Wang on 2025-04-09.
//

import SwiftUI
import Combine
import AVFoundation

class ClockViewModel: ObservableObject {
    @Published var selectedCity: City
    @Published var currentTime: Date = Date()
    @Published var isNight: Bool = false
    @Published var nextAlarmTime: Date
    @Published var timeUntilNextAlarm: String = ""
    @Published var showAlarmAlert = false
    @Published var animateIcon: Bool = true
    
    let cities: [City] = [
        City(name: "Vancouver", timeZoneIdentifier: "America/Vancouver"),
        City(name: "Singapore", timeZoneIdentifier: "Asia/Singapore"),
        City(name: "London", timeZoneIdentifier: "Europe/London"),
        City(name: "Seoul", timeZoneIdentifier: "Asia/Seoul"),
        City(name: "Christchurch", timeZoneIdentifier: "Pacific/Auckland"),
    ]
    
    private var cancellables = Set<AnyCancellable>()
    private let fibonacciManager = FibonacciAlarmManager()
    private var alarmStartTime: Date
    private var nextAlarmIndex: Int = 0
    private var clockTimer: AnyCancellable?
    private var audioPlayer: AVAudioPlayer?
    
    init() {
        // Default city is Vancouver
        self.selectedCity = cities[0]
        
        // Capture the app start time (t₀)
        self.alarmStartTime = Date()
        
        // Calculate the first alarm
        self.nextAlarmTime = alarmStartTime
    
        startClockUpdates()
        updateDayNightStatus()
        updateTimeUntilNextAlarm()
    }
    
    func toggleIconAnimation() {
        self.animateIcon = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 0.7)) {
                self.animateIcon = true
            }
        }
    }
    

    // Change the selected city
    func selectCity(_ city: City) {
        self.selectedCity = city
        self.currentTime = localizedCurrentTime(for: city.timeZoneIdentifier)
        updateDayNightStatus()
    }

    //
    private func localizedCurrentTime(for timeZoneID: String) -> Date {
        guard let timeZone = TimeZone(identifier: timeZoneID) else { return Date() }
        let systemOffset = TimeZone.current.secondsFromGMT(for: Date())
        let targetOffset = timeZone.secondsFromGMT(for: Date())
        let delta = TimeInterval(targetOffset - systemOffset)
        return Date().addingTimeInterval(delta)
    }
    
    private func startClockUpdates() {
        clockTimer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                // Update current time for the chosen time zone
                self.currentTime = self.localizedCurrentTime(for: self.selectedCity.timeZoneIdentifier)
                
                self.updateDayNightStatus()
                
                if Date() >= self.nextAlarmTime {
                    self.triggerAlarm()
                }

                self.updateTimeUntilNextAlarm()
            }
    }

    
    private func updateDayNightStatus() {
        guard let timeZone = TimeZone(identifier: selectedCity.timeZoneIdentifier) else { return }
        let components = Calendar.current.dateComponents(in: timeZone, from: currentTime)
        
        // default to day
        guard let hour = components.hour else {
            self.isNight = false
            return
        }
        
        // Night = 6 PM (18) to 6 AM (6).
        if hour >= 18 || hour < 6 {
            isNight = true
        } else {
            isNight = false
        }
    }

    private func triggerAlarm() {
        // Alarm occurred — schedule the next one
        nextAlarmIndex += 1
        
        // Set the next alarm time
        nextAlarmTime = Calendar.current.date(byAdding: .hour,
                                              value: fibonacciManager.hours(for: nextAlarmIndex),
                                              to: alarmStartTime) ?? Date()
        
        showAlarmAlert = true
    }
    
    
    private func updateTimeUntilNextAlarm() {
        let interval = nextAlarmTime.timeIntervalSince(Date())
        
        if interval <= 0 {
            timeUntilNextAlarm = "Time's up!"
        } else {
            let totalSeconds = Int(interval)
            let hours = totalSeconds / 3600
            let minutes = (totalSeconds % 3600) / 60
            let seconds = totalSeconds % 60
            timeUntilNextAlarm = String(format: "%02dh : %02dm : %02ds", hours, minutes, seconds)
        }
    }
}
