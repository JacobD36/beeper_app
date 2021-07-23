import 'package:flutter/material.dart';
import 'package:beeper_app/src/bloc/profile/new_profile_bloc.dart';
import 'package:beeper_app/src/global/environment.dart';
import 'package:beeper_app/src/models/profile_model.dart';
import 'package:beeper_app/src/providers/app_provider.dart';
import 'package:beeper_app/src/services/config_service.dart';
import 'package:beeper_app/src/utils/back_design.dart';
import 'package:beeper_app/src/widgets/menu.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class NewProfile extends StatefulWidget {
  static final String routeName = 'new_profile';

  @override
  _NewProfileState createState() => _NewProfileState();
}

class _NewProfileState extends State<NewProfile> {
  final profileProvider = new ConfigService();

  @override
  Widget build(BuildContext context) {
    final newProfileBloc = AppProvider.newProfileBloc(context);
    
    return Scaffold(
      key: Environment.scaffoldKey,
      appBar: AppBar(
        title: Text('Nuevo Perfil'),
      ),
      drawer: Drawer(
        child: MenuWidget(),
      ),
      body: ModalProgressHUD(
        inAsyncCall: newProfileBloc.isLoading, 
        child: Stack(
          children: [
            BackDesign(),
            _formData(context, newProfileBloc)
          ],
        )
      ),
    );
  }

  Widget _formData(BuildContext context, NewProfileBloc bloc) {
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
            child: Text('Ingrese la información básica del perfil a registrar', style: TextStyle(color: Colors.white, fontSize: 15.0)),
          ),
          SizedBox(height: 20.0),
          _titleInput(bloc),
          SizedBox(height: 20.0),
          Divider(color: Colors.white70),
          SizedBox(height: 10.0),
          _buttonList(context, bloc)
        ],
      ),
    );
  }

  Widget _titleInput(NewProfileBloc bloc) {
    return StreamBuilder(
      stream: bloc.nameStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
            //errorText: snapshot.error
          ),
          style: TextStyle(color: Colors.white),
          onChanged: bloc.changeName,
          validator: (value) {
            if(value != null && value.length >=3) {
              return null;
            }
            return snapshot.error;
          },
        );
      }
    );
  }

  _saveProfile(Profile profile, NewProfileBloc bloc) {
    setState(() {
      bloc.isLoading = true;
    });

     this.profileProvider.saveProfile(profile);

    setState(() {
      bloc.isLoading = false;
    });
  }

  Widget _buttonList(BuildContext context, NewProfileBloc bloc) {
    final Profile profileData = new Profile();

    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: bloc.nameStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return ElevatedButton(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                    child: Text('Grabar'),
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0.0),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: snapshot.hasData? MaterialStateProperty.all(Colors.blue[600]) : MaterialStateProperty.all(Colors.grey[600]),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)))
                  ),
                  onPressed: snapshot.hasData? () {
                    profileData.title = bloc.name;
                    _saveProfile(profileData, bloc);
                    bloc.changeName('');
                    //Navigator.pushReplacementNamed(Environment.scaffoldKey.currentContext, 'profiles');
                    Navigator.of(context).pop();
                  } : null
                );
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
                bloc.changeName('');
                Navigator.pushReplacementNamed(Environment.scaffoldKey.currentContext, 'profiles');
              }
            )
          ],
        ),
      ),
    );
  }
}