// ignore_for_file: avoid_print

import 'package:weather/weather.dart';

class WeatherService {
  final WeatherFactory _weatherFactory = WeatherFactory("81a204ff91945a851c8682f57ce3158c");

  Future<Weather?> getCurrentWeather(String city) async {
    try {
      Weather weather = await _weatherFactory.currentWeatherByCityName(city);
      return weather;
    } catch (e) {
      if (e.toString().contains('401')) {
        print("Invalid API key. Please check your API key.");
      } else {
        print(e);
      }
      return null;
    }
  }
}
