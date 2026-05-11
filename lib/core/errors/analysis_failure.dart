import 'dart:async';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../l10n/generated/app_localizations.dart';

/// Typed failure for the skin analysis pipeline.
///
/// The datasource wraps any raw exception (FunctionException, network
/// errors, parse errors, ...) into one of these variants so the UI layer
/// can show a localized, user-friendly message without inspecting stack
/// traces or status codes.
sealed class AnalysisFailure implements Exception {
  const AnalysisFailure([this.cause]);

  /// The underlying error that triggered this failure (for logs/debug only).
  final Object? cause;

  /// Classify any exception into an [AnalysisFailure] subtype.
  factory AnalysisFailure.fromException(Object e) {
    if (e is AnalysisFailure) return e;

    if (e is FunctionException) {
      final s = e.status;
      if (s == 429) return QuotaAnalysisFailure(e);
      if (s == 503 || s == 504 || s == 408) {
        return TransientAnalysisFailure(e);
      }
      return UnknownAnalysisFailure(e);
    }

    if (e is SocketException ||
        e is TimeoutException ||
        e is HttpException) {
      return NetworkAnalysisFailure(e);
    }

    final msg = e.toString();
    if (msg.contains('SUPABASE_EDGE_RUNTIME_ERROR') ||
        msg.contains('temporarily unavailable') ||
        msg.contains('Service Unavailable')) {
      return TransientAnalysisFailure(e);
    }

    return UnknownAnalysisFailure(e);
  }

  @override
  String toString() => '$runtimeType(cause: $cause)';
}

/// 503/504/408 or other clearly-retryable platform hiccups.
class TransientAnalysisFailure extends AnalysisFailure {
  const TransientAnalysisFailure([super.cause]);
}

/// No connectivity or low-level network error.
class NetworkAnalysisFailure extends AnalysisFailure {
  const NetworkAnalysisFailure([super.cause]);
}

/// 429 — user or service quota exceeded.
class QuotaAnalysisFailure extends AnalysisFailure {
  const QuotaAnalysisFailure([super.cause]);
}

/// Fallback — unexpected error we couldn't classify.
class UnknownAnalysisFailure extends AnalysisFailure {
  const UnknownAnalysisFailure([super.cause]);
}

/// Map an [AnalysisFailure] to a localized user-facing message.
extension AnalysisFailureMessage on AnalysisFailure {
  String userMessage(L10n l10n) => switch (this) {
        TransientAnalysisFailure() => l10n.analysisErrorTransient,
        NetworkAnalysisFailure() => l10n.analysisErrorNetwork,
        QuotaAnalysisFailure() => l10n.analysisErrorQuota,
        UnknownAnalysisFailure() => l10n.analysisErrorUnknown,
      };
}
