import 'dart:convert';
import 'package:beeper_app/src/global/environment.dart';
import 'package:beeper_app/src/models/campaign_model.dart';
import 'package:beeper_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class ConfigService {
  final _prefs = new PreferenciasUsuario();
  
  Future<List<Campaign>> getCampaigns(String search, String page) async {
    final url = Uri.http('${Environment.apiUrl}', '/getCampaigns', {'search': search, 'page': page});

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer'+this._prefs.token
    };

    final resp = await http.get(url, headers: headers);

    if(resp.statusCode == 201) {
      String body = utf8.decode(resp.bodyBytes);
      final decodedData = json.decode(body);
      final List<Campaign> campaign = [];

      if(decodedData == null) return [];

      for (var item in decodedData) {
        final campTemp = Campaign.fromJson(item);
        campTemp.id = item['id'];
        campaign.add(campTemp);
      }

      return campaign;
    } else {
      return [];
    }
  }
}