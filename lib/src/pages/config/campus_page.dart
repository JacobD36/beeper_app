import 'package:flutter/material.dart';
import 'package:beeper_app/src/models/models.dart';
import 'package:beeper_app/src/pages/config/new_campus.dart';
import 'package:beeper_app/src/services/services.dart';
import 'package:beeper_app/src/utils/back_design.dart';
import 'package:beeper_app/src/widgets/menu.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class CampusPage extends StatefulWidget {
  static final String routeName = 'campus';

  @override
  _CampusPageState createState() => _CampusPageState();
}

class _CampusPageState extends State<CampusPage> {
  @override
  Widget build(BuildContext context) {
    final campusService = Provider.of<ConfigService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sedes')
      ),
      drawer: Drawer(
        child: MenuWidget(),
      ),
      body: ModalProgressHUD(
        child: Stack(
          children: [
            BackDesign(),
            _campusList(campusService.campusInfo)
          ],
        ),
        inAsyncCall: campusService.isLoading,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle_outline),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewCampus())),
      ),
    );
  }

  Widget _campusList(List<Campus> campus) {
    if(campus == null) return Container();

    if(campus.length == 0) {
      return Center(
        child: _noData(),
      );
    } else {
      return ListView.builder(
        itemCount: campus.length,
        itemBuilder: (context, i) => _campusItem(context, campus[i])
      );
    }
  }

  Widget _campusItem(BuildContext context, Campus campus) {
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
            title: Text(campus.title, style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold)),
            subtitle: Text(campus.address, style: TextStyle(color: Colors.white)),
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