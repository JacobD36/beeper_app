import 'package:flutter/material.dart';
import 'package:beeper_app/src/providers/app_provider.dart';
import 'package:beeper_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:beeper_app/src/pages/login_page.dart';
import 'package:beeper_app/src/routes/routes.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();

    return AppProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Beeper App',
        //initialRoute: prefs.token == '' ? 'login' : 'home',
        initialRoute: 'login',
        routes: appRoutes(),
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) => LoginPage()
          );
        },
      ),
    );
  }
}