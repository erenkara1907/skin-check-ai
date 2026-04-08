import 'dart:developer' as dev;
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

import '../widgets/share_options_sheet.dart';

part 'share_card_provider.g.dart';

/// Captures a RepaintBoundary widget as an image and shares it.
@riverpod
class ShareCardNotifier extends _$ShareCardNotifier {
  @override
  bool build() => false;

  /// Captures the widget behind [boundaryKey] and shares via [destination].
  Future<void> captureAndShare(
    GlobalKey boundaryKey,
    ShareDestination destination,
  ) async {
    state = true; // loading
    try {
      final boundary = boundaryKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) {
        dev.log('RepaintBoundary not found', name: 'ShareCard');
        state = false;
        return;
      }

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        dev.log('Failed to convert image to bytes', name: 'ShareCard');
        state = false;
        return;
      }

      final bytes = byteData.buffer.asUint8List();
      final dir = await getTemporaryDirectory();
      final file = File(
        '${dir.path}/skincheck_share_${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await file.writeAsBytes(bytes);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: _shareText(destination),
      );

      // Cleanup temp file
      if (file.existsSync()) {
        await file.delete();
      }
    } catch (e, st) {
      dev.log('Share failed: $e', name: 'ShareCard', stackTrace: st);
    } finally {
      state = false;
    }
  }

  String _shareText(ShareDestination destination) {
    return switch (destination) {
      ShareDestination.instagram => '',
      ShareDestination.whatsapp =>
        'SkinCheck AI ile cilt analizimi yaptim! 🔬',
      ShareDestination.other =>
        'SkinCheck AI ile cilt analizimi yaptim! 🔬',
    };
  }
}
