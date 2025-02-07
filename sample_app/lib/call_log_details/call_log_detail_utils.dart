class CallLogDetailUtils {

  static String convertMinutesToHMS(double? minutes) {
    if (minutes == null) {
      return '';
    }
    // Convert total minutes to hours, remaining minutes, and seconds
    int totalSeconds = (minutes * 60).round();
    int hours = totalSeconds ~/ 3600; // Total hours
    int remainingMinutes = (totalSeconds % 3600) ~/ 60; // Remaining minutes
    int seconds = totalSeconds % 60; // Remaining seconds

    // Format the output string
    String formatted = '';
    if (hours > 0) {
      formatted += '${hours}hr ';
    }
    if (remainingMinutes > 0 || hours > 0) {
      formatted += '${remainingMinutes}m ';
    }
    formatted += '${seconds}s';

    return formatted.trim(); // Return the formatted string
  }
}