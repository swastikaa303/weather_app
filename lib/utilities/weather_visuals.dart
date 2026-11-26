import 'package:flutter/cupertino.dart';
import 'package:weather_app/models/weather_data.dart';
/// Picks an icon for an OpenWeather icon code.
/// Full list of codes: https://openweathermap.org/weather-conditions
IconData weatherIcon(String iconCode) {
 return switch (iconCode) {
   '01d' => CupertinoIcons.sun_max_fill,
   '01n' => CupertinoIcons.moon_stars_fill,
   '02d' => CupertinoIcons.cloud_sun_fill,
   '02n' => CupertinoIcons.cloud_moon_fill,
   '03d' || '03n' || '04d' || '04n' => CupertinoIcons.cloud_fill,
   '09d' || '09n' => CupertinoIcons.cloud_drizzle_fill,
   '10d' => CupertinoIcons.cloud_sun_rain_fill,
   '10n' => CupertinoIcons.cloud_moon_rain_fill,
   '11d' || '11n' => CupertinoIcons.cloud_bolt_rain_fill,
   '13d' || '13n' => CupertinoIcons.snow,
   '50d' || '50n' => CupertinoIcons.cloud_fog_fill,
   _ => CupertinoIcons.cloud_sun,
 };
}
/// Picks background colours from the weather condition id.
///   2xx thunderstorm, 3xx drizzle, 5xx rain, 6xx snow,
///   7xx mist/fog, 800 clear, 80x clouds
List<Color> backgroundColors(WeatherData weather) {
 if (!weather.isDay) {
   return const [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)];
 }
 final int id = weather.conditionId;
 if (id < 300) return const [Color(0xFF232526), Color(0xFF414345)]; // storm
 if (id < 600) return const [Color(0xFF3A6073), Color(0xFF16222A)]; // rain
 if (id < 700) return const [Color(0xFF5C7A99), Color(0xFF8BA4BE)]; // snow
 if (id < 800) return const [Color(0xFF606C88), Color(0xFF3F4C6B)]; // fog
 if (id == 800) return const [Color(0xFF1E6FD9), Color(0xFF4FA3E8)]; // clear
 return const [Color(0xFF4B6584), Color(0xFF778CA3)]; // clouds
}

