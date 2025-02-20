
enum NativeBridgeType {

  GENERAL, MAIN_ACTIVITY, CUSTOM;

  String getCustomChannelName(String channelName) {
    return "com.example.native_bridge_x/$channelName";
  }

}

extension NativeBridgeTypeExtension on NativeBridgeType {
  String getBridgeName(String defaultChannelName) {
    switch(this) {
      case NativeBridgeType.GENERAL: return "general";
      case NativeBridgeType.MAIN_ACTIVITY: return "mainActivity";
      case NativeBridgeType.CUSTOM: return getCustomChannelName(defaultChannelName);
    }
  }
}