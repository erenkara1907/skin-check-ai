import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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
  messenger.showSnackBar(
    const SnackBar(content: Text('Veriler hazirlaniyor...')),
  );

  final actions = ref.read(profileActionsProvider.notifier);
  final data = await actions.exportData();

  if (data != null) {
    final json = const JsonEncoder.withIndent('  ').convert(data);
    await Share.share(json, subject: 'SkinCheck AI - Verilerim');
  } else {
    messenger.showSnackBar(
      const SnackBar(content: Text('Veriler disa aktarilamadi')),
    );
  }
}

/// Shows delete account confirmation and deletes if confirmed.
Future<void> deleteUserAccount(
  BuildContext context,
  WidgetRef ref,
) async {
  final confirmed = await DeleteAccountDialog.show(context);
  if (!confirmed) return;

  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Hesap siliniyor...')),
  );

  final actions = ref.read(profileActionsProvider.notifier);
  await actions.deleteAccount();
}

/// Opens a URL in the external browser.
Future<void> openExternalUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
