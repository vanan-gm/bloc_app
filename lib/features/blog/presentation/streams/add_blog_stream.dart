import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_app/core/common/validators/common_validator.dart';

class AddBlogStream extends CommonValidator{
  final _blogTitle = BehaviorSubject<String>();
  final _blogContent = BehaviorSubject<String>();
  late File? image;
  List<String> chosenTopics = [];

  Stream<String> get blogTitleStreamS => _blogTitle.stream.transform(notEmptyAndOverSixCharsValidation);
  Stream<String> get blogContentStreams => _blogContent.stream.transform(notEmptyAndOverSixCharsValidation);

  Function(String) get blogTitleChange => _blogTitle.sink.add;
  Function(String) get blogContentChange => _blogContent.sink.add;

  void dispose(){
    _blogTitle.close();
    _blogContent.close();
  }
}