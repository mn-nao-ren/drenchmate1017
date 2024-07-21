import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drenchmate_2024/business_logic/models/weather_data.dart';
import 'package:http/http.dart' as http;

class AdvancedNoticeRepository {


  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  // Mock methods to fetch data, replace with actual data fetching logic
  Future<WeatherData> getWeatherData() async {
    const String apiKey = 'bef3cd0ba2275d3967a024c2b4d5a609';
    const String location = 'Perth,australia'; // e.g., 'London,uk'
    const url = 'https://api.openweathermap.org/data/2.5/weather?q=$location&APPID=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final temperature = data['main']['temp'];
        final humidity = data['main']['humidity'];
        final rainfall = data['rain'] != null ? data['rain']['1h'] : 0.0;
        return WeatherData(
          temperature: temperature,
          humidity: humidity,
          rainfall: rainfall,
        );
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error: Failed to fetch weather data - $e');
      throw Exception('Failed to fetch weather data');
    }
  }

  Future<int> getEggCount() async {
    try {
      // Simulate network call
      return 100; // Placeholder for actual egg count
    } catch (e) {
      print('Error: Failed to fetch egg count - $e');
      throw Exception('Failed to fetch egg count');
    }
  }

  Future<DateTime> getLastDrenchDate() async {
    try {
      // Simulate network call
      return DateTime.now().subtract(const Duration(days: 10)); // Placeholder for actual last drench date
    } catch (e) {
      print('Error: Failed to fetch last drench date - $e');
      throw Exception('Failed to fetch last drench date');
    }
  }
}
