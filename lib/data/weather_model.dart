class WeatherEntry {
  final int? id;
  final String cityName;
  final double temperature;
  final String condition;
  final int humidity;
  final double windSpeed;

  WeatherEntry({
    this.id,
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
  });

  factory WeatherEntry.fromMap(Map<String, dynamic> map) => WeatherEntry(
    id: map['id'],
    cityName: map['cityName'],
    temperature: map['temperature'],
    condition: map['condition'],
    humidity: map['humidity'],
    windSpeed: map['windSpeed'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'cityName': cityName,
    'temperature': temperature,
    'condition': condition,
    'humidity': humidity,
    'windSpeed': windSpeed,
  };
}
