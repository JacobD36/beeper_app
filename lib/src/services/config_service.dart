import 'dart:convert';
import 'package:beeper_app/src/global/environment.dart';
import 'package:beeper_app/src/models/campaign_model.dart';
import 'package:beeper_app/src/models/campus_model.dart';
import 'package:beeper_app/src/models/profile_model.dart';
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

  Future<List<Profile>> getProfiles(String search, String page) async {
    final url = Uri.http('${Environment.apiUrl}', '/getProfiles', {'search': search, 'page': page});

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer'+this._prefs.token
    };

    final resp = await http.get(url, headers: headers);

    if(resp.statusCode == 201) {
      String body = utf8.decode(resp.bodyBytes);
      final decodedData = json.decode(body);
      final List<Profile> profiles = [];

      if(decodedData == null) return [];

      for (var item in decodedData) {
        final profileTemp = Profile.fromJson(item);
        profileTemp.id = item['id'];
        profiles.add(profileTemp);
      }

      return profiles;
    } else {
      return [];
    }
  }

  Future<bool> saveProfile(Profile data) async {
    final url = Uri.http('${Environment.apiUrl}', '/newProfile');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer'+this._prefs.token,
    };

    final profileData = {
      'title': data.title,
      'status': 1
    };

    final resp = await http.post(url, headers: headers, body: json.encode(profileData));

    if(resp.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Campus>> getCampus(String search, String page) async {
    final url = Uri.http('${Environment.apiUrl}', '/getCampus', {'search': search, 'page': page});

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer'+this._prefs.token
    };

    final resp = await http.get(url, headers: headers);

    if(resp.statusCode == 201) {
      String body = utf8.decode(resp.bodyBytes);
      final decodedData = json.decode(body);
      final List<Campus> campus = [];

      if(decodedData == null) return [];

      for (var item in decodedData) {
        final campusTemp = Campus.fromJson(item);
        campusTemp.id = item['id'];
        campus.add(campusTemp);
      }

      return campus;
    } else {
      return [];
    }
  }
}