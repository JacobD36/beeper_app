import 'package:rxdart/rxdart.dart';
import 'package:beeper_app/src/services/config_service.dart';
import 'package:beeper_app/src/models/campaign_model.dart';

class CampaignBloc {
  final _campaignInfo = BehaviorSubject<List<Campaign>>();
  final _configService = new ConfigService();

  Stream<List<Campaign>> get campaignInfoStream => _campaignInfo.stream;

  void loadCampaigns(String search, String page) async {
    final campaigns = await _configService.getCampaigns(search, page);
    _campaignInfo.sink.add(campaigns);
  }

  dispose() {
    _campaignInfo?.close();
  }
}

final campBloc = CampaignBloc();