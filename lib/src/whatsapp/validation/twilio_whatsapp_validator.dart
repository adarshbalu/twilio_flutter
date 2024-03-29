import '../../shared/dto/twilio_creds.dart';

class TwilioWhatsAppValidator {
  void validateTwilio(TwilioCreds twilioCreds) {
    if (twilioCreds.messagingServiceSid == null ||
        twilioCreds.messagingServiceSid!.isEmpty) {
      throw Exception("Messaging Service SID is required for this operation");
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
