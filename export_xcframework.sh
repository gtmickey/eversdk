#!/bin/bash

xcodebuild -create-xcframework \
-framework ./build/ios/Release-iphoneos/rust_lib_eversdk/rust_lib_eversdk.framework \
-framework ./build/ios/Debug-iphonesimulator/rust_lib_eversdk/rust_lib_eversdk.framework \
-output ./rust_lib_eversdk.xcframework

