import 'dart:convert';
import 'package:beeper_app/src/global/environment.dart';
import 'package:beeper_app/src/models/campaign_model.dart';
import 'package:beeper_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class CampaignService {
  final _prefs = new PreferenciasUsuario();

  Future<bool> saveCampaign(Campaign data) async {
    final url = Uri.http('${Environment.apiUrl}', '/newCampaign');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer'+this._prefs.token,
    };

    final campData = {
      'title': data.title,
      'desc': data.desc,
      'status': 1,
      'responsable': data.responsable,
      'phone': data.phone
    };

    final resp = await http.post(url, headers: headers, body: json.encode(campData
    ));

    if(resp.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}