
enum NativeBridgeType { GENERAL, MAIN_ACTIVITY, CUSTOM }

extension NativeBridgeTypeExtension on NativeBridgeType {
  String get name {
    switch(this) {
      case NativeBridgeType.GENERAL: return "general";
      case NativeBridgeType.MAIN_ACTIVITY: return "mainActivity";
      case NativeBridgeType.CUSTOM: return "custom";
    }
  }
}