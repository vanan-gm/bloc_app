import 'package:bloc_app/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

extension L10nExtension on BuildContext {
  AppLocalizations get translate => AppLocalizations.of(this)!;
}
