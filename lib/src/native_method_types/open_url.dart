
import '../logic/native_method_type.dart';

class OpenUrl extends NativeMethodType {

  String url;

  OpenUrl({required this.url});

  @override
  String get methodName => "openUrl";

  @override
  Map<String, dynamic> get arguments => {
    "url": url
  };
}