
import '../native_method_types/ask_location_permission.dart';
import '../native_method_types/clear_all_notifications.dart';
import '../native_method_types/get_int.dart';
import '../native_method_types/login.dart';
import '../native_method_types/logout.dart';
import '../native_method_types/open_url.dart';
import '../native_method_types/send_notification.dart';
import '../native_method_types/set_int.dart';

abstract class NativeMethodType {

  /// Region for Native Methods ///

  static sendNotification({required String id, required String title, required String text}) =>
      SendNotification(id: id, title: title, text: text);

  static clearAllNotifications() => ClearAllNotifications();

  static setInt({required int number}) => SetInt(number: number);

  static getInt() => GetInt();

  static askLocationPermission() => AskLocationPermission();

  static openUrl({required String url}) => OpenUrl(url: url);

  static logout() => Logout();
  static login() => Login();

  /// End Region for Native Methods ///

  String get methodName;
  Map<String, dynamic> get arguments => {};
}