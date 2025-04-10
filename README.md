# fibClock 🕐

#### By Yecheng Wang


View this README on GitHub for the video demo and screenshots: [GitHub Repository](https://github.com/Vancarii/fibclock)


Video Demo:

https://github.com/user-attachments/assets/c215899b-fa5a-46ff-80c4-431731258e4c


## Overview
`fibClock` is a Swift-based iOS application that displays an analog clock with Fibonacci-based alarm scheduling. The app uses the **Model-View-ViewModel (MVVM)** design pattern to ensure a clean separation of concerns, maintainability, and testability. The app also includes features such as day/night mode, city selection for time zones, and alarm countdowns.

## Contents
- [Features](#features)
- [Design Pattern: MVVM](#design-pattern-mvvm)
- [Assumptions](#assumptions)
- [Project Structure](#project-structure)
- [Key Components](#key-components)
- [Use of AI](#use-of-ai)
- [Getting Started](#getting-started)
   - [Downloading the Project](#download-the-project)
   - [Running the Project](#running-the-project)
   - [Testing the App](#testing-the-app)

---

## Features
- **Analog Clock**: Displays the current time with hour, minute, and second hands.
- **Fibonacci Alarm Scheduling**: Alarms are scheduled based on Fibonacci numbers (e.g., 1, 1, 2, 3, 5, etc.).
- **Day/Night Mode**: Automatically adjusts the UI appearance based on the time of day.
- **City Selection**: Allows users to select a city and view the local time.
- **Customizable UI**: Includes animations and a visually appealing design.

---

## Design Pattern: MVVM
The project follows the **MVVM (Model-View-ViewModel)** design pattern:
- **Model**: Represents the data and business logic (`City`, `Alarm`, `FibonacciAlarmManager`).
- **ViewModel**: Acts as a bridge between the model and the view, handling state and logic (`ClockViewModel`).
- **View**: Displays the UI and binds to the `ViewModel` (`ContentView`, `AnalogClockView`, `CityPickerView`, `CurrentDateView`, `SunMoonIconView`).

### Why MVVM?
- Using SwiftUI, the most common design pattern is MVVM given the structure of the framework. MVVM also keeps the frontend UI logic separate from the business logic.
- The `ViewModel` can also be tested independently of the UI, such as using the `Logger.swift` file to log each alarm date and time

---

## Assumptions
1. It is assumed that the fibonacci function is infinite as long as the app is running, meaning it will continue to produce the next fibonacci number. Given this, i chose to use memoization to store only the previous 2 fibonacci numbers to optimize time and space complexity.
2. Given a minimum of 2 cities in different time zones, it is assumed that it is not needed to implement adding new cities to the list
3. The alarm plays an mp3 alarm sound and shows an alert, similar to the alarm on mobile devices
4. A date is included to be more specific if the current city selected is ahead or behind
5. The guidelines specify that any framework can be chosen, so it is assumed that the tester will be able to run xcode and iOS applications. A video demo and screenshots are provided in the case that my assumption is wrong.

---

## Project Structure
```
fibClock/
├── Models/
│   ├── City.swift
│   ├── Alarm.swift
│   ├── FibonacciAlarmManager.swift
├── ViewModels/
│   ├── ClockViewModel.swift
├── Views/
│   ├── ClockView/
│   │   ├── AnalogClockView.swift
│   │   ├── HourHand.swift
│   │   ├── MinuteHand.swift
│   │   ├── SecondHand.swift
│   ├── AlarmCountdownView.swift
│   ├── ContentView.swift
│   ├── SunMoonIconView.swift
│   ├── CityPickerView.swift
│   ├── CurrentDateView.swift
├── Resources/
│   ├── iphone_alarm.mp3
│   ├── OPTIDanley-Medium.otf
├── Utilities/
│   ├── Logger.swift
│   ├── AlarmLog.txt
├── fibClockApp.swift
```

### Key Components

1. **Models**:
   - `City`: Represents a city with a name, id, and time zone. Includes a struct for the list of selectable Cities
   - `Alarm`: Represents an alarm with a scheduled time
   - `FibonacciAlarmManager`: Calculates Fibonacci numbers using memoization for alarm scheduling and returns the next value

2. **ViewModel**:
   - `ClockViewModel`: Manages the app's state, including the current time, selected city, alarm scheduling, day/night mode, and animations.

3. **Views**:
   - `ContentView`: The main view that displays the clock, the icon, city picker, and alarm countdown.
   - `AnalogClockView`: Displays the analog clock with hour, minute, and second hands.
   - `SunMoonIconView`: Displays a sun or moon icon based on the time of day.
   - `CityPickerView`: A dropdown menu that iterates the list of cities and allows users to select a city.
   - `CurrentDateView`: Displays the current date.

4. **Resources**:
   - `iphone_alarm.mp3`: The alarm sound file.
   - `OPTIDanley-Medium.otf`: The font file.
   - `Logger.swift`: A tester function that logs each alarm that goes off in a txt file.
   - `AlarmLog.txt`: A log file for alarm events.

---

## Use of AI

Places where I used generative AI to help with the project:

- `Logger.swift` - I was unable to find where the generated log file was, and I used CoPilot to help refactor the function to create the new `AlarmLog.txt` file inside the same directory
- `ClockView` - Some of the animation logic with the movement of the analog clock hands was difficult to implement. Initially, I was going to use images and piece them together, but I decided to implement the full analog clock in code, although using a bit of AI. Specifically, I used AI to help me understand how to rotate the `SecondHand.swift`, `HourHand.swift`, and `MinuteHand.swift`.

---

## Getting Started

### Download the Project

1. **Prerequisites**:
   - macOS with Xcode installed.
   - Swift 5.0 or later.
   - iOS Simulator or iOS physical device with iOS version 17.0 or later

2. **Download Files**:
   - **Option 1**: Clone the repository:
     ```bash
     git clone https://github.com/Vancarii/fibclock
     cd fibClock
     ```
   - **Option 2**: Download as ZIP
      - Download the ZIP file from the repository
      - Extract the ZIP file to your preferred location

     
### Running the Project

1. In Xcode, select your target device from the scheme dropdown menu in the toolbar
2. You can use an iOS Simulator or a connected iOS device 
3. Click the "Run" button (▶️) or press `Cmd + R` to build and run the application
   
The app will launch on your selected device or simulator

**Note:** To connect a physical iOS device to your laptop through a cable, you may need to:
1. Trust your developer certificate on your device
2. Sign in with your Apple ID in Xcode's Accounts preferences
3. Select a development team in the project's signing settings
         
---

## Testing the App

1. **Initial Alarm** - Once the app starts, the initial alarm will be triggered, playing the audio and showing an alert. Click `Dismiss` to close the alert

<p align="center">
   <img width="200" alt="Screenshot 2025-04-10 at 12 06 42 AM" src="https://github.com/user-attachments/assets/3f066d85-a1d2-4466-ad0d-4dce29803a64" />
</p>

2. **Change City** - Click on `Change City` button in the top right-hand corner and select any of the cities from the dropdown table

<p align="center">
   <img width="200" alt="Screenshot 2025-04-10 at 12 12 45 AM" src="https://github.com/user-attachments/assets/eec2c497-2ad5-40e2-bd56-1e73ce29aa96" />
</p>

3. Selecting a city that is currently between `6pm` and `6am` will be displayed in dark mode, while other cities will be displayed in light mode. A visual sun/moon icon differentiates the time zones.

<p align="center">
   <img width="200" alt="Screenshot 2025-04-09 at 9 40 03 PM" src="https://github.com/user-attachments/assets/294c8f06-cd90-4efb-a753-f8774df5f092" />
   <img width="200" alt="Screenshot 2025-04-09 at 9 42 25 PM" src="https://github.com/user-attachments/assets/ae9a1774-9cd8-4ce8-bd44-9cd5708c992b" />
</p>


### Testing the Alarm

- To test the alarm, the `Logger.swift` file was written to write to a file, everytime the alarm would be triggered, printing the time and date with the corresponding fibonacci number. This function would be called twice on app startup, but it was not an issue with the functionality of the application. I did not have time to fix this or run it for long enough, and the code that calls the Logger is commented out in `triggerAlarm()` in the `ClockViewModel.swift` file. This was an attempt to test the fibonacci alarm works properly with the actual time.


