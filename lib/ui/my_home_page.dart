
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:native_bridge/native_bridge/bridge/native_bridge_x.dart';

import '../native_bridge/logic/native_bridge_type.dart';
import '../native_bridge/logic/native_method_type.dart';

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late NativeBridgeX nativeBridge;
  bool isLoggedIn = false;
  int? currentUserId;

  String notificationTitle = "title";
  String notificationText = "text";


  @override
  void initState() {
    nativeBridge = NativeBridgeX.build(NativeBridgeType.MAIN_ACTIVITY);
    // nativeBridge.invokeMethod(NativeMethodType.sendNotification(id: "1", title: "Test", text: "App is running", isSilent: true, baseSerial: "", seatSerial: ""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Native Bridge Demo"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'NativeBridge is a library that allows you to invoke native methods from your Flutter code',
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Click on the native method button to invoke it',
                ),
              ),
              const Divider(),
              isLoggedIn ? const Text("User is logged in") : const Text("User is not logged in"),
              TextButton(onPressed: () async {
                var result = await nativeBridge.invokeMethod(NativeMethodType.login());
                setState(() {
                  isLoggedIn = result == 1;
                });
              }, child: const Text("login")),
              TextButton(onPressed: () async {
                var result = await nativeBridge.invokeMethod(NativeMethodType.logout());
                setState(() {
                  isLoggedIn = result != 1;
                });
              }, child: const Text("logout")),
              const Divider(),
              // TextButton(onPressed: () {
              //   nativeBridge.invokeMethod(NativeMethodType.askLocationPermission());
              // }, child: const Text("askLocationPermission")),
              // const Divider(),
              const Padding(padding: EdgeInsets.all(8)),
              SizedBox(
                width: 135,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'title',
                  ),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    setState(() {
                      notificationTitle = value;
                    });
                  },
                ),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              SizedBox(
                width: 185,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'text',
                  ),
                  onChanged: (value) {
                    setState(() {
                      notificationText = value;
                    });
                  },
                ),
              ),
              TextButton(onPressed: () {
                nativeBridge.invokeMethod(NativeMethodType.sendNotification(id: "${Random().nextInt(100)}", title: notificationTitle, text: notificationText));
              }, child: const Text("sendNotification")),
              TextButton(onPressed: () {
                nativeBridge.invokeMethod(NativeMethodType.clearAllNotifications());
              }, child: const Text("clearAllNotifications")),
              const Divider(),
              currentUserId != null ? Text(
                'user Id is $currentUserId',
              ) : Container(),
              TextButton(onPressed: () {
                nativeBridge.invokeMethod(NativeMethodType.setInt(number: Random().nextInt(100)));
              }, child: const Text("setUserId")),
              TextButton(onPressed: () async {
                var result = await nativeBridge.invokeMethod(NativeMethodType.getInt());
                print("UserId: $result");
                setState(() {
                  currentUserId = result;
                });
              }, child: const Text("getUserId")),
              const Divider(),
              const Padding(padding: EdgeInsets.all(18)),
              const Text("This demo app is created by Eyal Yaakobi"),
              TextButton(onPressed: () {
                nativeBridge.invokeMethod(NativeMethodType.openUrl(url: "https://github.com/unix14"));
              }, child: const Text("Go to Github")),
              TextButton(onPressed: () {
                nativeBridge.invokeMethod(NativeMethodType.openUrl(url: "https://eyal-ya.web.app/"));
              }, child: const Text("Go to Website")),
            ],
          ),
        ),
      ),
    );
  }
}