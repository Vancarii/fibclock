# Fibonacci Clock

A Swift iOS application that displays an analog clock with time zone selection, day/night indication, and a Fibonacci-based alarm system.

## Installation

### Requirements

- macOS 12.0 or later
- Xcode 14.0 or later
- iOS 15.0 or later (for deployment)
- Swift 5.7 or later

### Getting Started

#### Option 1: Clone the Repository

1. Open Terminal
2. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/fibonacci-clock.git
   cd fibonacci-clock
   ```

#### Option 2: Download as ZIP

1. Download the ZIP file from the repository
2. Extract the ZIP file to your preferred location

### Opening the Project

1. Launch Xcode
2. Select "Open a project or file"
3. Navigate to the project folder and select the `FibonacciClock.xcodeproj` file
4. Click "Open"

### Building and Running

1. In Xcode, select your target device from the scheme dropdown menu in the toolbar

1. You can use the iOS Simulator or a connected iOS device

1. Click the "Run" button (▶️) or press `Cmd + R` to build and run the application
1. The app should launch on your selected device or simulator

### Running on a Physical Device

To run the app on your physical iOS device:

1. Connect your iOS device to your Mac using a USB cable
2. In Xcode, select your device from the scheme dropdown menu
3. You may need to:

4. Trust your developer certificate on your device
5. Sign in with your Apple ID in Xcode's Accounts preferences
6. Select a development team in the project's signing settings

7. Click the "Run" button to build and install the app on your device

## Usage

Once installed, you can:

1. **City Selector**: Select different cities from the dropdown menu.
2. **Analog Clock**: View the current time in the selected city's timezone.
3. **Day/Night Indicator**: See whether it's day or night in the selected location.
   - A Sun icon is displayed during daytime (6 AM - 6 PM)
   - A Moon icon is displayed during nighttime (6 PM - 6 AM)
4. **A Fibonacci-Based Alarm System**:
   - Tracks alarms based on the Fibonacci sequence (1, 1, 2, 3, 5, 8, 13, etc.)
   - First alarm triggers after 1 hour from start time
   - Subsequent alarms follow the Fibonacci pattern
5. **Countdown**: View the time remaining until the next alarm

## File Structure:

The code is organized as below the folder structure
Here's an overview of the implementation:

UI components and interactions
Project Structure

The code is organized into the folder structure:

FibonacciClock/
├── Models/
│ ├── City.swift
│ └── FibonacciAlarm.swift
├── Views/
│ ├── ContentView.swift
│ ├── AnalogClockView.swift
│ ├── CityPickerView.swift
│ ├── DayNightIndicatorView.swift
│ └── AlarmView.swift
├── ViewModels/
│ └── ClockViewModel.swift
└── FibonacciClockApp.swift

## Implementation Details

- MVVM Architecture:
  Uses a ViewModel to separate UI logic from presentation
- SwiftUI:
  Built entirely with SwiftUI for modern iOS development
- Reactive Updates:
  Uses @Published properties for reactive UI updates
- Time Zone Handling:
  Properly handles time zone conversions for accurate display
- Animations:
  Includes subtle animations for alarm notifications
- SF Symbols:
  Uses Apple's SF Symbols for consistent iconography

## License

## Contact

Yecheng Wang - yechengofficial@gmail.com
ywa415@sfu.ca

www.yechengwang.ca

Project Link:

https://github.com/Vancarii

## Acknowledgments
