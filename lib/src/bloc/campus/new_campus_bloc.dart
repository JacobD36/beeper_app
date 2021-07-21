import 'package:beeper_app/src/bloc/campaign/new_campaign_validators.dart';
import 'package:rxdart/rxdart.dart';

class NewCampusBloc with NewCampaignValidators {
  final _nameController = BehaviorSubject<String>();
  final _addressController = BehaviorSubject<String>();
  bool isLoading = false;

  Stream<String> get nameStream => _nameController.stream;
  Stream<String> get addressStream => _addressController.stream;

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeAddress => _addressController.sink.add;

  String get name => _nameController.value;
  String get address => _addressController.value;

  dispose() {
    _nameController?.close();
    _addressController?.close();
  }
}