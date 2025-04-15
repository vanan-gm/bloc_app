import 'package:bloc_app/features/auth/presentation/validations/login_validation.dart';
import 'package:rxdart/rxdart.dart';

class LoginStream extends LoginValidation{
  // Create BehaviorSubjects
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // Streams
  Stream<String> get emailS => _email.stream.transform(emailValidation);
  Stream<String> get passwordS => _password.stream.transform(passwordValidation);
  Stream<bool> get submitS => Rx.combineLatest2(emailS, passwordS, (email, password) => email.isNotEmpty && password.isNotEmpty);

  // Functions to add to streams
  Function(String) get emailChange => _email.sink.add;
  Function(String) get passwordChange => _password.sink.add;

  void dispose(){
    _email.close();
    _password.close();
  }
}