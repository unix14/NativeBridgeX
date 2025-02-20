import 'package:native_bridge_x/src/bridge/native_bridge_x.dart';
import 'package:native_bridge_x/src/logic/native_bridge_type.dart';
import 'package:native_bridge_x/src/logic/native_method_type.dart';

void main() {
  final nativeBridge = NativeBridgeX.build(NativeBridgeType.MAIN_ACTIVITY);

  // Send a notification
  nativeBridge.invokeMethod(NativeMethodType.sendNotification(
    id: '1',
    title: 'Hello',
    text: 'This is a test notification',
  ));

  // Set an integer value
  nativeBridge.invokeMethod(NativeMethodType.setInt(number: 42));

  // Get an integer value
  nativeBridge.invokeMethod(NativeMethodType.getInt()).then((result) {
    print('Received integer: $result');
  });

  // Open a URL in the native browser
  nativeBridge.invokeMethod(NativeMethodType.openUrl(url: 'https://github.com/unix14'));
}