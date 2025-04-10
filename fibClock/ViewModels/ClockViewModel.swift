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
    
    let cities = CityManager.cities
    
    private let fibonacciManager = FibonacciAlarmManager()
    private var alarmStartTime: Date
    private var nextAlarmIndex: Int = 0
    private var clockTimer: AnyCancellable?
    private var audioPlayer: AVAudioPlayer?
    
    init() {
        // Default city is Vancouver
        self.selectedCity = cities[0]
        self.alarmStartTime = Date()
        self.nextAlarmTime = alarmStartTime
    
        startClockUpdates()
        updateDayNightStatus()
        updateTimeUntilNextAlarm()
    }
    
    // Toggles the animation for the icon
    // when the city changes and is in a different timezone
    func toggleIconAnimation() {
        self.animateIcon = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 0.7)) {
                self.animateIcon = true
            }
        }
    }
    

    // Change the selected city and
    // update the current time and day/night status
    func selectCity(_ city: City) {
        self.selectedCity = city
        self.currentTime = localizedCurrentTime(for: city.timeZoneIdentifier)
        updateDayNightStatus()
    }

    // Get the current time in the selected city's timezone
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

    // Updates the day and night status based on the current time
    // based on the hour, it toggles the isNight property
    private func updateDayNightStatus() {
        guard let timeZone = TimeZone(identifier: selectedCity.timeZoneIdentifier) else { return }
        let components = Calendar.current.dateComponents(in: timeZone, from: currentTime)
        
        // default to day
        guard let hour = components.hour else {
            self.isNight = false
            return
        }
        
        // Night = 6 PM (18) to 6 AM (6) inclusive
        if hour >= 18 || hour <= 6 {
            isNight = true
        } else {
            isNight = false
        }
    }
    
    // This is called when the alarm timer reaches 0
    // It shows the alert dialog and plays the alarm sound
    // sets the next alarm time based on the Fibonacci sequence
    // Optional: calles the Logger to log the events/alarms
    private func triggerAlarm() {
        let fibonacciNumber = fibonacciManager.hours(for: nextAlarmIndex)
        nextAlarmIndex += 1
        
        // Set the next alarm time
        nextAlarmTime = Calendar.current.date(byAdding: .hour,
                                              value: fibonacciNumber,
                                              to: alarmStartTime) ?? Date()
        
        showAlarmAlert = true
        playAlarmSound()
        
        // ENABLE THIS FOR TESTING
        // Logger.logAlarmEvent(fibonacciNumber: fibonacciNumber)
    }
    
    
    // THis is called by the triggerAlarm function and uses AVAudioPlayer to play the contents
    // of the iphone_alarm.mp3 file
    private func playAlarmSound() {
            guard let url = Bundle.main.url(forResource: "iphone_alarm", withExtension: "mp3") else {
                print("Alarm sound file not found.")
                return
            }
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.play()
            } catch {
                print("Failed to play alarm sound: \(error)")
            }
        }
    
    // This is called when the alarm alert dialog is dismissed
    // It stops the audio player and hides the alert
    func dismissAlarm() {
        audioPlayer?.stop()
        showAlarmAlert = false
    }
    
    
    // This function calculates the time remaining until the next alarm
    // and is used in AlarmCountdownView.swift to display the countdown
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
