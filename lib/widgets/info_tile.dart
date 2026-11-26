import 'package:flutter/material.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/widgets/glass_card.dart';
/// A small card: icon + LABEL on top, a big value, and an optional caption.
///
///   🌡 FEELS LIKE
///   18°
///   Wind makes it feel colder
class InfoTile extends StatelessWidget {
 const InfoTile({
   super.key,
   required this.icon,
   required this.label,
   required this.value,
   this.caption,
   this.trailing,
 });
 final IconData icon;
 final String label;
 final String value;
 final String? caption; // optional
 final Widget? trailing; // optional extra widget, e.g. a compass
 @override
 Widget build(BuildContext context) {
   return GlassCard(
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Row(
           children: [
             Icon(icon, size: 16.0, color: kSecondaryTextColor),
             const SizedBox(width: 6.0),
             Text(label.toUpperCase(), style: kCardLabelStyle),
           ],
         ),
         const SizedBox(height: 12.0),
          // FittedBox shrinks long values so they never overflow on small phones.
         FittedBox(
           fit: BoxFit.scaleDown,
           alignment: Alignment.centerLeft,
           child: Text(value, style: kCardValueStyle),
         ),
         if (caption != null) ...[
           const SizedBox(height: 4.0),
           Text(caption!, style: kSubtitleTextStyle.copyWith(fontSize: 13.0)),
         ],
         if (trailing != null) ...[
           const SizedBox(height: 8.0),
           Center(child: trailing!),
         ],
       ],
     ),
   );
 }
}

