import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {

  Future<String> fetchWeatherConditions() async {
    const String apiKey = 'bef3cd0ba2275d3967a024c2b4d5a609';
    const String location = 'Perth,australia'; // e.g., 'London,uk'
    const url = 'https://api.openweathermap.org/data/2.5/weather?q=$location&APPID=$apiKey';


    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final weatherData = json.decode(response.body);
      final main = weatherData['weather'][0]['main'].toLowerCase();
      final description = weatherData['weather'][0]['description']
          .toLowerCase();

      if (main.contains('rain') || description.contains('humid')) {
        return 'warm_humid';
      } else {
        return 'normal';
      }
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}