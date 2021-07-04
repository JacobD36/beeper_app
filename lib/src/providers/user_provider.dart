import 'dart:convert';
import 'package:beeper_app/src/global/environment.dart';
import 'package:beeper_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  Future<Map<String, dynamic>> login(String dni, String password) async {
    final url = Uri.http('${Environment.apiUrl}','/login');
    final _prefs = new PreferenciasUsuario();

    final authData = {
      'dni': dni,
      'password': password
    };

    final resp = await http.post(url, body: json.encode(authData));
    
    if(resp.statusCode == 201) {
      Map<String, dynamic> decodedResp = json.decode(resp.body);
      _prefs.token = decodedResp['token'];
      _prefs.id = decodedResp['id'];
      return {
        'ok': true,
        'token': decodedResp['token'],
        'id': decodedResp['id']
      };
    } else {
      return {
        'ok': false, 
        'mensaje': resp.body
      };
    }
  }
}