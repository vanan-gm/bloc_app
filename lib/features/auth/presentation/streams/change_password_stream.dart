import 'package:bloc_app/features/auth/presentation/validations/signup_validation.dart';
import 'package:rxdart/rxdart.dart';

class ChangePasswordStream extends SignUpValidation {
  // Create BehaviorSubjects
  final _password = BehaviorSubject<String>();
  final _passwordConfirm = BehaviorSubject<Map<String, String>>();

  // Create streams

  Stream<String> get passwordS =>
      _password.stream.transform(passwordValidation);

  Stream<String> get passwordConfirmS =>
      _passwordConfirm.stream.transform(passwordConfirmValidation);

  Stream<bool> get submitS => Rx.combineLatest2(
    passwordS,
    passwordConfirmS,
    (pass, passCon) => pass.isNotEmpty && passCon.isNotEmpty,
  );

  // Functions to add to streams

  Function(String) get passwordChange => _password.sink.add;

  Function(Map<String, String>) get passwordConfirmChange =>
      _passwordConfirm.sink.add;

  void dispose() {
    _password.close();
    _passwordConfirm.close();
  }
}
