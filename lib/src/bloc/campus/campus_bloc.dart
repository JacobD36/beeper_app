import 'package:beeper_app/src/models/campus_model.dart';
import 'package:beeper_app/src/services/config_service.dart';
import 'package:rxdart/rxdart.dart';

class CampusBloc {
  final _campusInfo = BehaviorSubject<List<Campus>>();
  final _configService = new ConfigService();

  Stream<List<Campus>> get campusInfoStream => _campusInfo.stream;

  void loadCampus(String search, String page) async {
    final campus = await _configService.getCampus(search, page);
    _campusInfo.sink.add(campus);
  }

  dispose() {
    _campusInfo?.close();
  }
}