import 'package:flutter/widgets.dart';

import '../../l10n/generated/app_localizations.dart';

/// Convenience extension to access [L10n] from [BuildContext].
extension L10nExtension on BuildContext {
  L10n get l10n => L10n.of(this);
}
