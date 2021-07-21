import 'package:beeper_app/src/models/profile_model.dart';
import 'package:beeper_app/src/services/config_service.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc {
  final _profileInfo = BehaviorSubject<List<Profile>>();
  final _configService = new ConfigService();

  Stream<List<Profile>> get profileInfoStream => _profileInfo.stream;

  void loadProfiles(String search, String page) async {
    final profiles = await _configService.getProfiles(search, page);
    _profileInfo.sink.add(profiles);
  }

  dispose() {
    _profileInfo?.close();
  }
}