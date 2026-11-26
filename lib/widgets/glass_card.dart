import 'package:flutter/material.dart';
import 'package:weather_app/utilities/constants.dart';
/// A rounded, see-through card. Same idea as Container in the BMI Calculator.
class GlassCard extends StatelessWidget {
 const GlassCard({super.key, required this.child});
 final Widget child;
 @override
 Widget build(BuildContext context) {
   return Container(
     padding: const EdgeInsets.all(16.0),
     decoration: BoxDecoration(
       color: kCardColor,
       borderRadius: BorderRadius.circular(kCardRadius),
       border: Border.all(color: const Color(0x33FFFFFF)),
     ),
     child: child,
   );
 }
}
