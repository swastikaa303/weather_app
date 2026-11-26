import 'package:flutter/material.dart';

// Shared styles, just like `data.dart` in the BMI Calculator project.

const Color kCardColor = Color(0x26FFFFFF); // white at 15% opacity ("glass")
const Color kSecondaryTextColor = Color(0xB3FFFFFF); // white at 70% opacity
const Color kSunColor = Color(0xFFFFD54F);
const double kCardRadius = 20.0;
const double kScreenPadding = 20.0;
const double kGap = 16.0;

const TextStyle kCityTextStyle = TextStyle(
  fontSize: 26.0,
  fontWeight: FontWeight.bold,
);

const TextStyle kTemperatureTextStyle = TextStyle(
  fontSize: 96.0,
  fontWeight: FontWeight.w200,
  height: 1.0,
);

const TextStyle kDescriptionTextStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.w500,
);

const TextStyle kSubtitleTextStyle = TextStyle(
  fontSize: 16.0,
  color: kSecondaryTextColor,
);

const TextStyle kCardLabelStyle = TextStyle(
  fontSize: 13.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 1.0,
  color: kSecondaryTextColor,
);

const TextStyle kCardValueStyle = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.w500,
);
