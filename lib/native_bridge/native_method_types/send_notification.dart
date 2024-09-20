
import '../logic/native_method_type.dart';

class SendNotification extends NativeMethodType {

  String id;
  String title;
  String text;

  SendNotification({required this.id, required this.title, required this.text});

  @override
  String get methodName => "sendNotification";

  @override
  Map<String, dynamic> get arguments => {
    "id": id,
    "title": title,
    "text": text
  };
}