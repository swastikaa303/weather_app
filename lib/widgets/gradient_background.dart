import 'package:flutter/material.dart';
/// Fills the screen with a top-to-bottom gradient.
/// When [colors] change, the background fades smoothly to the new colours.
class GradientBackground extends StatelessWidget {
 const GradientBackground({super.key, required this.colors, required this.child});
 final List<Color> colors;
 final Widget child;
 @override
 Widget build(BuildContext context) {
   return AnimatedContainer(
     duration: const Duration(milliseconds: 800),
     decoration: BoxDecoration(
       gradient: LinearGradient(
         begin: Alignment.topCenter,
         end: Alignment.bottomCenter,
         colors: colors,
       ),
     ),
     child: child,
   );
 }
}
