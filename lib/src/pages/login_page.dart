import 'dart:io';
import 'package:flutter/material.dart';
import 'package:beeper_app/src/providers/login_form_provider.dart';
import 'package:beeper_app/src/global/environment.dart';
import 'package:beeper_app/src/services/user_service.dart';
import 'package:beeper_app/src/utils/utils.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static final String routeName = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final dniController = new TextEditingController();
  final passController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    dniController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    final userInformation = Provider.of<UserService>(context);

    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        key: Environment.scaffoldKey,
        body: ModalProgressHUD(
          child: Stack(
            children: [
              _crearFondo(context),
              _loginForm(context, loginForm, userInformation)
            ],
          ),
          inAsyncCall: loginForm.isLoading,
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(),
        ),
        backgroundColor: Colors.blue[300],
      ),
    );
  }

  Widget _loginForm(BuildContext context, LoginFormProvider loginForm, UserService userInformation) {
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
            child: Form(
              key: loginForm.formKey,
              //autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Text('Ingreso', style: TextStyle(fontSize: 20.0)),
                  SizedBox(height: 60.0),
                  _crearDni(loginForm, dniController),
                  SizedBox(height: 30.0),
                  _crearPassword(loginForm, passController),
                  SizedBox(height: 30.0),
                  _crearBoton(loginForm, userInformation, dniController, passController)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _crearDni(LoginFormProvider loginForm, TextEditingController dniController) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: dniController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          icon: Icon(Icons.contact_mail, color: Colors.blue[600]),
          hintText: 'Ingrese su documento de identidad',
          labelText: 'DNI',
        ),
        onChanged: (value) => loginForm.dni = value,
        validator: (value) {
          return (value != null && value.length >= 8) ? null : 'El DNI debe contener al menos 8 dígitos';
        },
      ),
    );
  }

  Widget _crearPassword(LoginFormProvider loginForm, TextEditingController passController) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: passController,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline, color: Colors.blue[600]),
          labelText: 'Contraseña',
        ),
        onChanged: (value) => loginForm.password = value,
        validator: (value) {
          return (value != null && value.length >= 6) ? null : 'El password debe contener al menos 6 caracteres'; 
        },
      ),
    );
  }

  Widget _crearBoton(LoginFormProvider loginForm, UserService userInformation, TextEditingController dniController, TextEditingController passController) {
    return ElevatedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text(loginForm.isLoading ? 'Espere' : 'Ingresar'),
      ),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0.0),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        backgroundColor: loginForm.isLoading ? MaterialStateProperty.all(Colors.grey[600]) : MaterialStateProperty.all(Colors.blue[600]),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)))
      ),
      onPressed: loginForm.isLoading ? null : () => _login(loginForm, context, userInformation, dniController, passController)
    );
  }

  _login(LoginFormProvider loginForm, BuildContext context, UserService userInformation, TextEditingController dniController, TextEditingController passController) async {
    FocusScope.of(context).unfocus();

    if(!loginForm.isValidForm()) return;
    
    loginForm.isLoading = true;  
  
    Map<String, dynamic> info = await  userInformation.login(loginForm.dni, loginForm.password);

    loginForm.isLoading = false;
    
    if(info['ok']) {
      Navigator.pushReplacementNamed(Environment.scaffoldKey.currentContext, 'home');
    } else {
      mostrarAlerta(Environment.scaffoldKey.currentContext, info['mensaje'], false);
      dniController.clear();
      passController.clear();
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