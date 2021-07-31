import 'dart:io';
import 'package:flutter/material.dart';
import 'package:beeper_app/src/services/config_service.dart';
import 'package:beeper_app/src/models/models.dart';
import 'package:beeper_app/src/pages/new_campaign.dart';
import 'package:beeper_app/src/utils/back_design.dart';
import 'package:beeper_app/src/widgets/menu.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class CampaignPage extends StatefulWidget {
  static final String routeName = 'campaign';

  @override
  _CampaignPageState createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  @override
  Widget build(BuildContext context) {
    final campaignService = Provider.of<ConfigService>(context);
    
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Campañas'),
        ),
        drawer: Drawer(
          child: MenuWidget()
        ),
        body: ModalProgressHUD(
          child: Stack(
            children: [
              BackDesign(),
              _campList(campaignService.campaignInfo),
            ],
          ),
          inAsyncCall: campaignService.isLoading,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_circle_outline),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewCampaign())),
        ),
      ),
    );
  }

  Widget _campList(List<Campaign> campaigns) {
    if(campaigns == null) return CircularProgressIndicator();
    if(campaigns.length == 0) {
      return Center(
        child: _noData(),
      );
    } else {
      return ListView.builder(
        itemCount: campaigns.length,
        itemBuilder: (context, i) => _campItem2(context, campaigns[i]),
      );
    }
  }

  Widget _campItem2(BuildContext context, Campaign campaign) {
    final size = MediaQuery.of(context).size;

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white),
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
            title: Text(campaign.title, style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold)),
            subtitle: Text(campaign.desc, style: TextStyle(color: Colors.white)),
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