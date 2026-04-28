import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import 'core/config/env_config.dart';
import 'core/providers/theme_provider.dart';
import 'core/router/app_router.dart';
import 'core/services/notification_service.dart';
import 'core/services/revenuecat_service.dart';
import 'core/services/supabase_service.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  await initializeDateFormatting('tr');
  Intl.defaultLocale = 'tr';

  try {
    await EnvConfig.load();
    log.i('EnvConfig loaded');

    await SupabaseService.initialize(
      url: EnvConfig.supabaseUrl,
      anonKey: EnvConfig.supabaseAnonKey,
    );

    await RevenueCatService.initialize();
  } catch (e, st) {
    log.e('App initialization failed', e, st);
  }

  await NotificationService.instance.initialize(
    onTap: (response) {
      final ctx = AppRoutes.rootNavigatorKey.currentContext;
      if (ctx == null) return;
      switch (response.payload) {
        case 'routine':
          GoRouter.of(ctx).go(AppRoutes.routine);
        case 'weekly_analysis':
          GoRouter.of(ctx).go(AppRoutes.analyze);
      }
    },
  );

  runApp(const ProviderScope(child: SkinCheckApp()));
}

/// Root application widget.
class SkinCheckApp extends ConsumerWidget {
  const SkinCheckApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeNotifierProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp.router(
      title: 'SkinCheck AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
      localizationsDelegates: const [
        L10n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.supportedLocales,
      locale: const Locale('tr'),
      ),
    );
  }
}
