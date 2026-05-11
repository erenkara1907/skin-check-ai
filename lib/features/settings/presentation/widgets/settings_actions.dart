import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/utils/logger.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import 'delete_account_dialog.dart';

/// Picks a time and updates the reminder provider.
Future<TimeOfDay?> pickReminderTime(
  BuildContext context,
  ({int hour, int minute}) current,
) async {
  return showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: current.hour, minute: current.minute),
  );
}

/// Exports all user data as JSON and shares it.
Future<void> exportUserData(BuildContext context, WidgetRef ref) async {
  final messenger = ScaffoldMessenger.of(context);
  final preparingMsg = context.l10n.preparingData;
  final failedMsg = context.l10n.dataExportFailed;
  messenger.showSnackBar(
    SnackBar(content: Text(preparingMsg)),
  );

  try {
    final actions = ref.read(profileActionsProvider.notifier);
    final data = await actions.exportData();

    if (data != null) {
      final json = const JsonEncoder.withIndent('  ').convert(data);
      await Share.share(json, subject: 'SkinCheck AI - Verilerim');
    } else {
      messenger.showSnackBar(
        SnackBar(content: Text(failedMsg)),
      );
    }
  } catch (e, st) {
    log.e('Export user data failed', e, st);
    messenger.showSnackBar(
      SnackBar(content: Text(failedMsg)),
    );
  }
}

/// Shows delete account confirmation and deletes if confirmed.
Future<void> deleteUserAccount(
  BuildContext context,
  WidgetRef ref,
) async {
  final deletingMsg = context.l10n.deletingAccount;
  final failedMsg = context.l10n.accountDeletionFailed;

  final confirmed = await DeleteAccountDialog.show(context);
  if (!confirmed) return;

  if (!context.mounted) return;
  final messenger = ScaffoldMessenger.of(context);
  messenger.showSnackBar(
    SnackBar(content: Text(deletingMsg)),
  );

  try {
    final actions = ref.read(profileActionsProvider.notifier);
    await actions.deleteAccount();
  } catch (e, st) {
    log.e('Delete account failed', e, st);
    messenger.showSnackBar(
      SnackBar(content: Text(failedMsg)),
    );
  }
}

/// Opens a URL in the external browser.
Future<void> openExternalUrl(String url) async {
  try {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  } catch (e, st) {
    log.e('Failed to open URL: $url', e, st);
  }
}
