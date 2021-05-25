import 'package:rxdart/rxdart.dart';
import 'package:beeper_app/src/bloc/auth/auth_validators.dart';

class AuthBloc with AuthValidators{
  final _dniController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get dniStream => _dniController.stream.transform(validarDni);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream => Rx.combineLatest2(dniStream, passwordStream, (e, p) => true);

  Function(String) get changeDni => _dniController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  String get dni => _dniController.value;
  String get password => _passwordController.value;

  dispose() {
    _dniController?.close();
    _passwordController?.close();
  }
}