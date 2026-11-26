import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/utilities/formatters.dart';
/// The top of the screen: city, date, big icon, temperature, description, H/L.
class CurrentWeatherHeader extends StatelessWidget {
 const CurrentWeatherHeader({super.key, required this.weather});
 final WeatherData weather;
 @override
 Widget build(BuildContext context) {
   final String place = weather.country.isEmpty
       ? weather.city
       : '${weather.city}, ${weather.country}';
   final DateTime cityNow = weather.toCityTime(DateTime.now().toUtc());
   return Column(
     children: [
       Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           const Icon(CupertinoIcons.location_solid, size: 20.0),
           const SizedBox(width: 6.0),
           Flexible(
             child: Text(
               place,
               style: kCityTextStyle,
               overflow: TextOverflow.ellipsis,
             ),
           ),
         ],
       ),
       const SizedBox(height: 4.0),
       Text(
         'formatDate(cityNow) ·  {formatTime(cityNow)}',
         style: kSubtitleTextStyle,
       ),
       const SizedBox(height: 24.0),
       Icon(
         CupertinoIcons.cloud_sun_fill, // Step 6 picks the icon from weather.iconCode
         size: 110.0,
         color: weather.isDay ? kSunColor : Colors.white,
       ),
       const SizedBox(height: 8.0),
       Text('${weather.temperature.round()}°', style: kTemperatureTextStyle),
       const SizedBox(height: 4.0),
       Text(capitalizeWords(weather.description), style: kDescriptionTextStyle),
       const SizedBox(height: 6.0),
       Text(
         'H: ${weather.tempMax.round()}°    L: ${weather.tempMin.round()}°',
         style: kSubtitleTextStyle.copyWith(fontSize: 18.0),
       ),
     ],
   );
 }
}



