import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String apiKey = '1f321faa27b838eab4859c981a067217';

  static Future<Map<String, dynamic>?> fetchWeather(String city) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }
}
