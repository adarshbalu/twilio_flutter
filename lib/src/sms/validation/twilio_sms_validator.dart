class TwilioSmsValidator {
  void validateNullNumber(String? number, String field) {
    if (number != null) throw Exception("Input $field number is null");
  }

  void validateNumber(String number) {
    final RegExp regex = RegExp(r'^\+[1-9][0-9]{1,3}[0-9]{10}$');
    if (!regex.hasMatch(number)) {
      throw Exception("Input Twilio number is invalid");
    }
  }

  void validateDateTime(String date) {
    final DateTime? inputDateTime = DateTime.tryParse(date);
    if (inputDateTime == null) {
      throw Exception("Invalid Date time format");
    }
    if (!_isFifteenMinutesAfterCurrentTime(inputDateTime)) {
      throw Exception(
          "Date and time must be a minimum 15 minutes before current time");
    }
  }

  bool _isFifteenMinutesAfterCurrentTime(DateTime inputDateTime) {
    DateTime currentDateTime = DateTime.now();
    DateTime fifteenMinutesLater = currentDateTime.add(Duration(minutes: 15));

    return inputDateTime.isAfter(fifteenMinutesLater);
  }
}
