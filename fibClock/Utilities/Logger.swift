//
//  Logger.swift
//  fibClock
//
//  Created by Yecheng Wang on 2025-04-09.
//


import Foundation

// Logs the alarm event to a file AlarmLog.txt in the same directory as the source file
// so that I can run the app overnight and check the log file after the test it
// Probably not the smartest idea but it works for now

struct Logger {
    static func logAlarmEvent(fibonacciNumber: Int) {
        let currentDirectoryURL = URL(fileURLWithPath: #file).deletingLastPathComponent()
        let logFileURL = currentDirectoryURL.appendingPathComponent("AlarmLog.txt")
        print("Log file path: \(logFileURL.path)")

        let currentTime = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium)
        let logEntry = "Alarm triggered at \(currentTime), Fibonacci number: \(fibonacciNumber)\n"

        if FileManager.default.fileExists(atPath: logFileURL.path) {
            if let fileHandle = try? FileHandle(forWritingTo: logFileURL) {
                fileHandle.seekToEndOfFile()
                if let data = logEntry.data(using: .utf8) {
                    fileHandle.write(data)
                }
                fileHandle.closeFile()
            }
        } else {
            try? logEntry.write(to: logFileURL, atomically: true, encoding: .utf8)
        }
    }
}
