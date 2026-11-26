/// One snapshot of the current weather for a place.
///
/// Every field is `final`: once we have the data we never change it.
/// To show new weather we simply create a new WeatherData object.
class WeatherData {
 const WeatherData({
   required this.city,
   required this.country,
   required this.conditionId,
   required this.description,
   required this.iconCode,
   required this.temperature,
   required this.feelsLike,
   required this.tempMin,
   required this.tempMax,
   required this.humidity,
   required this.pressure,
   required this.visibility,
   required this.windSpeed,
   required this.windDeg,
   required this.sunrise,
   required this.sunset,
   required this.updatedAt,
   required this.timezoneOffset,
 });
 final String city;
 final String country;
 final int conditionId; // e.g. 500 = light rain, 800 = clear sky
 final String description; // e.g. "light rain"
 final String iconCode; // e.g. "10d" (d = day, n = night)
 final double temperature; // °C
 final double feelsLike; // °C
 final double tempMin; // °C
 final double tempMax; // °C
 final int humidity; // %
 final int pressure; // hPa
 final int visibility; // metres
 final double windSpeed; // m/s
 final int windDeg; // direction the wind comes FROM, 0 = north
 final DateTime sunrise; // UTC
 final DateTime sunset; // UTC
 final DateTime updatedAt; // UTC
 final int timezoneOffset; // seconds from UTC, e.g. 32400 for Korea (+9h)
 /// Builds a WeatherData from the JSON returned by
 /// https://api.openweathermap.org/data/2.5/weather
 ///
 /// Two lessons hidden in here:
 /// 1. JSON numbers can be `int` OR `double` (20 vs 20.5), so we read them
 ///    as `num` and convert with toDouble()/toInt().
 /// 2. Some fields (wind.gust, visibility, ...) are sometimes missing, so we
 ///    use `?` and `??` to fall back to a default instead of crashing.
 factory WeatherData.fromJson(Map<String, dynamic> json) {
   final Map<String, dynamic> weather =
       (json['weather'] as List<dynamic>).first as Map<String, dynamic>;
   final Map<String, dynamic> main = json['main'] as Map<String, dynamic>;
   final Map<String, dynamic> wind =
       json['wind'] as Map<String, dynamic>? ?? const <String, dynamic>{};
   final Map<String, dynamic> sys =
       json['sys'] as Map<String, dynamic>? ?? const <String, dynamic>{};
   return WeatherData(
     city: json['name'] as String? ?? 'Unknown',
     country: sys['country'] as String? ?? '',
     conditionId: (weather['id'] as num).toInt(),
     description: weather['description'] as String? ?? '',
     iconCode: weather['icon'] as String? ?? '01d',
     temperature: (main['temp'] as num).toDouble(),
     feelsLike: (main['feels_like'] as num).toDouble(),
     tempMin: (main['temp_min'] as num).toDouble(),
     tempMax: (main['temp_max'] as num).toDouble(),
     humidity: (main['humidity'] as num).toInt(),
     pressure: (main['pressure'] as num).toInt(),
     visibility: (json['visibility'] as num?)?.toInt() ?? 0,
     windSpeed: (wind['speed'] as num?)?.toDouble() ?? 0.0,
     windDeg: (wind['deg'] as num?)?.toInt() ?? 0,
     sunrise: _utcFromSeconds(sys['sunrise']),
     sunset: _utcFromSeconds(sys['sunset']),
     updatedAt: _utcFromSeconds(json['dt']),
     timezoneOffset: (json['timezone'] as num?)?.toInt() ?? 0,
   );
 }
 /// OpenWeather sends times as "seconds since 1 Jan 1970 (UTC)".
 static DateTime _utcFromSeconds(dynamic seconds) {
   final int value = (seconds as num?)?.toInt() ?? 0;
   return DateTime.fromMillisecondsSinceEpoch(value * 1000, isUtc: true);
 }
 /// Converts a UTC time to the clock time *in this city*
 /// (not in the phone's time zone).
 DateTime toCityTime(DateTime utcTime) =>
     utcTime.toUtc().add(Duration(seconds: timezoneOffset));
 /// The OpenWeather icon code ends with "d" in daytime and "n" at night.
 bool get isDay => iconCode.endsWith('d');
}




