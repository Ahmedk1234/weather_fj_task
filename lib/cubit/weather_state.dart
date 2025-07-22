import '../data/weather_model.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherEntry entry;
  WeatherLoaded(this.entry);
}

class WeatherListLoaded extends WeatherState {
  final List<WeatherEntry> entries;
  WeatherListLoaded(this.entries);
}

class WeatherError extends WeatherState {
  final String message;
  WeatherError(this.message);
}
