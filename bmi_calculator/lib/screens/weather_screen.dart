import 'package:bmi_calculator/data/http_helper.dart';
import 'package:bmi_calculator/data/weather.dart';
import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController textCityLocationController =
      TextEditingController();
  Weather weatherResult = Weather('', '', 0, 0, 0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: textCityLocationController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  labelText: 'Enter City',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      getData();
                    },
                  )),
            ),
            weatherRow('City location:', weatherResult.name),
            weatherRow('Description:', weatherResult.description),
            weatherRow('Temperature:','${weatherResult.temperature.toStringAsFixed(2)} °C'),
            weatherRow('Perceived:', '${weatherResult.perceived.toStringAsFixed(2)} °C'),
            weatherRow('Pressure:', weatherResult.pressure.toString()),
            weatherRow('Humidity:', weatherResult.humidity.toString()),
          ],
        ),
      ),
    );
  }

  Future getData() async {
    HttpHelper httpHelper = HttpHelper();
    weatherResult =
        await httpHelper.getWeather(textCityLocationController.text);
    setState(() {});
  }

  Widget weatherRow(String lable, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Text(
                lable,
                style: const TextStyle(color: Colors.grey, fontSize: 20),
              )),
          Expanded(
              flex: 4,
              child: Text(
                value,
                style: const TextStyle(color: Colors.blueGrey, fontSize: 20),
              )),
        ],
      ),
    );
  }
}
