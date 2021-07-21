import 'package:beeper_app/src/pages/campaign_page.dart';
import 'package:beeper_app/src/pages/config/new_campus.dart';
import 'package:beeper_app/src/pages/config/new_profile.dart';
import 'package:beeper_app/src/pages/config/profiles_page.dart';
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
    NewCampaign.routeName: (BuildContext context) => NewCampaign(),
    ProfilesPage.routeName: (BuildContext context) => ProfilesPage(),
    NewProfile.routeName: (BuildContext context) => NewProfile(),
    NewCampus.routeName: (BuildContext context) => NewCampus()
  };
}