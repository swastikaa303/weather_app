import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:weather_app/utilities/constants.dart';
/// A small compass with an arrow that shows where the wind is blowing TO.
///
/// OpenWeather gives the direction the wind comes FROM (0° = from the north).
/// The arrow points the opposite way, so we add 180°.
class WindCompass extends StatelessWidget {
 const WindCompass({super.key, required this.degrees, this.size = 72.0});
 final int degrees;
 final double size;
 @override
 Widget build(BuildContext context) {
   // Transform.rotate needs radians: radians = degrees * pi / 180
   final double angle = (degrees + 180) * math.pi / 180;
   return SizedBox(
     width: size,
     height: size,
     child: Stack(
       alignment: Alignment.center,
       children: [
         // The ring
         Positioned.fill(
           child: DecoratedBox(
             decoration: BoxDecoration(
               shape: BoxShape.circle,
               border: Border.all(color: kSecondaryTextColor, width: 1.5),
             ),
           ),
         ),
         // N, E, S, W letters
         const Align(alignment: Alignment(0, -0.78), child: _Letter('N')),
         const Align(alignment: Alignment(0.78, 0), child: _Letter('E')),
         const Align(alignment: Alignment(0, 0.78), child: _Letter('S')),
         const Align(alignment: Alignment(-0.78, 0), child: _Letter('W')),
          // The arrow
         Transform.rotate(
           angle: angle,
           child: Icon(
             CupertinoIcons.location_north_fill,
             size: size * 0.38,
             color: kSunColor,
           ),
         ),
       ],
     ),
   );
 }
}
class _Letter extends StatelessWidget {
 const _Letter(this.text);
 final String text;
 @override
 Widget build(BuildContext context) {
   return Text(
     text,
     style: const TextStyle(
       fontSize: 10.0,
       fontWeight: FontWeight.bold,
       color: kSecondaryTextColor,
     ),
   );
 }
}
