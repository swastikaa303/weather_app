import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/utilities/formatters.dart';
import 'package:weather_app/widgets/glass_card.dart';


/// Sunrise | Sunset, side by side.
class SunTimesCard extends StatelessWidget {
 const SunTimesCard({super.key, required this.sunrise, required this.sunset});
 /// Both times must already be converted to the city's local time.
 final DateTime sunrise;
 final DateTime sunset;
 @override
 Widget build(BuildContext context) {
   return GlassCard(
     child: Row(
       children: [
         Expanded(
           child: _SunTime(
             icon: CupertinoIcons.sunrise_fill,
             label: 'Sunrise',
             time: sunrise,
           ),
         ),
         Container(width: 1.0, height: 56.0, color: const Color(0x33FFFFFF)),
         Expanded(
           child: _SunTime(
             icon: CupertinoIcons.sunset_fill,
             label: 'Sunset',
             time: sunset,
           ),
         ),
       ],
     ),
   );
 }
}
class _SunTime extends StatelessWidget {
 const _SunTime({required this.icon, required this.label, required this.time});
 final IconData icon;
 final String label;
 final DateTime time;
 @override
 Widget build(BuildContext context) {
   return Column(
     children: [
       Icon(icon, color: kSunColor, size: 30.0),
       const SizedBox(height: 6.0),
       Text(label.toUpperCase(), style: kCardLabelStyle),
       const SizedBox(height: 2.0),
       Text(
         formatTime(time),
         style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
       ),
     ],
   );
 }
}