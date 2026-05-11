import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
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

  void _emit(String level, String message, [dynamic error, StackTrace? st]) {
    // dart:developer log — always visible in flutter run console
    dev.log(
      '[$level] $message${error != null ? '\n$error' : ''}',
      name: 'SkinCheck',
      error: error,
      stackTrace: st,
    );
    // Also print in debug mode as fallback
    if (kDebugMode) {
      debugPrint('[$level] $message${error != null ? ' | $error' : ''}');
    }
  }

  /// Log debug message.
  void d(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
    _emit('D', message, error, stackTrace);
  }

  /// Log info message.
  void i(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
    _emit('I', message, error, stackTrace);
  }

  /// Log warning message.
  void w(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
    _emit('W', message, error, stackTrace);
  }

  /// Log error message.
  void e(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
    _emit('E', message, error, stackTrace);
  }
}
