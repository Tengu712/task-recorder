# Task Recorder

## What is this?

This is an app to record tasks.
This is created to learn Swift.

## Build and Run

### macOS

1. Run `xcodegen` to create `TaskRecorder.xcodeproj`.
2. Run `build-macos.sh [Debug|Release]` to build the app.
3. Run `open build/macOS/Build/Products/[Debug|Release]/TaskRecorder.app` to open the built app.

### iOS

1. Run `xcodegen` to create `TaskRecorder.xcodeproj`.
2. Run `build-ios.sh [Debug|Release] <sdk> <team-id>` to build the app.
3. Run `xcrun simctl install <device> build/iOS/Build/Products/[Debug|Release]*/TaskRecorder.app` to open the built app.
4. Open the simulator which the built app is installed to.
