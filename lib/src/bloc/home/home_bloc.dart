import 'package:rxdart/rxdart.dart';
import 'package:beeper_app/src/models/user_model.dart';
import 'package:beeper_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:beeper_app/src/services/user_service.dart';

class HomeBloc {
  final _userInfo = BehaviorSubject<User>();
  final userService = new UserService();
  final _prefs = new PreferenciasUsuario();
  
  Stream<User> get userInfoStream => _userInfo.stream;

  Function(User) get changeUserInfo => _userInfo.sink.add;

  User get userInformation => _userInfo.value;

  getUserInformation() async {
    final usrData = await userService.getUserById(_prefs.id);
    changeUserInfo(usrData['data']);
  }

  dispose() {
    _userInfo?.close();
  }
}

final homeB = HomeBloc();