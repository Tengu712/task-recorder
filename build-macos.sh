#!/bin/zsh

xcodebuild \
  -project TaskRecorder.xcodeproj \
  -scheme TaskRecorder_macOS \
  -derivedDataPath ./build/macOS \
  -configuration $1 \
  GENERATE_INFOPLIST_FILE=YES \
  build
