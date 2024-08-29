class DateTimeFunctions {
  String dateToString(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String timeToString(DateTime date) {
    return '${date.hour}:${date.minute}';
  }
}
