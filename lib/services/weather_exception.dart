/// An error with a friendly message we can show to the user.
class WeatherException implements Exception {
 const WeatherException(this.message);
 final String message;
 @override
 String toString() => message;
}
