import 'package:flutter/material.dart';

bool isNumeric( String s ) {

  if ( s.isEmpty ) return false;

  final n = num.tryParse(s);

  return ( n == null ) ? false : true;

}

void mostrarAlerta(BuildContext context,String mensaje, bool status){
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: status ? Text('Login Exitoso') : Text('Información incorrecta'),
        content: status ? Text('Bienvenido') : Text('Error: $mensaje'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(), 
            child: Text('Ok')
          )
        ],
      );
    }
  );
}