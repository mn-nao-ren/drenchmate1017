class WeatherData {
  final double temperature; // in Celsius
  final double humidity; // percentage
  final double rainfall; // in millimeters

  WeatherData({
    required this.temperature,
    required this.humidity,
    required this.rainfall,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: json['temperature'] ?? 0.0,
      humidity: json['humidity'] ?? 0.0,
      rainfall: json['rainfall'] ?? 0.0,
    );
  }

  @override
  String toString() {
    return 'WeatherData { temperature: $temperature°C, humidity: $humidity%, rainfall: $rainfall mm }';
  }
}
