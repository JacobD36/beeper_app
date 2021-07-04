import 'package:beeper_app/src/pages/campaign_page.dart';
import 'package:beeper_app/src/pages/new_campaign.dart';
import 'package:flutter/material.dart';
import 'package:beeper_app/src/pages/config_page.dart';
import 'package:beeper_app/src/pages/home_page.dart';
import 'package:beeper_app/src/pages/login_page.dart';

Map<String, WidgetBuilder> appRoutes() {
  return <String, WidgetBuilder> {
    LoginPage.routeName: (BuildContext context) => LoginPage(),
    HomePage.routeName: (BuildContext context) => HomePage(),
    ConfigPage.routeName: (BuildContext context) => ConfigPage(),
    CampaignPage.routeName: (BuildContext context) => CampaignPage(),
    NewCampaign.routeName: (BuildContext context) => NewCampaign()
  };
}