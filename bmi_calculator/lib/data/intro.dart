import 'package:bmi_calculator/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class IntroDetails extends StatelessWidget {
  final String fitnessPath;
  final String fitnessTag;

  IntroDetails(this.fitnessPath, this.fitnessTag, {super.key});

  @override
  Widget build(BuildContext context) {
    timeDilation = 10;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Globo Fitness')),
      body: Center(
        child: Utils.buildHeroDestination(fitnessPath, fitnessTag, width),
      ),

    );
  }
}
