#!/bin/zsh

xcodebuild \
  -quiet \
  -project TaskRecorder.xcodeproj \
  -scheme TaskRecorder_iOS \
  -sdk $2 \
  -derivedDataPath ./build/iOS \
  -configuration $1 \
  GENERATE_INFOPLIST_FILE=YES \
  DEVELOPMENT_TEAM=$3 \
  build
