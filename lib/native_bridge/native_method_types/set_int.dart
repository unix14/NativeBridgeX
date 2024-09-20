
import '../logic/native_method_type.dart';

class SetInt extends NativeMethodType {

  int number;

  SetInt({required this.number});

  @override
  String get methodName => "setInt";

  @override
  Map<String, dynamic> get arguments => {
    "number": number
  };
}