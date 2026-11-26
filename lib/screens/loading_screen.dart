import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/screens/city_search_screen.dart';
import 'package:weather_app/screens/weather_screen.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/weather_exception.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/widgets/error_view.dart';
import 'package:weather_app/widgets/gradient_background.dart';
/// The first screen. It finds the location, downloads the weather,
/// and then replaces itself with the WeatherScreen.
class LoadingScreen extends StatefulWidget {
 const LoadingScreen({super.key});
 @override
 State<LoadingScreen> createState() => _LoadingScreenState();
}
class _LoadingScreenState extends State<LoadingScreen> {
 final LocationService _locationService = LocationService();
 final WeatherService _weatherService = WeatherService();
 String? _errorMessage; // null = no error, still loading
 @override
 void initState() {
   super.initState();
   _loadWeather(); // initState cannot be async, so we call an async method
 }
 Future<void> _loadWeather({String? city}) async {
   try {
     final WeatherData weather;
     if (city == null) {
       final position = await _locationService.getCurrentPosition();
       weather = await _weatherService.getWeatherByLocation(
         position.latitude,
         position.longitude,
       );
     } else {
       weather = await _weatherService.getWeatherByCity(city);
     }
     // The user may have left the screen while we were waiting.
     if (!mounted) return;
     // pushReplacement: the Back button will NOT return to this loading screen.
     Navigator.pushReplacement(
       context,
       MaterialPageRoute(
         builder: (context) => WeatherScreen(weather: weather, city: city),
       ),
     );
   } on WeatherException catch (e) {
     if (!mounted) return;
     setState(() => _errorMessage = e.message);
   } catch (e) {
     if (!mounted) return;
     setState(() => _errorMessage = 'Something went wrong: $e');
   }
 }
 void _retry() {
   setState(() => _errorMessage = null);
   _loadWeather();
 }
 Future<void> _searchCity() async {
   final String? city = await Navigator.push<String>(
     context,
     MaterialPageRoute(builder: (context) => const CitySearchScreen()),
   );
   if (city == null) return; // user pressed Back
   setState(() => _errorMessage = null);
   _loadWeather(city: city);
 }
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     body: GradientBackground(
       colors: const [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
       child: SafeArea(
         child: Center(
           child: _errorMessage == null
               ? const Column(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     SpinKitDoubleBounce(color: Colors.tealAccent, size: 100.0),
                     SizedBox(height: 24.0),
                     Text('Getting the weather...', style: kSubtitleTextStyle),
                   ],
                 )
               : ErrorView(
                   message: _errorMessage!,
                   onRetry: _retry,
                   onSearch: _searchCity,
                 ),
         ),
       ),
     ),
   );
 }
}

