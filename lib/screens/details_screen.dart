import 'package:flutter/material.dart';
import '../data/weather_model.dart';

class DetailsScreen extends StatelessWidget {
  final WeatherEntry entry;

  const DetailsScreen({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("City: ${entry.cityName}"),
            Text("Temperature: ${entry.temperature}°C"),
            Text("Condition: ${entry.condition}"),
            Text("Humidity: ${entry.humidity}%"),
            Text("Wind Speed: ${entry.windSpeed} m/s"),
          ],
        ),
      ),
    );
  }
}
