import 'package:beeper_app/src/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:beeper_app/src/global/environment.dart';
import 'package:beeper_app/src/models/profile_model.dart';
import 'package:beeper_app/src/services/config_service.dart';
import 'package:beeper_app/src/utils/back_design.dart';
import 'package:beeper_app/src/widgets/menu.dart';
import 'package:provider/provider.dart';

class NewProfile extends StatefulWidget {
  static final String routeName = 'new_profile';

  @override
  _NewProfileState createState() => _NewProfileState();
}

class _NewProfileState extends State<NewProfile> {
  final titleController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileForm = Provider.of<ProfileProvider>(context);
    final profileService = Provider.of<ConfigService>(context);

    return Scaffold(
      key: Environment.scaffoldKey,
      appBar: AppBar(
        title: Text('Nuevo Perfil'),
      ),
      drawer: Drawer(
        child: MenuWidget(),
      ),
      body: Stack(
        children: [
          BackDesign(),
          _formData(context, profileForm, profileService)
        ],
      ),
    );
  }

  Widget _formData(BuildContext context, ProfileProvider profileForm, ConfigService profileService) {
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
            key: profileForm.formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Ingrese la información básica del perfil a registrar', style: TextStyle(color: Colors.white, fontSize: 15.0)),
                ),
                SizedBox(height: 20.0),
                _titleInput(profileForm),
                SizedBox(height: 20.0),
                Divider(color: Colors.white70),
                SizedBox(height: 10.0),
                _buttonList(context, profileForm, profileService)
              ]
            )
          ),
        ),
      ),
    );
  }

  Widget _titleInput(ProfileProvider profileForm) {
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
        hintText: 'Nombre del perfil',
        hintStyle: TextStyle(color: Colors.white38),
        labelText: 'Nombre',
        icon: Icon(Icons.ballot, color: Colors.white),
        labelStyle: new TextStyle(
          color: Colors.white
        ),
      ),
      style: TextStyle(color: Colors.white),
      onChanged: (value) => profileForm.title = value,
      validator: (value) {
        return (value != null && value.length >= 3) ? null : 'Mínimo 3 caracteres';
      },
    );
  }

  _saveProfile(BuildContext context, Profile profile, ProfileProvider profileForm, ConfigService profileService) async {
    profileForm.isLoading = true;

    await profileService.saveProfile(profile);
    
    profileForm.isLoading = false;
  }

  Widget _buttonList(BuildContext context, ProfileProvider profileForm, ConfigService profileService) {
    final Profile profileData = new Profile();

    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                child: profileForm.isLoading ? Text('Espere') : Text('Grabar'),
              ),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0.0),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: profileForm.isLoading ? MaterialStateProperty.all(Colors.grey[600]) : MaterialStateProperty.all(Colors.blue[600]),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)))
              ),
              onPressed: profileForm.isLoading ? null : () {
                FocusScope.of(context).unfocus();

                if(!profileForm.isValidForm()) return;

                profileData.title = profileForm.title;

                _saveProfile(context, profileData, profileForm, profileService);
                
                titleController.clear();

                Navigator.pushReplacementNamed(Environment.scaffoldKey.currentContext, 'profiles');
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