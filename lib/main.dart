import 'package:flutter/material.dart';
import 'package:weather_app/screens/loading_screen.dart';
void main() {
 runApp(const WeatherApp());
}
/// The root of the app. It has no changing state, so a StatelessWidget is enough.
class WeatherApp extends StatelessWidget {
 const WeatherApp({super.key});
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Weather',
     debugShowCheckedModeBanner: false,
     theme: ThemeData(
       brightness: Brightness.dark,
       colorSchemeSeed: Colors.teal,
       useMaterial3: true,
     ),
     home: const LoadingScreen(),
   );
 }
}

