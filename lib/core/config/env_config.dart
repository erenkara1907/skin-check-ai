import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Type-safe access to environment variables.
///
/// Only exposes client-safe keys. Server-only secrets
/// (service role, OpenAI) must stay in Edge Functions.
abstract final class EnvConfig {
  /// Load the .env file. Call once before [runApp].
  static Future<void> load() => dotenv.load();

  // ── Supabase (client-safe) ──────────────────────

  static String get supabaseUrl =>
      dotenv.get('SUPABASE_URL');

  static String get supabaseAnonKey =>
      dotenv.get('SUPABASE_ANON_KEY');

  // ── Google Sign-In ─────────────────────────

  static String get googleClientIdIos =>
      dotenv.get('GOOGLE_CLIENT_ID_IOS', fallback: '');

  static String get googleWebClientId =>
      dotenv.get('GOOGLE_WEB_CLIENT_ID', fallback: '');

  // ── RevenueCat ─────────────────────────────

  static String get revenueCatApiKeyIos =>
      dotenv.get('REVENUECAT_API_KEY_IOS', fallback: '');

  static String get revenueCatApiKeyAndroid =>
      dotenv.get('REVENUECAT_API_KEY_ANDROID', fallback: '');
}
