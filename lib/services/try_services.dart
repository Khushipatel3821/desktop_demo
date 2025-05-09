import 'dart:io';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class TrayService with TrayListener {
  // Singleton instance
  static final TrayService _instance = TrayService._internal();
  bool _isInitialized = false;

  factory TrayService() {
    return _instance;
  }
  TrayService._internal();

  Future<void> initTray() async {
    if (_isInitialized) return;
    _isInitialized = true;

    try {
      await trayManager.setIcon(
        Platform.isWindows
            ? 'assets/images/desktop.ico'
            : 'assets/images/iosdesktop.png',
      );

      await trayManager.setContextMenu(Menu(items: [
        MenuItem(key: 'show', label: 'Show App'),
        MenuItem(key: 'hide', label: 'Hide App'),
        MenuItem.separator(),
        MenuItem(key: 'exit', label: 'Exit'),
      ]));
      await trayManager.setToolTip("Desktop Demo");

      trayManager.addListener(this);
    } catch (e) {
      print("Tray initialization failed: $e");
    }
  }

  @override
  void onTrayMenuItemClick(MenuItem item) async {
    switch (item.key) {
      case 'show':
        await windowManager.show();
        await windowManager.focus();
        break;
      case 'hide':
        await windowManager.hide();
        break;
      case 'exit':
        await destroyTray();
        exit(0);
    }
  }

  @override
  void onTrayIconMouseDown() async {
    // Show the app when user clicks the tray icon
    await windowManager.show();
    await windowManager.focus();
  }

  void dispose() {
    trayManager.removeListener(this);
  }

  Future<void> destroyTray() async {
    trayManager.removeListener(this);
    await trayManager.destroy();
    _isInitialized = false;
  }
}
