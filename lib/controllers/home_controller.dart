import 'dart:async';
import 'package:flutter/material.dart';

import '../utilities/window_native_helper.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    _listenForLockEvents(); // Start listening automatically
  }

  String yourText = "";

  double idleTimeInSeconds = 0.0;
  double _previousIdleTime = 0.0;
  double get idleTimeInMinutes => idleTimeInSeconds / 60;
  double get idleTimeInHours => idleTimeInSeconds / 3600;

  final TextEditingController displayTextEditingController =
      TextEditingController();

  Timer? _pollingTimer;

  bool _isScreenLocked = false;
  bool get isScreenLocked => _isScreenLocked;

  final nativeHelper = WindowNativeHelper();
  String idleWarningMessage = "User is Active";
  bool _userWasInactive = false;

  void updateText(String newText) {
    yourText = newText;
    notifyListeners();
  }

  void startTrackingIdleTime() {
    _pollingTimer?.cancel();

    _pollingTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
      final newIdle = await nativeHelper.getIdleTime();

      // User became active (idle time dropped)
      if (newIdle < _previousIdleTime) {
        idleWarningMessage = "User is Active";
        _userWasInactive = false;
      }

      // User has been inactive long enough
      if (newIdle > 10 && !_userWasInactive) {
        idleWarningMessage = "User is not Active";
        _userWasInactive = true;
      }

      idleTimeInSeconds = newIdle;
      _previousIdleTime = newIdle;

      notifyListeners();
    });
  }

  @override
  void dispose() {
    displayTextEditingController.dispose();
    _pollingTimer?.cancel();
    super.dispose();
  }

  void _listenForLockEvents() {
    nativeHelper.startListeningForLockEvents((bool isLocked) {
      _isScreenLocked = isLocked;
      idleWarningMessage = isLocked ? "Screen is Locked" : "User is Active";
      notifyListeners();
    });
  }

  Future<void> screenLock() async {
    await nativeHelper.lockSystemScreen();
  }

  Future<void> screenUnlock() async {
    await nativeHelper.unlockSystemScreen();
  }
}
