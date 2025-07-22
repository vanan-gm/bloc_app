import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_app/core/common/validators/common_validator.dart';

class AddBlogStream extends CommonValidator {
  final _blogTitle = BehaviorSubject<String>();
  final _blogContent = BehaviorSubject<String>();
  late File? image;
  List<String> chosenTopics = [];

  Stream<String> blogTitleStreamS(BuildContext context) => _blogTitle.stream
      .transform(notEmptyAndOverSixCharsValidation(context: context));
  Stream<String> blogContentStreams(BuildContext context) => _blogContent.stream
      .transform(notEmptyAndOverSixCharsValidation(context: context));

  Function(String) get blogTitleChange => _blogTitle.sink.add;
  Function(String) get blogContentChange => _blogContent.sink.add;

  void dispose() {
    _blogTitle.close();
    _blogContent.close();
  }
}
