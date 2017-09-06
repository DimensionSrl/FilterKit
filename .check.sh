#!/bin/bash

# This will test on macOS
xcodebuild -project FilterKit.xcodeproj -scheme "FilterKit macOS" -enableCodeCoverage YES clean build test

# This will test on Linux
docker-compose up