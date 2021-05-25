import 'package:beeper_app/src/bloc/home/home_provider.dart';
import 'package:beeper_app/src/widgets/menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static final String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return HomeProvider(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Inicio'),
        ),
        drawer: Drawer(
          child: MenuWidget()
        ),
        body: Container(),
      ),
    );
  }
}