import 'dart:async';

class AuthValidators {
  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: ( email, sink ) {
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp   = new RegExp(pattern);

      if ( regExp.hasMatch( email ) ) {
        sink.add( email );
      } else {
        sink.addError('Formato de email incorrecto');
      }
    }
  );

  final validarDni = StreamTransformer<String, String>.fromHandlers(
    handleData: (dni, sink) {
      if(dni.length >= 8) {
        sink.add(dni);
      } else {
        sink.addError('El DNI debe contener al menos 8 números');
      }
    }
  );

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: ( password, sink ) {

      if ( password.length >= 6 ) {
        sink.add( password );
      } else {
        sink.addError('Contraseña de 6 caracteres como mínimo');
      }
    }
  );
}
