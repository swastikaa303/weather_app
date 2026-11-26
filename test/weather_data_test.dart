import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/utilities/formatters.dart';
// Run with:  flutter test
void main() {
 group('WeatherData.fromJson', () {
   test('reads whole-number temperatures without crashing', () {
     final json = _sampleJson(temp: 20); // int, not double
     final weather = WeatherData.fromJson(json);
     expect(weather.temperature, 20.0);
   });
   test('works when optional fields (gust, visibility) are missing', () {
     final json = _sampleJson(temp: 18.4);
     (json['wind'] as Map<String, dynamic>).remove('gust');
     json.remove('visibility');
     final weather = WeatherData.fromJson(json);
     expect(weather.city, 'Busan');
     expect(weather.visibility, 0);
   });
   test('converts sunrise to city time with the timezone offset', () {
     final weather = WeatherData.fromJson(_sampleJson(temp: 18.4));
     final sunrise = weather.toCityTime(weather.sunrise);
     expect(formatTime(sunrise), '7:13 AM');
   });
 });
 group('formatters', () {
   test('formatTime uses a 12-hour clock with padded minutes', () {
     expect(formatTime(DateTime(2026, 11, 23, 17, 5)), '5:05 PM');
     expect(formatTime(DateTime(2026, 11, 23, 0, 30)), '12:30 AM');
     expect(formatTime(DateTime(2026, 11, 23, 12, 0)), '12:00 PM');
   });
   test('capitalizeWords handles empty text', () {
     expect(capitalizeWords('light rain'), 'Light Rain');
     expect(capitalizeWords(''), '');
   });
   test('compassDirection', () {
     expect(compassDirection(0), 'N');
     expect(compassDirection(315), 'NW');
     expect(compassDirection(359), 'N');
   });
 });
}
/// A trimmed copy of a real OpenWeather response for Busan.
Map<String, dynamic> _sampleJson({required num temp}) {
 return {
   'coord': {'lon': 129.04, 'lat': 35.1},
   'weather': [
     {'id': 500, 'main': 'Rain', 'description': 'light rain', 'icon': '10d'},
   ],
   'main': {
     'temp': temp,
     'feels_like': 17.9,
     'temp_min': 17,
     'temp_max': 19.2,
     'pressure': 1016,
     'humidity': 77,
   },
   'visibility': 10000,
   'wind': {'speed': 3.6, 'deg': 320, 'gust': 6.2},
   'dt': 1763888400,
   'sys': {'country': 'KR', 'sunrise': 1763849580, 'sunset': 1763886360},
   'timezone': 32400,
   'name': 'Busan',
   'cod': 200,
 };
}



