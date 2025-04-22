import 'dart:convert';

import 'package:bmi_calculator/data/weather.dart';
import 'package:http/http.dart' as http;
class HttpHelper {
//https://api.openweathermap.org/data/2.5/weather?q=Rajkot&appid=92998b567d3ec5b01846d2d66dee693b
  final String authority = "api.openweathermap.org";
  final String path = "/data/2.5/weather";
  final String apiKey = "92998b567d3ec5b01846d2d66dee693b";

  Future<Weather> getWeather(String location) async {
    Map<String, dynamic> parameters = {'q' : location, 'appid' : apiKey};
    Uri uri = Uri.https(authority, path, parameters);
    http.Response responseResult = await http.get(uri);

    Map<String, dynamic> data = json.decode(responseResult.body);
    Weather weather = Weather.fromJson(data);

    return weather;
  }
}