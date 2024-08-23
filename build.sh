#!/bin/zsh

# A shellscript for building the application for iOS.
#
# 1. run `xcodegen` to create TaskRecorder.xcodeproj.
# 2. run `./build.sh [Release|Debug] <sdk> <team-id>` to build.

xcodebuild \
  -project TaskRecorder.xcodeproj \
  -scheme TaskRecorder \
  -sdk $2 \
  -derivedDataPath ./build \
  -configuration $1 \
  GENERATE_INFOPLIST_FILE=YES \
  DEVELOPMENT_TEAM=$3 \
  build
