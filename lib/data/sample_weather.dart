import 'package:weather_app/models/weather_data.dart';


/// Fake data so we can design the screen before we connect to the internet.
/// (DateTime cannot be `const`, so this is `final`.)
final WeatherData sampleWeather = WeatherData(
 city: 'Busan',
 country: 'KR',
 conditionId: 801,
 description: 'few clouds',
 iconCode: '02d',
 temperature: 18.4,
 feelsLike: 17.9,
 tempMin: 17.0,
 tempMax: 19.2,
 humidity: 77,
 pressure: 1016,
 visibility: 10000,
 windSpeed: 3.6,
 windDeg: 320,
 sunrise: DateTime.utc(2026, 11, 22, 22, 13), // = 7:13 AM in Korea
 sunset: DateTime.utc(2026, 11, 23, 8, 26), // = 5:26 PM in Korea
 updatedAt: DateTime.now().toUtc(),
 timezoneOffset: 32400, // +9 hours, in seconds
);



