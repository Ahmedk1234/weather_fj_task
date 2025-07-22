import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/weather_cubit.dart';
import '../cubit/weather_state.dart';
import '../data/weather_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  WeatherEntry? _weatherResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Weather")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: "Enter city name"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<WeatherCubit>().fetchWeather(_controller.text);
              },
              child: const Text("Search"),
            ),
            const SizedBox(height: 24),
            BlocConsumer<WeatherCubit, WeatherState>(
              listener: (context, state) {
                if (state is WeatherLoaded) {
                  setState(() => _weatherResult = state.entry);
                } else if (state is WeatherError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (_weatherResult != null) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("City: ${_weatherResult!.cityName}"),
                          Text("Temp: ${_weatherResult!.temperature}°C"),
                          Text("Condition: ${_weatherResult!.condition}"),
                          Text("Humidity: ${_weatherResult!.humidity}%"),
                          Text("Wind: ${_weatherResult!.windSpeed} m/s"),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () async {
                              await context
                                  .read<WeatherCubit>()
                                  .saveWeather(_weatherResult!);
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            },
                            child: const Text("Save"),
                          )
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
