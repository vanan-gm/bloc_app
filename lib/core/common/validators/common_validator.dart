import 'dart:async';

class CommonValidator{

  final notEmptyAndOverSixCharsValidation = StreamTransformer<String, String>.fromHandlers(handleData: (str, sink){
    if(str.isNotEmpty && str.trim().length >= 6){
      sink.add(str);
    }else if(str.trim().isEmpty){
      sink.addError('Field must be non-empty');
    }else if(str.trim().length < 6){
      sink.addError('Field must be over 6 characters');
    }
  });
}