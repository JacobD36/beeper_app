import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beeper_app/src/providers/config_provider.dart';
import 'package:beeper_app/src/bloc/campus/new_campus_bloc.dart';
import 'package:beeper_app/src/global/environment.dart';
import 'package:beeper_app/src/providers/app_provider.dart';
import 'package:beeper_app/src/services/config_service.dart';
import 'package:beeper_app/src/utils/back_design.dart';
import 'package:beeper_app/src/widgets/menu.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class NewCampus extends StatefulWidget {
  static final String routeName = 'new_campus';

  @override
  _NewCampusState createState() => _NewCampusState();
}

class _NewCampusState extends State<NewCampus> {
  final campusProvider = new ConfigService();

  @override
  Widget build(BuildContext context) {
    final newCampusBloc = AppProvider.newCampusBloc(context);

    return Scaffold(
      key: Environment.scaffoldKey,
      appBar: AppBar(
        title: Text('Nueva Sede'),
      ),
      drawer: Drawer(
        child: MenuWidget(),
      ),
      body: ModalProgressHUD(
        inAsyncCall: newCampusBloc.isLoading, 
        child: Stack(
          children: [
            BackDesign(),
            _formData(context, newCampusBloc)
          ],
        )
      ),
    );
  }

  Widget _formData(BuildContext context, NewCampusBloc bloc) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: Color.fromRGBO(62, 66, 107, 0.7)
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0
        ),
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text('Ingrese la información básica de la sede a registrar', style: TextStyle(color: Colors.white, fontSize: 15.0),),
          ),
          SizedBox(height: 20.0),
          ChangeNotifierProvider(
            create: (BuildContext context) => ConfigProvider(),
            child: _newCampusForm(),
          )
        ],
      ),
    );
  }

  Widget _newCampusForm() {
    //final campusForm = Provider.of<ConfigProvider>(context);
    return Container(
      child: Form(
        //key: campusForm.formKey,
        child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autocorrect: false,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20.0)
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20.0)
                ),
                hintText: 'Nombre de la Sede',
                hintStyle: TextStyle(color: Colors.white38),
                labelText: 'Nombre',
                icon: Icon(Icons.ballot, color: Colors.white),
                labelStyle: new TextStyle(
                  color: Colors.white
                ),
              ),
              style: TextStyle(color: Colors.white),
              validator: (nameValue) {
                if(nameValue != null && nameValue.length >= 3) {
                  return null;
                }
                return 'Mínimo 3 caracteres';
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autocorrect: false,
              decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20.0)
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20.0)
                ),
                hintText: 'Dirección de la Sede',
                hintStyle: TextStyle(color: Colors.white38),
                labelText: 'Dirección',
                icon: Icon(Icons.ballot, color: Colors.white),
                labelStyle: new TextStyle(
                  color: Colors.white
                ),
              ),
              style: TextStyle(color: Colors.white),
              validator: (addressValue) {
                if(addressValue != null && addressValue.length >= 3) {
                  return null;
                }
                return 'Mínimo 3 caracteres';
              },
            ),
            SizedBox(height: 20.0),
            Divider(color: Colors.white70),
            Center(
              child: ElevatedButton(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                  child: Text('Grabar'),
                ),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0.0),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.blue[600]),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
                ),
                onPressed: () {},
              )
            )
          ],
        )
      ),
    );
  }

  
}