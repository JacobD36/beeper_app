import 'dart:convert';
import 'package:beeper_app/src/global/environment.dart';
import 'package:beeper_app/src/models/user_model.dart';
import 'package:beeper_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UserService {
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login(String dni, String password) async {
    final url = Uri.http('${Environment.apiUrl}','/login');

    final authData = {
      'dni': dni,
      'password': password
    };

    final resp = await http.post(url, body: json.encode(authData));
    
    if(resp.statusCode == 201) {
      Map<String, dynamic> decodedResp = json.decode(resp.body);
      this._prefs.token = decodedResp['token'];
      this._prefs.id = decodedResp['id'];

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

  Future<Map<String, dynamic>> getUserById(String id) async {
    final url = Uri.http('${Environment.apiUrl}', '/seekUser',{'id': id});

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer'+this._prefs.token,
    };

    final resp = await http.get(url, headers: headers);

    if(resp.statusCode == 201) {
      final userData = User.fromJson(json.decode(resp.body));
      
      return {
        'ok': true,
        'data': userData
      };
    } else {
      return {
        'ok': false,
        'data': 'Error'
      };
    }
  }

  void logout() {
    this._prefs.token = '';
    this._prefs.id = '';
  }
}