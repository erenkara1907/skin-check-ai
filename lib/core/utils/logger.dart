import 'package:logger/logger.dart' as pkg;

/// Application logger wrapper. Use this instead of print().
final log = AppLogger._instance;

class AppLogger {
  AppLogger._() : _logger = pkg.Logger(
    printer: pkg.PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
    ),
  );

  static final _instance = AppLogger._();
  final pkg.Logger _logger;

  /// Log debug message.
  void d(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.d(message, error: error, stackTrace: stackTrace);

  /// Log info message.
  void i(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.i(message, error: error, stackTrace: stackTrace);

  /// Log warning message.
  void w(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.w(message, error: error, stackTrace: stackTrace);

  /// Log error message.
  void e(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}
