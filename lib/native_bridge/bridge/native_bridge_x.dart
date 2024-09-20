

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../logic/native_bridge_handler.dart';
import '../logic/native_bridge_type.dart';
import '../logic/native_method_type.dart';

class NativeBridgeX {

  String channelNameSuffix;
  NativeBridgeHandler _nativeBridgeHandler;

  static NativeBridgeX build(NativeBridgeType nativeBridgeType) {
    return NativeBridgeX(channelNameSuffix: nativeBridgeType.name);
  }

  NativeBridgeX({required this.channelNameSuffix}) :
        _nativeBridgeHandler = NativeBridgeHandler('com.example.native_bridge/$channelNameSuffix');

  @nonVirtual
  Future<int> callNativeMethod(String methodName, Map<String, dynamic> arguments) async {
    return await Future.delayed(Duration.zero, () async {
      return await _nativeBridgeHandler.callNativeMethod(methodName, arguments);
    });
  }

  @nonVirtual
  Future<int> invokeMethod(NativeMethodType nativeMethodType) async {
    print("NativeBridgeX.invokeMethod: ${nativeMethodType.methodName} ${nativeMethodType.arguments}");
    return await callNativeMethod(nativeMethodType.methodName, nativeMethodType.arguments);
  }

  void setMethodCallHandler(Future Function(MethodCall call) platformCallHandler) {
    _nativeBridgeHandler.setMethodCallHandler(platformCallHandler);
  }
}