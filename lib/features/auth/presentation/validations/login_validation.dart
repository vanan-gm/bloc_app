import 'dart:async';

class LoginValidation{
  final emailValidation = StreamTransformer<String, String>.fromHandlers(handleData: (email, sink){
    RegExp regExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else if(email.isEmpty){
      sink.add('');
    }else {
      sink.addError('Invalid email');
    }
  });

  final passwordValidation = StreamTransformer<String, String>.fromHandlers(handleData: (password, sink){
    if(password.length >= 6 && password.isNotEmpty){
      sink.add(password);
    }else if(password.isEmpty){
      sink.add('');
    }else{
      sink.addError('Invalid password');
    }
  });
}