import 'package:beeper_app/src/bloc/campaign/new_campaign_validators.dart';
import 'package:rxdart/rxdart.dart';

class NewCampaignBloc with NewCampaignValidators{
  final _nameController = BehaviorSubject<String>();
  final _descController = BehaviorSubject<String>();
  final _responsableController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  bool isLoading = false;

  Stream<String> get nameStream => _nameController.stream.transform(validateName);
  Stream<String> get descStream => _descController.stream.transform(validateDesc);
  Stream<String> get responsableStream => _responsableController.stream.transform(validateResponsable);
  Stream<String> get phoneStream => _phoneController.stream.transform(validatePhone);

  Stream<bool> get formValidStream => Rx.combineLatest4(nameStream, descStream, responsableStream, phoneStream, (a, b, r, p) => true);

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeDesc => _descController.sink.add;
  Function(String) get changeResponsable => _responsableController.sink.add;
  Function(String) get changePhone => _phoneController.sink.add;

  String get name => _nameController.value;
  String get desc => _descController.value;
  String get resp => _responsableController.value;
  String get phone => _phoneController.value;

  dispose() {
    _nameController?.close();
    _descController?.close();
    _responsableController?.close();
    _phoneController?.close();
  }
}