import 'dart:async';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'logger.dart';

/// Run [action] up to [maxAttempts] times with exponential backoff.
///
/// Retries only when [retryIf] returns true (or when omitted — any error).
/// Backoff: [initialDelay] doubles (via [multiplier]) between attempts.
/// With defaults (3 attempts, 1s initial, 2x): 1s then 2s between attempts.
///
/// [opName] is only used for log context.
Future<T> retryWithBackoff<T>(
  Future<T> Function() action, {
  int maxAttempts = 3,
  Duration initialDelay = const Duration(seconds: 1),
  double multiplier = 2.0,
  bool Function(Object error)? retryIf,
  String? opName,
}) async {
  assert(maxAttempts >= 1);
  var delay = initialDelay;

  for (var attempt = 1; attempt <= maxAttempts; attempt++) {
    try {
      return await action();
    } catch (e) {
      final isLast = attempt == maxAttempts;
      final shouldRetry = retryIf?.call(e) ?? true;
      if (isLast || !shouldRetry) rethrow;

      log.w(
        '[${opName ?? 'retry'}] attempt $attempt/$maxAttempts failed; '
        'retrying after $delay — $e',
      );
      await Future<void>.delayed(delay);
      delay *= multiplier;
    }
  }

  // Unreachable — the loop either returns or rethrows.
  throw StateError('retryWithBackoff: exhausted without outcome');
}

/// True for errors that are plausibly transient at the Supabase edge /
/// network layer. Used by [retryWithBackoff] to decide whether to retry.
bool isTransientEdgeError(Object e) {
  if (e is FunctionException) {
    final s = e.status;
    return s == 503 || s == 504 || s == 408 || s == 429;
  }
  if (e is SocketException || e is TimeoutException || e is HttpException) {
    return true;
  }
  final msg = e.toString();
  return msg.contains('SUPABASE_EDGE_RUNTIME_ERROR') ||
      msg.contains('temporarily unavailable') ||
      msg.contains('Service Unavailable');
}
