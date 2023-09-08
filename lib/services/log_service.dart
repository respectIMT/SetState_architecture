import 'package:logger/logger.dart';

class LogService {
  static final Logger _logger = Logger(
    filter: DevelopmentFilter(),
    printer: PrettyPrinter(),
  );

  static void d(String message) {
    _logger.d(message);
  }

  static void i(String message) {
    _logger.d(message);
  }

  static void w(String message) {
    _logger.d(message);
  }

  static void e(String message) {
    _logger.d(message);
  }
}
