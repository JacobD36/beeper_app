import 'package:beeper_app/src/bloc/campaign/new_campaign_bloc.dart';
import 'package:beeper_app/src/bloc/config/campaign_bloc.dart';
import 'package:flutter/material.dart';
import 'package:beeper_app/src/bloc/home/home_bloc.dart';
import 'package:beeper_app/src/bloc/auth/auth_bloc.dart';

class AppProvider extends InheritedWidget {
  final authBloc = new AuthBloc();
  final _homeBloc = new HomeBloc();
  final _campaignBloc = new CampaignBloc();
  final  _newCampaignBloc = new NewCampaignBloc();

  static AppProvider _instancia;

  factory AppProvider({Key key, Widget child}) {
    if(_instancia == null) {
      _instancia = new AppProvider._internal(key: key, child: child);
    }

    return _instancia;
  }

  AppProvider._internal({Key key, Widget child}):super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static AuthBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppProvider>().authBloc;
  }

  static HomeBloc homeBloc (BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppProvider>()._homeBloc;
  }

  static CampaignBloc campaignBloc(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppProvider>()._campaignBloc;
  }

  static NewCampaignBloc newCampaignBloc(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppProvider>()._newCampaignBloc;
  }
}