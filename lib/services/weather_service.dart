import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/services/weather_exception.dart';
import 'package:weather_app/utilities/api_key.dart';
/// Talks to the OpenWeather "Current weather" API.
/// Docs: https://openweathermap.org/current
class WeatherService {
 static const String _host = 'api.openweathermap.org';
 static const String _path = '/data/2.5/weather';
 /// Weather at a GPS position.
 Future<WeatherData> getWeatherByLocation(double latitude, double longitude) {
   return _fetchWeather({'lat': 'latitude','lon':'longitude'});
 }
 /// Weather for a city name, e.g. "Busan" or "Hanoi,VN".
 Future<WeatherData> getWeatherByCity(String city) {
   return _fetchWeather({'q': city});
 }
 Future<WeatherData> _fetchWeather(Map<String, String> query) async {
   if (openWeatherApiKey == 'PASTE_YOUR_API_KEY_HERE') {
     throw const WeatherException(
       'Add your OpenWeather API key in lib/utilities/api_key.dart.',
     );
   }
   // Builds: https://api.openweathermap.org/data/2.5/weather?lat=..&lon=..&appid=..&units=metric
   final Uri url = Uri.https(_host, _path, {
     ...query,
     'appid': openWeatherApiKey,
     'units': 'metric', // °C and m/s
   });
   final http.Response response;
   try {
     response = await http.get(url).timeout(const Duration(seconds: 10));
   } on TimeoutException {
     throw const WeatherException('The weather server is too slow. Please try again.');
   } catch (_) {
     throw const WeatherException('No internet connection. Please check your network.');
   }
   switch (response.statusCode) {
     case 200:
       final json = jsonDecode(response.body) as Map<String, dynamic>;
       return WeatherData.fromJson(json);
     case 401:
       throw const WeatherException(
         'Invalid API key. Check lib/utilities/api_key.dart '
         '(new keys can take up to 2 hours to activate).',
       );
     case 404:
       throw const WeatherException('City not found. Check the spelling and try again.');
     case 429:
       throw const WeatherException('Too many requests. Please wait a minute.');
     default:
       throw WeatherException('Weather server error (${response.statusCode}).');
   }
 }
}

