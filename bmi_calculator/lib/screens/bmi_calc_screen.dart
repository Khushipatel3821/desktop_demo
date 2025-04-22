import 'package:bmi_calculator/shared/menu_bottom.dart';
import 'package:bmi_calculator/shared/menu_drawer.dart';
import 'package:flutter/material.dart';

class BMICalcScreen extends StatefulWidget {
  const BMICalcScreen({Key? key}) : super(key: key);

  @override
  State<BMICalcScreen> createState() => _BMICalcScreenState();
}

class _BMICalcScreenState extends State<BMICalcScreen> {
  final TextEditingController textHeightController = TextEditingController();
  final TextEditingController textWeightController = TextEditingController();
  final double fontSize = 18;
  String result = '';
  bool isMetric = true;
  bool isImperial = false;
  double? height;
  double? weight;
  late List<bool> isSelected;
  String heightMsg = '';
  String weightMsg = '';

  @override
  void initState() {
    isSelected = [isMetric, isImperial];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    heightMsg =
        'Please enter your height in ${(isMetric) ? 'meter' : 'inches'}';
    weightMsg =
        'Please enter your weight in ${(isMetric) ? 'kilos' : 'pounds'}';
    return Scaffold(
        appBar: AppBar(title: const Text('BMI Calculator')),
        drawer: const MenuDrawer(),
        bottomNavigationBar: const MenuBottom(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ToggleButtons(
                      isSelected: isSelected,
                      onPressed: toggleMeasure,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Metric',
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Imperial',
                            style: TextStyle(fontSize: fontSize),
                          ),
                        )
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: textHeightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: heightMsg),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: textWeightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: weightMsg),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                    onPressed: calculateBmi,
                    child: Text(
                      'Calculate BMI',
                      style: TextStyle(fontSize: fontSize, color: Colors.white),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  result,
                  style: TextStyle(fontSize: fontSize),
                ),
              )
            ],
          ),
        ));
  }

  void toggleMeasure(value) {
    if (value == 0) {
      isMetric = true;
      isImperial = false;
    } else {
      isImperial = true;
      isMetric = false;
    }
    setState(() {
      isSelected = [isMetric, isImperial];
    });
  }

  void calculateBmi() {
    double bmi = 0;
    double height = double.tryParse(textHeightController.text) ?? 0;
    double weight = double.tryParse(textWeightController.text) ?? 0;

    if (isMetric) {
      bmi = weight / (height * height);
    } else {
      bmi = weight * 703 / (height * height);
    }
    setState(() {
      result = 'Your BMI is ${bmi.toStringAsFixed(2)}';
    });
  }
}
