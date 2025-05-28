import 'dart:async';

import 'package:bloc_app/core/common/extesions/localization_ext.dart';
import 'package:flutter/material.dart';

class CommonValidator {
  StreamTransformer<String, String> notEmptyAndOverSixCharsValidation({
    required BuildContext context,
  }) {
    return StreamTransformer<String, String>.fromHandlers(
      handleData: (str, sink) {
        if (str.isNotEmpty && str.trim().length >= 6) {
          sink.add(str);
        } else if (str.trim().isEmpty) {
          sink.addError(context.translate.fieldMustBeNonEmpty);
        } else if (str.trim().length < 6) {
          sink.addError(context.translate.fieldMustBeOver6Char);
        }
      },
    );
  }
}
