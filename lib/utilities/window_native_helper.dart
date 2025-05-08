import 'package:flutter/services.dart';

class WindowNativeHelper {
  static const platform = MethodChannel('com.example/native');

  Future<double> getIdleTime() async {
    try {
      final int idleTime = await platform.invokeMethod('getIdleTime');
      double idleTimeSeconds = idleTime / 1000;
      return idleTimeSeconds;
    } on PlatformException catch (e) {
      print("Failed to get idle time platform: '${e.message}'.");
      return 0;
    } catch (e) {
      print("Failed to get idle time: '${e.toString()}'.");
      return 0;
    }
  }

  Future<void> startListeningForLockEvents(Function(bool) onLockChanged) async {
    platform.setMethodCallHandler((MethodCall call) async {
      if (call.method == 'onScreenLock') {
        print("Screen locked!");
        onLockChanged(true);
      } else if (call.method == 'onScreenUnlock') {
        print("Screen unlocked!");
        onLockChanged(false);
      }
    });
  }

  Future<void> lockSystemScreen() async {
    try {
      await platform.invokeMethod('lockSystemScreen');
    } on PlatformException catch (e) {
      print("Failed to lock screen: '${e.message}'");
    }
  }

  // (if possible)
  Future<void> unlockSystemScreen() async {
    try {
      await platform.invokeMethod('unlockSystemScreen');
    } on PlatformException catch (e) {
      print("Failed to unlock screen: '${e.message}'");
    }
  }
}