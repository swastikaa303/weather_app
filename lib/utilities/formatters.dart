// Small helper functions that turn raw values into text for the UI.
// They are plain Dart (no Flutter), so they are easy to unit-test.
/// "light rain" -> "Light Rain". Safe for empty strings.
String capitalizeWords(String text) {
 return text
     .split(' ')
     .where((word) => word.isNotEmpty)
     .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
     .join(' ');
}
/// 17:05 -> "5:05 PM", 0:30 -> "12:30 AM".
String formatTime(DateTime time) {
 final int hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
 final String minute = time.minute.toString().padLeft(2, '0');
 final String period = time.hour < 12 ? 'AM' : 'PM';
 return '$hour:$minute $period';
}
const List<String> _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const List<String> _months = [
 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];
/// -> "Mon, 23 Nov"
String formatDate(DateTime date) {
 // DateTime.weekday is 1 (Monday) ... 7 (Sunday); month is 1 ... 12.
 return '${_weekdays[date.weekday - 1]}, ${date.day} ${_months[date.month - 1]}';
}
/// Wind degrees (0-360) -> compass point, e.g. 315 -> "NW".
String compassDirection(int degrees) {
 const List<String> points = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
 final int index = ((degrees % 360) / 45).round() % 8;
 return points[index];
}
