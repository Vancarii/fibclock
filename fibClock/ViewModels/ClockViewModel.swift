//
//  ClockViewModel.swift
//  fibClock
//
//  Created by Yecheng Wang on 2025-04-09.
//

import SwiftUI
import Combine

class ClockViewModel: ObservableObject {
    @Published var selectedCity: City
    @Published var currentTime: Date = Date()
    @Published var isNight: Bool = false
    @Published var nextAlarmTime: Date
    @Published var timeUntilNextAlarm: String = ""
    
    let cities: [City] = [
        City(name: "Vancouver", timeZoneIdentifier: "America/Vancouver"),
        City(name: "Singapore", timeZoneIdentifier: "Asia/Singapore"),
        City(name: "London", timeZoneIdentifier: "Europe/London"),
        City(name: "Tokyo", timeZoneIdentifier: "Asia/Tokyo"),
        City(name: "Christchurch", timeZoneIdentifier: "Pacific/Auckland"),
    ]
    
    private var cancellables = Set<AnyCancellable>()
    private let fibonacciManager = FibonacciAlarmManager()
    private var alarmStartTime: Date
    private var nextAlarmIndex: Int = 0
    private var clockTimer: AnyCancellable?
    
    init() {
        // Default city is Vancouver
        self.selectedCity = cities[0]
        
        // Capture the app start time (t₀)
        self.alarmStartTime = Date()
        
        // Calculate the first alarm (Fibonacci hour = 1 for index 0)
        self.nextAlarmTime = Calendar.current.date(byAdding: .hour,
                                                   value: fibonacciManager.hours(for: nextAlarmIndex),
                                                   to: alarmStartTime) ?? Date()
        
        // Start the clock updates
        startClockUpdates()
        
        // Update initial state
        updateDayNightStatus()
        updateTimeUntilNextAlarm()
    }
    
    // MARK: - City Selection
    
    func selectCity(_ city: City) {
        self.selectedCity = city
        // Force an immediate time update to reflect the new time zone
        self.currentTime = localizedCurrentTime(for: city.timeZoneIdentifier)
        // Also recalculate night status for the newly selected city
        updateDayNightStatus()
    }
    
    // MARK: - Time
    
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
                
                // Update day/night status
                self.updateDayNightStatus()
                
                // Check if an alarm has occurred
                if Date() >= self.nextAlarmTime {
                    self.triggerAlarm()
                }
                
                // Update the UI display for next alarm
                self.updateTimeUntilNextAlarm()
            }
    }
    
    // MARK: - Day/Night
    
    private func updateDayNightStatus() {
        guard let timeZone = TimeZone(identifier: selectedCity.timeZoneIdentifier) else { return }
        let components = Calendar.current.dateComponents(in: timeZone, from: currentTime)
        
        // If we can't get the hour, default to day
        guard let hour = components.hour else {
            self.isNight = false
            return
        }
        
        // Night = 6 PM (18) to 6 AM (6). We'll include 6 PM to 11:59 PM and 0 to 6 AM
        if hour >= 18 || hour < 6 {
            isNight = true
        } else {
            isNight = false
        }
    }
    
    // MARK: - Alarms
    
    private func triggerAlarm() {
        // Alarm occurred — schedule the next one
        nextAlarmIndex += 1
        
        // Set the next alarm time
        nextAlarmTime = Calendar.current.date(byAdding: .hour,
                                              value: fibonacciManager.hours(for: nextAlarmIndex),
                                              to: alarmStartTime) ?? Date()
        
        // Here you might show a local notification or an alert
        print("Alarm triggered! Next alarm at \(nextAlarmTime)")
    }
    
    private func updateTimeUntilNextAlarm() {
        let interval = nextAlarmTime.timeIntervalSince(Date())
        
        if interval <= 0 {
            timeUntilNextAlarm = "Alarm due now!"
        } else {
            let totalSeconds = Int(interval)
            let hours = totalSeconds / 3600
            let minutes = (totalSeconds % 3600) / 60
            let seconds = totalSeconds % 60
            timeUntilNextAlarm = String(format: "%02dh : %02dm : %02ds", hours, minutes, seconds)
        }
    }
}
