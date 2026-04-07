import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/logger.dart';

/// Supabase client initialization and access.
class SupabaseService {
  SupabaseService._();

  static SupabaseClient get client => Supabase.instance.client;

  /// Initialize Supabase. Call once in main() before runApp.
  static Future<void> initialize({
    required String url,
    required String anonKey,
  }) async {
    log.i('Initializing Supabase...');
    await Supabase.initialize(url: url, anonKey: anonKey);
    log.i('Supabase initialized');
  }
}
