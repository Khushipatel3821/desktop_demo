import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:android_intent_plus/android_intent.dart';

class AuthService {
  final LocalAuthentication localAuth = LocalAuthentication();

  Future<bool> authenticateLocally(BuildContext context) async {
    bool isAuthenticate = false;

    try {
      isAuthenticate = await localAuth.authenticate(
        localizedReason: "We have to require the authentication for this APP.",
        options: AuthenticationOptions(stickyAuth: true, useErrorDialogs: true),
      );
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled || e.code == auth_error.notAvailable) {
        print("Auth Error not enroll ${e.message}");
        _showSettingsDialog(context);
      } else if (e.code == auth_error.lockedOut ||
          e.code == auth_error.permanentlyLockedOut) {
        print("Auth Error locked out  ${e.message}");
      } else {
        print("Auth Error ${e.message}");
      }
    } catch (e) {
      isAuthenticate = false;
      print("Auth Error : $e");
    }

    return isAuthenticate;
  }

  void _showSettingsDialog(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Security Setup Required"),
        content: const Text(
            "No security credentials found. Do you want to set them now?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _openSecuritySettings();
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  void _openSecuritySettings() {
    const AndroidIntent intent = AndroidIntent(
      action: 'android.settings.SECURITY_SETTINGS',
      flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
    );
    intent.launch();
  }
}
