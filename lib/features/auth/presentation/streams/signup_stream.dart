import 'package:bloc_app/features/auth/presentation/validations/signup_validation.dart';
import 'package:rxdart/rxdart.dart';

class SignupStream extends SignUpValidation {
  // Create BehaviorSubjects
  final _name = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _passwordConfirm = BehaviorSubject<Map<String, String>>();

  // Create streams
  Stream<String> get nameS => _name.stream.transform(nameValidation);

  Stream<String> get emailS => _email.stream.transform(emailValidation);

  Stream<String> get passwordS =>
      _password.stream.transform(passwordValidation);

  Stream<String> get passwordConfirmS =>
      _passwordConfirm.stream.transform(passwordConfirmValidation);

  Stream<bool> get submitS =>
      Rx.combineLatest4(
          nameS, emailS, passwordS, passwordConfirmS, (a, b, c, d) => true);

  // Functions to add to streams
  Function(String) get nameChange => _name.sink.add;

  Function(String) get emailChange => _email.sink.add;

  Function(String) get passwordChange => _password.sink.add;

  Function(Map<String, String>) get passwordConfirmChange => _passwordConfirm.sink.add;

  void dispose(){
    _name.close();
    _email.close();
    _password.close();
    _passwordConfirm.close();
  }

}