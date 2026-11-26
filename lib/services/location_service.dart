import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/weather_exception.dart';
/// Finds where the phone is.
class LocationService {
 /// Returns the current position, or throws a [WeatherException]
 /// with a message that explains what the user should do.
 Future<Position> getCurrentPosition() async {
   // 1. Is GPS / location turned on?
   final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
   if (!serviceEnabled) {
     throw const WeatherException(
       'Location is turned off. Please turn on location and try again.',
     );
   }
   // 2. Has the user allowed this app to use location?
   LocationPermission permission = await Geolocator.checkPermission();
   if (permission == LocationPermission.denied) {
     permission = await Geolocator.requestPermission();
   }
   if (permission == LocationPermission.denied) {
     throw const WeatherException(
       'Location permission was denied. Allow it to see your local weather, '
       'or search for a city instead.',
     );
   }
   if (permission == LocationPermission.deniedForever) {
     throw const WeatherException(
       'Location permission is blocked. Enable it in your phone Settings, '
       'or search for a city instead.',
     );
   }
   // 3. Get the position. Low accuracy is enough for weather and is faster.
   try {
     return await Geolocator.getCurrentPosition(
       locationSettings: const LocationSettings(
         accuracy: LocationAccuracy.low,
         timeLimit: Duration(seconds: 15),
       ),
     );
   } on TimeoutException {
     throw const WeatherException(
       'Could not find your location in time. Please try again.',
     );
   }
 }
}
