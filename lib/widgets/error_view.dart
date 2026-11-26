import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/utilities/constants.dart';
/// Shown instead of the weather when something goes wrong.
class ErrorView extends StatelessWidget {
 const ErrorView({
   super.key,
   required this.message,
   required this.onRetry,
   this.onSearch,
 });
 final String message;
 final VoidCallback onRetry; // VoidCallback = a function with no inputs and no output
 final VoidCallback? onSearch;
 @override
 Widget build(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.all(32.0),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         const Icon(CupertinoIcons.cloud_bolt, size: 80.0, color: kSecondaryTextColor),
         const SizedBox(height: 20.0),
         const Text(
           'Oops!',
           style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
         ),
         const SizedBox(height: 8.0),
         Text(message, textAlign: TextAlign.center, style: kSubtitleTextStyle),
         const SizedBox(height: 28.0),
         FilledButton.icon(
           onPressed: onRetry,
           icon: const Icon(CupertinoIcons.refresh),
           label: const Text('Try again'),
         ),
         if (onSearch != null) ...[
           const SizedBox(height: 12.0),
           TextButton.icon(
             onPressed: onSearch,
             icon: const Icon(CupertinoIcons.search),
             label: const Text('Search for a city'),
           ),
         ],
       ],
     ),
   );
 }
}


