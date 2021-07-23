import 'package:flutter/material.dart';
import 'package:beeper_app/src/utils/back_design.dart';
import 'package:beeper_app/src/providers/app_provider.dart';
import 'package:beeper_app/src/widgets/menu.dart';

class HomePage extends StatelessWidget {
  static final String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    final homeB = AppProvider.homeBloc(context);
    homeB.getUserInformation();
    
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