package com.example.native_bridge

import android.app.Activity
import android.app.Application
import android.app.NotificationManager
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterActivity
import android.content.Context
import android.os.Build
import android.content.pm.PackageManager
import android.widget.Toast
import android.util.Log
import android.content.Intent
import android.net.Uri
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

import com.example.native_bridge.common.Constants
import com.example.native_bridge.common.sendNotification

class MainActivity: FlutterActivity() {

    private val CHANNEL = "${Constants.APP_DOMAIN}/${Constants.MAIN_ACTIVITY}"
    private lateinit var mChannel: MethodChannel
    private var intNumber: Int = -1

    @RequiresApi(Build.VERSION_CODES.S)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        val notificationManager: NotificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        mChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL);
        mChannel.setMethodCallHandler { call, result ->
            // Note: this method is invoked on the main thread.
            if (call.method == "setInt") {
                intNumber = call.argument<Int>("number") ?: -1;
                notify("setInt: $intNumber")

                if (intNumber != -1) {
                    result.success(1)
                } else {
                    result.error("MainActivity", "Error setting the int.", null)
                }
            } else if (call.method == "getInt") {
                notify("getInt: $intNumber")

                if (intNumber != -1) {
                    result.success(intNumber)
                } else {
                    result.error("MainActivity", "Error getting the int.", null)
                }
            } else if (call.method == "logout") {
                notify("logout")
                result.success(1)
            } else if (call.method == "login") {
                notify("login")
                result.success(1)
            } else if (call.method == "sendNotification") {
                val id: String= call.argument<String>("id") ?: "-1";
                val title: String = call.argument<String>("title") ?: "-1";
                val text: String = call.argument<String>("text") ?: "-1";

                notify("sendNotification $title: $text with id: $id")
                /// todo send notification
                sendNotification(this@MainActivity, id, title, text);
                result.success(1)
            } else if(call.method == "askLocationPermission") {
                notify("askLocationPermission")
                requestLocationPermission()
                result.success(1)
            } else if(call.method == "clearAllNotifications") {
                notify("clearAllNotifications")
                // Remove all delivered notifications
                notificationManager.cancelAll()
                result.success(1)
            } else if(call.method == "openUrl") {
                val url: String = call.argument<String>("url") ?: "https://3p-cups.com/";
                notify("openUrl: $url")
                // Open the url
                 val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
                 startActivity(intent)
                result.success(1)
            } else {
                result.notImplemented()
            }
        };
    }

    private fun notify(text: String) {
        Toast.makeText(this, text, Toast.LENGTH_SHORT).show()
        Log.d("MainActivity", text)
    }

    private fun requestLocationPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            if (ActivityCompat.checkSelfPermission(this,
                    android.Manifest.permission.ACCESS_BACKGROUND_LOCATION) !== PackageManager.PERMISSION_GRANTED) {
                // Request ACCESS_BACKGROUND_LOCATION permission
                ActivityCompat.requestPermissions(this,
                    arrayOf<String>(android.Manifest.permission.ACCESS_BACKGROUND_LOCATION), 666)
            }
        }
    }
}