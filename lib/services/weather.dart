import 'dart:async';

import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';

const apiKey = '2121b968590731cfe277b69ff606c2e9';

class WeatherModel {
  Future getCityWeather(String city) async{
    

    final url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'q':city,
      'appid': apiKey,
      'units': 'metric',
    });
    NetworkingHelper networkingHelp = NetworkingHelper(url);
    var weatherData = await networkingHelp.getData();
    return weatherData;
  }

  Future getLocationWeather() async{
    Location location = Location();
    await location.getCurrentLocation();


    final url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'lat': location.lat.toString(),
      'lon': location.lgt.toString(),
      'appid': apiKey,
      'units': 'metric',
    });
    NetworkingHelper networkingHelp = NetworkingHelper(url);
    var weatherData = await networkingHelp.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
