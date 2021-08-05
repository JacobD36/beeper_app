import 'package:flutter/material.dart';
import 'package:beeper_app/src/models/models.dart';
import 'package:beeper_app/src/global/environment.dart';
import 'package:beeper_app/src/providers/campus_provider.dart';
import 'package:beeper_app/src/services/config_service.dart';
import 'package:beeper_app/src/utils/back_design.dart';
import 'package:beeper_app/src/widgets/menu.dart';
import 'package:provider/provider.dart';

class NewCampus extends StatefulWidget {
  static final String routeName = 'new_campus';

  @override
  _NewCampusState createState() => _NewCampusState();
}

class _NewCampusState extends State<NewCampus> {
  final titleController = new TextEditingController();
  final addressController = new TextEditingController();

  @override
  void initState() { 
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final campusForm = Provider.of<CampusProvider>(context);
    final campusService = Provider.of<ConfigService>(context);

    return Scaffold(
      key: Environment.scaffoldKey,
      appBar: AppBar(
        title: Text('Nueva Sede'),
      ),
      drawer: Drawer(
        child: MenuWidget(),
      ),
      body: Stack(
        children: [
          BackDesign(),
          _formData(context, campusForm, campusService)
        ],
      ),
    );
  }

  Widget _formData(BuildContext context, CampusProvider campusForm, ConfigService campusService) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: Color.fromRGBO(62, 66, 107, 0.7)
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 20.0
          ),
          child: Form(
            key: campusForm.formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Ingrese la información básica de la sede a registrar', style: TextStyle(color: Colors.white, fontSize: 15.0)),
                ),
                SizedBox(height: 20.0),
                _titleInput(campusForm),
                SizedBox(height: 10.0),
                _addressInput(campusForm),
                SizedBox(height: 20.0),
                Divider(color: Colors.white70),
                SizedBox(height: 10.0),
                _buttonList(context, campusForm, campusService)
              ],
            )
          ),
        ),
      ),
    );
  }

  Widget _titleInput(CampusProvider campusForm) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: titleController,
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
      onChanged: (value) => campusForm.title = value,
      validator: (value) {
        return (value != null && value.length >= 3) ? null : 'Mínimo 3 caracteres';
      },
    );
  }

  Widget _addressInput(CampusProvider campusForm) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: addressController,
      maxLines: 3,
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
        labelText: 'Nombre',
        icon: Icon(Icons.home, color: Colors.white),
        labelStyle: new TextStyle(
          color: Colors.white
        ),
      ),
      style: TextStyle(color: Colors.white),
      onChanged: (value) => campusForm.address = value,
      validator: (value) {
        return (value != null && value.length >= 10) ? null : 'Mínimo 10 caracteres';
      },
    );
  }

  _saveCampus(BuildContext context, Campus campus, CampusProvider campusForm, ConfigService campusService) async {
    campusForm.isLoading = true;

    await campusService.saveCampus(campus);

    campusForm.isLoading = false;
  }

  Widget _buttonList(BuildContext context, CampusProvider campusForm, ConfigService campusService) {
    final Campus campusData = new Campus();

    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                child: campusForm.isLoading ? Text('Espere') : Text('Grabar'),
              ),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0.0),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: campusForm.isLoading ? MaterialStateProperty.all(Colors.grey[600]) : MaterialStateProperty.all(Colors.blue[600]),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)))
              ),
              onPressed: campusForm.isLoading ? null : () {
                FocusScope.of(context).unfocus();

                if(!campusForm.isValidForm()) return;

                campusData.title = campusForm.title;
                campusData.address = campusForm.address;

                _saveCampus(context, campusData, campusForm, campusService);
                
                titleController.clear();
                addressController.clear();

                Navigator.pushReplacementNamed(Environment.scaffoldKey.currentContext, 'campus');
              }
            ),
            SizedBox(width: 10.0),
            ElevatedButton(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                child: Text('Cancelar'),
              ),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0.0),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Colors.red[400]),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)))
              ),
              onPressed: () {
                titleController.clear();
                //Navigator.pushReplacementNamed(Environment.scaffoldKey.currentContext, 'profiles');
                Navigator.of(context).pop();
              }
            )
          ],
        ),
      ),
    );
  }
}