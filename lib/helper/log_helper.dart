import 'package:logger/logger.dart';

class LogHelper {
  LogHelper._();

  static final _logger = Logger(
    printer: PrettyPrinter(
      printEmojis: false,
    ),
  );

  static void log([dynamic message]) {
    _logger.d(message);
  }
}