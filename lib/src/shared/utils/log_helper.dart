import 'package:logging/logging.dart';

class LogHelper {
  String _className;
  late Logger _logger;

  LogHelper({required String className}) : _className = className {
    _logger = Logger(this._className);
  }

  info(String message) {
    _logger.info(message);
    print("[twilio_flutter]: $message");
  }
}
