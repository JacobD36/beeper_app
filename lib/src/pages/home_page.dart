import 'package:beeper_app/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:beeper_app/src/utils/back_design.dart';
import 'package:beeper_app/src/widgets/menu.dart';
import 'package:provider/provider.dart';


class HomePage extends StatelessWidget {
  static final String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    userService.getUserInformation();

    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      drawer: Drawer(
        child: MenuWidget()
      ),
      body: Stack(
        children: [
          BackDesign()
        ],
      ),
    );
  }

  
}