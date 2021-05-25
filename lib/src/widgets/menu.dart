import 'package:beeper_app/src/bloc/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:beeper_app/src/providers/user_provider.dart';

class MenuWidget extends StatelessWidget {
  final userProvider = new UserProvider();

  @override
  Widget build(BuildContext context) {
    final homeBloc = HomeProvider.of(context);
    homeBloc.getUserInformation();

    return StreamBuilder<Object>(
      stream: homeBloc.userInfoStream,
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
                        homeBloc.userInformation.name1 + ' ' + homeBloc.userInformation.lastName1 + ' ' + homeBloc.userInformation.lastName2,
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
                    this.userProvider.logout();
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