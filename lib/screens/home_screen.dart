import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/weather_cubit.dart';
import '../cubit/weather_state.dart';
import 'search_screen.dart';
import 'details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather Journal")),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherListLoaded) {
            final entries = state.entries;
            if (entries.isEmpty) {
              return const Center(child: Text("No saved entries yet."));
            }
            return ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return ListTile(
                  title: Text(entry.cityName),
                  subtitle: Text("${entry.temperature}°C - ${entry.condition}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<WeatherCubit>().deleteEntry(entry.id!);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsScreen(entry: entry),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text("Loading..."));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const SearchScreen()));
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
