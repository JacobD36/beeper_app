import 'package:flutter/material.dart';
import 'package:beeper_app/src/global/environment.dart';
import 'package:beeper_app/src/providers/app_provider.dart';
import 'package:beeper_app/src/services/user_service.dart';
import 'package:beeper_app/src/utils/utils.dart';
import 'package:beeper_app/src/bloc/auth/auth_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  static final String routeName = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userProvider = new UserService();

  @override
  Widget build(BuildContext context) {
    final authBloc = AppProvider.of(context);

    return Scaffold(
      key: Environment.scaffoldKey,
      body: ModalProgressHUD(
        child: Stack(
          children: [
            _crearFondo(context),
            _loginForm(context, authBloc)
          ],
        ),
        inAsyncCall: authBloc.isLoading,
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
      ),
      backgroundColor: Colors.blue[300],
    );
  }

  Widget _loginForm(BuildContext context, AuthBloc bloc) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 180.0
            )
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow> [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: [
                Text('Ingreso', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                _crearDni(bloc),
                SizedBox(height: 30.0),
                _crearPassword(bloc),
                SizedBox(height: 30.0),
                _crearBoton(bloc)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _crearDni(AuthBloc bloc) {
    return StreamBuilder(
      stream: bloc.dniStream ,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              icon: Icon(Icons.contact_mail, color: Colors.blue[600]),
              hintText: 'Ingrese su documento de identidad',
              labelText: 'DNI',
              //errorText: snapshot.error
            ),
            onChanged: bloc.changeDni,
            validator: (value) {
              Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp   = new RegExp(pattern);

              if ( value != null && regExp.hasMatch( value ) ) {
                return null;
              }

              return snapshot.error;
            },
          ),
        );  
      },
    );
  }

  Widget _crearPassword(AuthBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream ,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Colors.blue[600]),
              labelText: 'Contraseña',
              //errorText: snapshot.error
            ),
            onChanged: bloc.changePassword,
            validator: (value) {
              if(value != null && value.length >= 8) {
                return null;
              }
              return snapshot.error;
            },
          ),
        );  
      },
    );
  }

  Widget _crearBoton(AuthBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return ElevatedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Ingresar'),
          ),
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0.0),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: snapshot.hasData? MaterialStateProperty.all(Colors.blue[600]) : MaterialStateProperty.all(Colors.grey[600]),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)))
          ),
          onPressed: snapshot.hasData? () => _login(bloc, context) : null
        );  
      },
    );
  }

  _login(AuthBloc bloc, BuildContext context) async {
    setState(() {
      bloc.isLoading = true;  
    });
  
    Map<String, dynamic> info = await userProvider.login(bloc.dni, bloc.password);

    setState(() {
      bloc.isLoading = false;
    });

    if(info['ok']) {
      Navigator.pushReplacementNamed(Environment.scaffoldKey.currentContext, 'home');
    } else {
      bloc.changeDni('');
      bloc.changePassword('');
      mostrarAlerta(Environment.scaffoldKey.currentContext, info['mensaje'], false);
    }
  }

  Widget _crearFondo(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );


    return Stack(
      children: <Widget>[
        fondoModaro,
        Positioned( top: 90.0, left: 30.0, child: circulo ),
        Positioned( top: -40.0, right: -30.0, child: circulo ),
        Positioned( bottom: -50.0, right: -10.0, child: circulo ),
        Positioned( bottom: 120.0, right: 20.0, child: circulo ),
        Positioned( bottom: -50.0, left: -20.0, child: circulo ),
        
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              //Icon( Icons.person_pin_circle, color: Colors.white, size: 100.0 ),
              Image(
                image: AssetImage('assets/images/logo_2.png'),
                width: 300.0,
              ),
              SizedBox( height: 10.0, width: double.infinity ),
              Text('Beeper App', style: TextStyle( color: Colors.white, fontSize: 25.0 ))
            ],
          ),
        )

      ],
    );
  }  
}