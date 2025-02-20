import 'package:flutter/services.dart';

/// A class that handles the communication between the Flutter app and the native platform.
class NativeBridgeHandler {

  MethodChannel? _channel;
  NativeBridgeHandler(String channelName) : _channel = MethodChannel(channelName);

  Future<int> callNativeMethod(String methodName, Map<String, dynamic> arguments) async {
    try {
      final int result = await _channel?.invokeMethod(methodName, arguments);
      return result;
    } on PlatformException catch (e) {
      print("Failed to call native method: '${e.message}'.");
    }
    return -1;
  }

  void setMethodCallHandler(Future Function(MethodCall call) platformCallHandler) {
    _channel?.setMethodCallHandler(platformCallHandler);
  }
}