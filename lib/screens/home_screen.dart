import 'dart:io';

import 'package:desktop_demo_fl/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final homeController = context.watch<HomeController>();
    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeController>().init();
    });*/
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Desktop Demo"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enter your text:'),
              TextField(
                controller: homeController.displayTextEditingController,
                decoration: const InputDecoration(
                  hintText: 'Type here...',
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    final inputText = homeController.displayTextEditingController.text;
                    homeController.updateText(inputText);
                    if (Platform.isWindows ||
                        Platform.isLinux ||
                        Platform.isMacOS) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Running on Desktop!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else if (Platform.isAndroid || Platform.isIOS) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Running on Android!'),
                          duration: Duration(seconds: 5),
                        ),
                      );
                    }
                  },
                  child: const Text('Show Text'),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'You entered: ${homeController.yourText}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              DataTable(
                columns: const [
                  DataColumn(
                    label: Text(
                      'Type',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Hours',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Minutes',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Seconds',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(Text("System Idle Time (from OS)")),
                      DataCell(Text(homeController.idleTimeInHours
                          .toStringAsFixed(2))),
                      DataCell(Text(homeController.idleTimeInMinutes
                          .toStringAsFixed(2))),
                      DataCell(Text(homeController.idleTimeInSeconds
                          .toStringAsFixed(2))),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  homeController.idleWarningMessage.isNotEmpty? homeController.idleWarningMessage.toString() : "Checking Activity...",
                  style: TextStyle(
                    color: homeController.idleTimeInSeconds > 10.0
                        ? Colors.red
                        : Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () async {
                    if (homeController.isScreenLocked) {
                      homeController.screenUnlock(); // Unlock screen
                    } else {
                      homeController.screenLock(); // Lock screen
                    }
                  },
                  child: Text(homeController.isScreenLocked ? "Unlock Screen" : "Lock Screen"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
