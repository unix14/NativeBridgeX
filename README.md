# NativeBridgeX

NativeBridgeX is a Dart library designed to simplify the process of executing native code directly from Flutter. This project serves as an example for a Flutter application that requires interactes with native code. ( Android and iOS )

## Features

- Execute native code directly from the Flutter code
- Demo code includes examples of:
  - Send push notifications
  - Set and get integer values
  - Login and logout test buttons
  - Open URLs in the native browser
  - Clear all notifications

## Project Structure

The project is structured into two main directories:

- `android`: Contains the Android native code written in Kotlin.
- `ios`: Contains the iOS native code written in Swift.

## Basic Usage
  
To build and run the project, you need to have Flutter and Dart installed on your machine. Once you have these prerequisites, you can clone the repository and run the following command in the root directory:

```bash
flutter run
```

To use the NativeBridgeX library, you need to call the appropriate methods from your Dart code. Here's an example of how you can send a push notification:

```dart
import 'package:native_bridge/native_bridge.dart';

void main() {
  NativeBridgeX.build(NativeBridgeType.MAIN_ACTIVITY).invokeMethod(NativeMethodType.sendNotification(id: '1', title: 'Hello', text: 'This is a test notification'));
}
```

# Custom Usage

In order to create a custom and new native method to be executed from native and called from Flutter we first need to do the following:

First, we need to add CUSTOM to the NativeBridgeType enum in native_bridge_type.dart:
```dart
enum NativeBridgeType { GENERAL, MAIN_ACTIVITY, CUSTOM, NEW_CUSTOM_CHANNEL }
```

Next, we create a new method type CustomMethod in native_method_type.dart:

```dart
class CustomMethod extends NativeMethodType {
  final String customData;

  CustomMethod({required this.customData});

  @override
  String get methodName => 'customMethod';

  @override
  Map<String, dynamic> get arguments => {'customData': customData};
}
```
Now, we can use this new method type in our Dart code:

```dart
NativeBridgeX.build(NativeBridgeType.NEW_CUSTOM_CHANNEL).invokeMethod(CustomMethod(customData: 'Hello, World!'));
```
On the native side, we need to handle this new method call. Here's how you can do it in Kotlin:
```dart
mChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL);
mChannel.setMethodCallHandler { call, result ->
    // Note: this method is invoked on the main thread.
    if (call.method == "customMethod") {
        val customData: String = call.argument<String>("customData") ?: "-1";
        notify("customMethod: $customData")

        if (customData != "-1") {
            result.success(1)
        } else {
            result.error("MainActivity", "Error in customMethod.", null)
        }
    } else {
        result.notImplemented()
    }
};
```
This code will listen for the customMethod call and print the customData argument. If the customData argument is not -1, it will return a success result. Otherwise, it will return an error.

# Getting Started
If this is your first Flutter project, here are a few resources to get you started:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Contributing
Contributions are welcome! If you find a bug or want to contribute to the code or documentation, you can fork the repository and create a pull request. If you have any questions or suggestions, feel free to open an issue.

---

### Contact
For issues or contributions, feel free to reach out or create a pull request on GitHub.

**GitHub**: [unix14](https://github.com/unix14)

