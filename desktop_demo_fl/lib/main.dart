import 'dart:io';

import 'package:desktop_demo_fl/screens/home_screen.dart';
import 'package:desktop_demo_fl/services/try_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:windows_single_instance/windows_single_instance.dart';

import 'controllers/home_controller.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isPrimaryInstance = true;
  await WindowsSingleInstance.ensureSingleInstance(
    args,
    'com.example.desktop_demo_fl',
    onSecondWindow: (args) async {
      isPrimaryInstance = false;
      await windowManager.show();
      await windowManager.focus();
      exit(0);
    },
  );

  await windowManager.ensureInitialized();

  if (!kIsWeb) {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      launchAtStartup.setup(
        appName: packageInfo.appName,
        appPath: Platform.resolvedExecutable,
        packageName: 'com.example.desktop_demo_fl',
      );
      if (!await launchAtStartup.isEnabled()) {
        await launchAtStartup.enable();
      }
    } catch (e) {
      print("Launch at startup failed: $e");
    }
  }

  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    center: true,
    skipTaskbar: false,
    title: "My Tray App",
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  // Prevent the app from closing when the close button is clicked
  await windowManager.setPreventClose(true);
  if (isPrimaryInstance) {
    final trayService = TrayService();
    await trayService.initTray();

    windowManager.addListener(MyWindowListener(trayService));

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeController()),
          Provider.value(value: trayService), // tray manager as provider
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyWindowListener extends WindowListener {
  final TrayService trayService;

  MyWindowListener(this.trayService);

  @override
  void onWindowClose() async {
    await windowManager.hide();
  }

  void onWindowDestroy() async {
    await trayService.destroyTray();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
