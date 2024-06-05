
# SerenityJournal

SerenityJournal is a SwiftUI-based iOS application focused on journaling and mindfulness. This app integrates with Firebase for authentication, analytics, and Firestore for data storage.

## Table of Contents
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Firebase Configuration](#firebase-configuration)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)

## Features
- User Authentication with Firebase
- Firestore for data storage
- Firebase Analytics
- Simple and intuitive user interface
- Signup and Login functionality

## Requirements
- Xcode 12.0 or later
- iOS 14.0 or later
- CocoaPods or Swift Package Manager

## Installation

### 1. Clone the Repository
```sh
git clone https://github.com/yourusername/SerenityJournal.git
cd SerenityJournal
```

### 2. Open the Project in Xcode
Open `SerenityJournal.xcodeproj` in Xcode.

### 3. Install Dependencies
SerenityJournal uses Firebase, which can be installed via Swift Package Manager.

#### Using Swift Package Manager
1. In Xcode, go to `File > Add Packages`.
2. Enter the Firebase iOS SDK URL: `https://github.com/firebase/firebase-ios-sdk.git`.
3. Select the required Firebase modules:
   - FirebaseAuth
   - FirebaseFirestore
   - FirebaseAnalytics
4. Add them to your project.

### 4. Firebase Configuration
1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Create a new project (or use an existing one).
3. Add an iOS app to your project and follow the instructions to download the `GoogleService-Info.plist` file.
4. Drag and drop the `GoogleService-Info.plist` file into the root of your Xcode project.

## Usage

### Running the App
1. Open the project in Xcode.
2. Select a simulator or a connected device.
3. Build and run the project (`Cmd + R`).

### Firebase Analytics
To enable debug logging for Firebase Analytics, add the `-FIRDebugEnabled` argument to your launch arguments:
1. Go to `Product > Scheme > Edit Scheme`.
2. Select the `Run` action.
3. Under `Arguments Passed On Launch`, add `-FIRDebugEnabled`.

## Project Structure
```
SerenityJournal/
├── SerenityJournalApp.swift   # Main application entry point
├── ContentView.swift          # Main content view
├── LoginView.swift            # Login screen
├── SignupView.swift           # Signup screen
├── Assets.xcassets/           # Image and asset catalog
└── GoogleService-Info.plist   # Firebase configuration file
```

## Contributing
Contributions are welcome! Please fork this repository and submit a pull request for any improvements or bug fixes.

## License
This project is licensed under the MIT License. See the LICENSE file for details.
