import 'dart:io';
import 'package:beeper_app/src/services/config_service.dart';
import 'package:flutter/material.dart';
import 'package:beeper_app/src/pages/config/new_profile.dart';
import 'package:beeper_app/src/models/models.dart';
import 'package:beeper_app/src/utils/back_design.dart';
import 'package:beeper_app/src/widgets/menu.dart';
import 'package:provider/provider.dart';

class ProfilesPage extends StatefulWidget {
  static final String routeName = 'profiles';
  
  @override
  _ProfilesPageState createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  @override
  Widget build(BuildContext context) {
    final profileService = Provider.of<ConfigService>(context);

    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Perfiles'),
        ),
        drawer: Drawer(
          child: MenuWidget()
        ),
        body: Stack(
          children: [
            BackDesign(),
            _profileList(profileService.profileInfo)
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_circle_outline),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewProfile())),
        ),
      ),
    );
  }

  Widget _profileList(List<Profile> profiles) {
    if(profiles == null) return CircularProgressIndicator();

    if(profiles.length == 0) {
      return Center(
        child: _noData(),
      );
    } else {
      return ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, i) => _profileItem(context, profiles[i])
      );
    }
  }

  Widget _profileItem(BuildContext context, Profile profile) {
    final size = MediaQuery.of(context).size;

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white)
      ),
      onDismissed: null,
      child: GestureDetector(
        onTap: () {

        },
        child: Container(
          padding: EdgeInsets.all(5.0),
          width: size.width,
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(62, 66, 107, 0.7),
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: ListTile(
            leading: Icon(Icons.donut_large, color: Colors.blue),
            title: Text(profile.title, style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold)),
          ),
        ),
      )
    );
  }

  Widget _noData() {
    final size = MediaQuery.of(context).size;
    
    return Container(
      height: 80.0,
      width: size.width,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(62, 66, 107, 0.7),
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Sin información para mostrar', style: TextStyle(color: Colors.white)),
            ],
          ),
          SizedBox(height: 5.0)
        ],
      ),
    );
  }
}