class DateTimeFunctions {
  String dateToString(DateTime date) {
    final String month = date.month < 10 ? '0${date.month}' : '${date.month}';
    final String day = date.day < 10 ? '0${date.day}' : '${date.day}';
    return '$day/$month/${date.year}';
  }

  String timeToString(DateTime date) {
    final String hour = date.hour < 10 ? '0${date.hour}' : '${date.hour}';
    final String minute =
        date.minute < 10 ? '0${date.minute}' : '${date.minute}';
    return '$hour:$minute';
  }
}
