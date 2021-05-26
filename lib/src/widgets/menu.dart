import 'package:flutter/material.dart';
import 'package:beeper_app/src/providers/app_provider.dart';
import 'package:beeper_app/src/services/user_service.dart';

class MenuWidget extends StatefulWidget {
  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final userService = new UserService();

  @override
  Widget build(BuildContext context) {
    final authBloc = AppProvider.of(context);
    final homeB = AppProvider.homeBloc(context);

    return StreamBuilder<Object>(
      stream: homeB.userInfoStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Drawer(
          child: SafeArea(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    children: <Widget> [
                      SizedBox(height: 10.0),
                      Container(
                        child: Image(
                          image: AssetImage('assets/images/logo_2.png')
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        homeB.userInformation.name1 + ' ' + homeB.userInformation.lastName1 + ' ' + homeB.userInformation.lastName2,
                        style: TextStyle(
                          fontSize: 20.0
                        ),
                      )
                    ]
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.account_box_rounded),
                      SizedBox(width: 5.0),
                      Text('SELECCIÓN'),
                    ],
                  ),
                  onTap: () {
                    
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.analytics_outlined),
                      SizedBox(width: 5.0),
                      Text('CAMPAÑAS'),
                    ],
                  ),
                  onTap: () {
                    
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.app_settings_alt_sharp),
                      SizedBox(width: 5.0),
                      Text('CONFIGURACIÓN'),
                    ],
                  ),
                  onTap: () {
                    
                  },
                ),
                Divider(),
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.exit_to_app_rounded),
                      SizedBox(width: 5.0),
                      Text('Salir'),
                    ],
                  ),
                  onTap: () {
                    this.userService.logout();
                    authBloc.changeDni('');
                    authBloc.changePassword('');
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}