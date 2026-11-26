import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/utilities/constants.dart';
/// Lets the user type a city name. The name is sent back to the previous
/// screen with Navigator.pop(context, cityName).
class CitySearchScreen extends StatefulWidget {
 const CitySearchScreen({super.key});
 @override
 State<CitySearchScreen> createState() => _CitySearchScreenState();
}
class _CitySearchScreenState extends State<CitySearchScreen> {
 final TextEditingController _controller = TextEditingController();
 @override
 void dispose() {
   _controller.dispose(); // controllers must be disposed to free memory
   super.dispose();
 }
 void _submit() {
   final String city = _controller.text.trim();
   if (city.isEmpty) return;
   Navigator.pop(context, city);
 }
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: const Text('Search city')),
     body: Padding(
       padding: const EdgeInsets.all(kScreenPadding),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: [
           TextField(
             controller: _controller,
             autofocus: true,
             textInputAction: TextInputAction.search,
             onSubmitted: (_) => _submit(),
             decoration: InputDecoration(
               hintText: 'e.g. Busan, Seoul, Hanoi',
               prefixIcon: const Icon(CupertinoIcons.search),
               filled: true,
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(kCardRadius),
                 borderSide: BorderSide.none,
               ),
             ),
           ),
           const SizedBox(height: kGap),
           FilledButton(
             onPressed: _submit,
             child: const Padding(
               padding: EdgeInsets.symmetric(vertical: 14.0),
               child: Text('Get weather', style: TextStyle(fontSize: 16.0)),
             ),
           ),
           const SizedBox(height: kGap),
           const Text(
             'Tip: add a country code to be precise, e.g. "Hanoi,VN".',
             style: kSubtitleTextStyle,
           ),
         ],
       ),
     ),
   );
 }
}

