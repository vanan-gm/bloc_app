import 'dart:async';

class SignUpValidation{
  final nameValidation = StreamTransformer<String, String>.fromHandlers(handleData: (name, sink){
    if(name.isNotEmpty && name.length >= 3){
      sink.add(name);
    }else{
      sink.addError('Invalid name');
    }
  });

  final emailValidation = StreamTransformer<String, String>.fromHandlers(handleData: (email, sink){
    RegExp regExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Invalid email');
    }
  });

  final passwordValidation = StreamTransformer<String, String>.fromHandlers(handleData: (password, sink){
      if(password.isNotEmpty && password.length >= 6){
        sink.add(password);
      }else{
        sink.addError('Invalid password');
      }
  });

  final passwordConfirmValidation = StreamTransformer<Map<String, String>, String>.fromHandlers(handleData: (data, sink){
    final password = data["password"];
    final passwordConfirm = data["password_confirm"];
    if(passwordConfirm!.isEmpty && passwordConfirm.length < 6){
      sink.addError('Invalid password confirm');
    }else if(passwordConfirm.compareTo(password!) != 0){
      sink.addError('Password confirm does not match');
    }else{
      sink.add(passwordConfirm);
    }
  });
}