import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/weather_model.dart';
import '../data/weather_database.dart';
import '../services/weather_service.dart';
import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  Future<void> fetchWeather(String city) async {
    emit(WeatherLoading());
    try {
      final data = await WeatherService.fetchWeather(city);
      if (data == null) throw Exception("City not found");

      final entry = WeatherEntry(
        cityName: data['name'],
        temperature: data['main']['temp'].toDouble(),
        condition: data['weather'][0]['main'],
        humidity: data['main']['humidity'],
        windSpeed: data['wind']['speed'].toDouble(),
      );

      emit(WeatherLoaded(entry));
    } catch (e) {
      emit(WeatherError(e.toString()));
      loadSavedEntries();
    }
  }

  Future<void> saveWeather(WeatherEntry entry) async {
    await WeatherDatabase.instance.insertWeather(entry);
    loadSavedEntries();
  }

  Future<void> loadSavedEntries() async {
    final entries = await WeatherDatabase.instance.fetchAll();
    emit(WeatherListLoaded(entries));
  }

  Future<void> deleteEntry(int id) async {
    await WeatherDatabase.instance.deleteWeather(id);
    loadSavedEntries();
  }
}
