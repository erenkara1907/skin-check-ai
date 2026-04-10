import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/config/env_config.dart';
import 'core/providers/theme_provider.dart';
import 'core/router/app_router.dart';
import 'core/services/revenuecat_service.dart';
import 'core/services/supabase_service.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  await EnvConfig.load();
  await SupabaseService.initialize(
    url: EnvConfig.supabaseUrl,
    anonKey: EnvConfig.supabaseAnonKey,
  );
  await RevenueCatService.initialize();

  runApp(const ProviderScope(child: SkinCheckApp()));
}

/// Root application widget.
class SkinCheckApp extends ConsumerWidget {
  const SkinCheckApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeNotifierProvider);

    return MaterialApp.router(
      title: 'SkinCheck AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
