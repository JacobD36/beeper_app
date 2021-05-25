import 'package:flutter/material.dart';
import 'package:beeper_app/src/bloc/auth/auth_bloc.dart';

class AuthProvider extends InheritedWidget {
  final authBloc = new AuthBloc();

  static AuthProvider _instancia;

  factory AuthProvider({Key key, Widget child}) {
    if(_instancia == null) {
      _instancia = new AuthProvider._internal(key: key, child: child);
    }

    return _instancia;
  }

  AuthProvider._internal({Key key, Widget child}):super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static AuthBloc of (BuildContext context) => (context.dependOnInheritedWidgetOfExactType<AuthProvider>() as AuthProvider).authBloc;  
}