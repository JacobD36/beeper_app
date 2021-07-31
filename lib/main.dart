import 'package:beeper_app/src/providers/campaign_provider.dart';
import 'package:beeper_app/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:beeper_app/src/providers/login_form_provider.dart';
import 'package:beeper_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:beeper_app/src/pages/login_page.dart';
import 'package:beeper_app/src/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => LoginFormProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => UserService()),
        ChangeNotifierProvider(create: (BuildContext context) => ConfigService()),
        ChangeNotifierProvider(create: (BuildContext context) => CampaignProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Beeper App',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('es', 'ES')
        ],
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