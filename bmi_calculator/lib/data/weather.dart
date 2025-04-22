class Weather {

  String name = '';
  String description = '';
  int humidity = 0;
  int pressure = 0;
  double temperature = 0;
  double perceived = 0;

  Weather(this.name, this.description, this.humidity, this.pressure,
      this.temperature, this.perceived);

  Weather.fromJson(Map<String, dynamic> weatherMap) {
    name = weatherMap['name'];
    temperature = (weatherMap['main']['temp'] - 273.15) ?? 0;  // Temperature in Celcious
    pressure = (weatherMap['main']['pressure']) ?? 0;
    humidity = (weatherMap['main']['humidity']) ?? 0;
    perceived = (weatherMap['main']['feels_like'] - 273.15) ?? 0; // Temperature in Celcious
    description = (weatherMap['weather'][0]['main']) ?? 0;
  }
}