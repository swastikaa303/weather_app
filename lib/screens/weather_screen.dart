import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/screens/city_search_screen.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/weather_exception.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/utilities/formatters.dart';
import 'package:weather_app/utilities/weather_visuals.dart';
import 'package:weather_app/widgets/current_weather_header.dart';
import 'package:weather_app/widgets/gradient_background.dart';
import 'package:weather_app/widgets/info_tile.dart';
import 'package:weather_app/widgets/sun_times_card.dart';
import 'package:weather_app/widgets/wind_compass.dart';
class WeatherScreen extends StatefulWidget {
 const WeatherScreen({super.key, required this.weather, this.city});
 /// The first weather data, downloaded by the LoadingScreen.
 final WeatherData weather;
 /// The searched city, or null when we use the GPS location.
 final String? city;
 @override
 State<WeatherScreen> createState() => _WeatherScreenState();
}
class _WeatherScreenState extends State<WeatherScreen> {
 final LocationService _locationService = LocationService();
 final WeatherService _weatherService = WeatherService();
 late WeatherData _weather; // what is on screen now
 String? _city; // null = "my location"
 bool _isLoading = false;
 @override
 void initState() {
   super.initState();
   _weather = widget.weather;
   _city = widget.city;
 }
 /// Downloads new weather. city == null means "use my GPS location".
 Future<void> _loadWeather(String? city) async {
   setState(() => _isLoading = true);
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
     if (!mounted) return;
     setState(() {
       _weather = weather;
       _city = city;
     });
   } on WeatherException catch (e) {
     if (!mounted) return;
     // Keep the old weather on screen and show a short message.
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
   } finally {
     if (mounted) setState(() => _isLoading = false);
   }
 }
 Future<void> _openSearch() async {
   final String? city = await Navigator.push<String>(
     context,
     MaterialPageRoute(builder: (context) => const CitySearchScreen()),
   );
   if (city != null) await _loadWeather(city);
 }
 @override
 Widget build(BuildContext context) {
   final WeatherData w = _weather; // short name for the code below
   return Scaffold(
     extendBodyBehindAppBar: true,
     appBar: AppBar(
       backgroundColor: Colors.transparent,
       scrolledUnderElevation: 0, // stay transparent while scrolling
       leading: IconButton(
         tooltip: 'My location',
         icon: const Icon(CupertinoIcons.location_fill),
         onPressed: _isLoading ? null : () => _loadWeather(null),
       ),
       actions: [
         IconButton(
           tooltip: 'Search city',
           icon: const Icon(CupertinoIcons.search),
           onPressed: _isLoading ? null : _openSearch,
         ),
       ],
       bottom: _isLoading
           ? const PreferredSize(
               preferredSize: Size.fromHeight(2.0),
               child: LinearProgressIndicator(minHeight: 2.0),
             )
           : null,
     ),
     body: GradientBackground(
       colors: backgroundColors(w),
       child: SafeArea(
         child: RefreshIndicator(
           onRefresh: () => _loadWeather(_city), // pull down to refresh
           child: ListView(
             // AlwaysScrollable so pull-to-refresh works even if the content is short
             physics: const AlwaysScrollableScrollPhysics(),
             padding: const EdgeInsets.all(kScreenPadding),
             children: [
               CurrentWeatherHeader(weather: w),
               const SizedBox(height: 32.0),
               SunTimesCard(
                 sunrise: w.toCityTime(w.sunrise),
                 sunset: w.toCityTime(w.sunset),
               ),
               const SizedBox(height: kGap),
               _TileRow(
                 left: InfoTile(
                   icon: CupertinoIcons.thermometer,
                   label: 'Feels like',
                   value: '${w.feelsLike.round()}°',
                   caption: w.feelsLike < w.temperature
                       ? 'Colder than it looks'
                       : 'Similar to actual',
                 ),
                 right: InfoTile(
                   icon: CupertinoIcons.drop_fill,
                   label: 'Humidity',
                   value: '${w.humidity}%',
                   caption: w.humidity > 70 ? 'Quite humid' : 'Comfortable',
                 ),
               ),
               const SizedBox(height: kGap),
               _TileRow(
                 left: InfoTile(
                   icon: CupertinoIcons.wind,
                   label: 'Wind',
                   value: '${w.windSpeed.toStringAsFixed(1)} m/s',
                   caption: 'From ${compassDirection(w.windDeg)}',
                   trailing: WindCompass(degrees: w.windDeg),
                 ),
                 right: InfoTile(
                   icon: CupertinoIcons.gauge,
                   label: 'Pressure',
                   value: '${w.pressure} hPa',
                   caption: 'Visibility ${(w.visibility / 1000).toStringAsFixed(1)} km',
                 ),
               ),
               const SizedBox(height: 24.0),
               Text(
                 'Updated ${formatTime(w.toCityTime(w.updatedAt))} local time  ·  Pull down to refresh',
                 textAlign: TextAlign.center,
                 style: kSubtitleTextStyle.copyWith(fontSize: 12.0),
               ),
             ],
           ),
         ),
       ),
     ),
   );
 }
}
/// Two tiles side by side with the same height.
class _TileRow extends StatelessWidget {
 const _TileRow({required this.left, required this.right});
 final Widget left;
 final Widget right;
 @override
 Widget build(BuildContext context) {
   return IntrinsicHeight(
     child: Row(
       crossAxisAlignment: CrossAxisAlignment.stretch,
       children: [
         Expanded(child: left),
         const SizedBox(width: kGap),
         Expanded(child: right),
       ],
     ),
   );
 }
}






