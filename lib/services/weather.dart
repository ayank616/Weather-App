// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const String apiKey = '6b23aa21b0647dd0fd4b490968b218f1';
const String weatherApi = 'https://api.openweathermap.org/data/2.5/weather?';

class WeatherModel {
  Future getCityWeather(String cityName) async {
    Networking networking =
        Networking("${weatherApi}q=${cityName}&appid=${apiKey}&units=metric");

    dynamic cityWeather = await networking.getData();

    return cityWeather;
  }

  Future getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    Networking networking = Networking(
        "${weatherApi}lat=${location.latitude}&lon=${location.longitude}&appid=${apiKey}&units=metric");

    dynamic weatherData = await networking.getData();

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
