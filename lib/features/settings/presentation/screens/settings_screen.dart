import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/providers/theme_provider.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/gradient_background.dart';
import '../../../subscription/presentation/providers/subscription_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/settings_actions.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';
import '../widgets/subscription_card.dart';
import '../widgets/theme_selector.dart';

const _privacyUrl = 'https://skincheck.ai/privacy';
const _termsUrl = 'https://skincheck.ai/terms';

/// Settings screen with theme, notifications, subscription, and account.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isPro = ref.watch(isProProvider);
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ayarlar',
          style: AppTextStyles.headlineSmall.copyWith(color: textColor),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 8),
            // Subscription
            if (!isPro) UpgradeCard(isDark: isDark),
            if (!isPro) const SizedBox(height: 20),
            if (isPro) ProStatusCard(isDark: isDark, textColor: textColor),
            if (isPro) const SizedBox(height: 20),

            // Theme
            _buildThemeSection(ref),
            const SizedBox(height: 20),

            // Notifications
            _buildNotificationSection(context, ref),
            const SizedBox(height: 20),

            // Subscription management
            _buildSubscriptionSection(context, ref, isPro),
            const SizedBox(height: 20),

            // Account (GDPR)
            _buildAccountSection(context, ref),
            const SizedBox(height: 20),

            // About
            _buildAboutSection(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSection(WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);
    return SettingsSection(
      title: 'Tema',
      children: [
        ThemeSelector(
          currentMode: themeMode,
          onChanged: (mode) {
            ref.read(themeModeNotifierProvider.notifier).setThemeMode(mode);
          },
        ),
      ],
    );
  }

  Widget _buildNotificationSection(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(notificationEnabledProvider);
    final time = ref.watch(reminderTimeProvider);

    return SettingsSection(
      title: 'Bildirimler',
      children: [
        SettingsTile(
          icon: LucideIcons.bell,
          label: 'Rutin Hatirlatma',
          trailing: Switch.adaptive(
            value: enabled,
            activeTrackColor: AppColors.primary,
            onChanged: (v) {
              ref.read(notificationEnabledProvider.notifier).toggle(v);
            },
          ),
          showDivider: enabled,
        ),
        if (enabled)
          SettingsTile(
            icon: LucideIcons.clock,
            label: 'Hatirlatma Saati',
            value: '${time.hour.toString().padLeft(2, '0')}:'
                '${time.minute.toString().padLeft(2, '0')}',
            showDivider: false,
            onTap: () => _pickTime(context, ref, time),
          ),
      ],
    );
  }

  Widget _buildSubscriptionSection(
    BuildContext context,
    WidgetRef ref,
    bool isPro,
  ) {
    return SettingsSection(
      title: 'Abonelik',
      children: [
        SettingsTile(
          icon: LucideIcons.crown,
          label: 'Mevcut Plan',
          value: isPro ? 'Pro' : 'Ucretsiz',
          showDivider: true,
        ),
        SettingsTile(
          icon: LucideIcons.creditCard,
          label: 'Aboneligi Yonet',
          showDivider: false,
          onTap: () => context.push(AppRoutes.paywall),
        ),
      ],
    );
  }

  Widget _buildAccountSection(BuildContext context, WidgetRef ref) {
    return SettingsSection(
      title: 'Hesap',
      children: [
        SettingsTile(
          icon: LucideIcons.download,
          label: 'Verilerimi Disa Aktar',
          showDivider: true,
          onTap: () => exportUserData(context, ref),
        ),
        SettingsTile(
          icon: LucideIcons.trash2,
          label: 'Hesabimi Sil',
          iconColor: AppColors.error,
          textColor: AppColors.error,
          showDivider: false,
          onTap: () => deleteUserAccount(context, ref),
        ),
      ],
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return SettingsSection(
      title: 'Hakkinda',
      children: [
        FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (context, snap) {
            final version = snap.hasData
                ? '${snap.data!.version} (${snap.data!.buildNumber})'
                : '...';
            return SettingsTile(
              icon: LucideIcons.info,
              label: 'Versiyon',
              value: version,
              showDivider: true,
            );
          },
        ),
        SettingsTile(
          icon: LucideIcons.shield,
          label: 'Gizlilik Politikasi',
          showDivider: true,
          onTap: () => openExternalUrl(_privacyUrl),
        ),
        SettingsTile(
          icon: LucideIcons.fileText,
          label: 'Kullanim Kosullari',
          showDivider: true,
          onTap: () => openExternalUrl(_termsUrl),
        ),
        SettingsTile(
          icon: LucideIcons.scale,
          label: 'Lisanslar',
          showDivider: false,
          onTap: () => showLicensePage(
            context: context,
            applicationName: 'SkinCheck AI',
          ),
        ),
      ],
    );
  }

  // --- Actions ---

  Future<void> _pickTime(
    BuildContext context,
    WidgetRef ref,
    ({int hour, int minute}) current,
  ) async {
    final picked = await pickReminderTime(context, current);
    if (picked != null) {
      ref
          .read(reminderTimeProvider.notifier)
          .setTime(picked.hour, picked.minute);
    }
  }
}
