import 'package:beeper_app/src/bloc/profile/new_profile_validators.dart';
import 'package:rxdart/rxdart.dart';

class NewProfileBloc with NewProfileValidators{
  final _nameController = BehaviorSubject<String>();
  bool isLoading = false;

  Stream<String> get nameStream => _nameController.stream.transform(validateName);

  Function(String) get changeName => _nameController.sink.add;

  String get name => _nameController.value;

  dispose() {
    _nameController?.close();
  }
}