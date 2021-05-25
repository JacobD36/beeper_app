import 'package:flutter/material.dart';
import 'package:beeper_app/src/bloc/home/home_bloc.dart';

class HomeProvider extends InheritedWidget {
  final homeBloc = new HomeBloc();

  static HomeProvider _instancia;

  factory HomeProvider({Key key, Widget child}) {
    if(_instancia == null) {
      _instancia = new HomeProvider._internal(key: key, child: child);
    }

    return _instancia;
  }

  HomeProvider._internal({Key key, Widget child}): super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static HomeBloc of (BuildContext context) => (context.dependOnInheritedWidgetOfExactType<HomeProvider>() as HomeProvider).homeBloc;
}