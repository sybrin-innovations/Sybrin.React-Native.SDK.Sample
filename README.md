# Sybrin.React-Native.SDK.Sample
A React-Native project demonstrating how to implement the Sybrin iOS &amp; Android SDK's into a React-Native project using native bridges.

## Prerequisites
The node_modules folder and ios/Pods folder have been omitted from the repo due to size constraints. Please run the following commands where relevant.

### For iOS and Android
Run in the project root directory.
  ```sh
  npm install
  ```

### For iOS additionally
Run in the <project_root>/ios/ directory.
  ```sh
  pod install
  ```

## Known iOS Issues
### Failed to build module from its module interface
This issue is caused by the ML Kit dependency not having module stability. To workaround this problem (permanent fix pending), you can simply delete the import MLKit statement from the .swiftinterface file.

Visual guide for implementing fix:
![Gif showing how to remove MLKit import from .swiftinterface file](images/iOS_Module_Stability.gif)

### Video Tutorial for iOS
https://youtu.be/agKQeIa4o1w
### Video Tutorial for Android
Coming soon!
