import 'dart:io';

import 'package:desktop_demo_fl/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = context.watch<HomeController>();
    final TextEditingController displayTextEditingController =
        TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Flutter Desktop Demo"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enter your text:'),
            TextField(
              controller: displayTextEditingController,
              decoration: const InputDecoration(
                hintText: 'Type here...',
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  final inputText = displayTextEditingController.text;
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
          ],
        ),
      ),
    );
  }
}
