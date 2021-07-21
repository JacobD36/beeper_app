import 'dart:async';

class NewProfileValidators {
  final validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: (name,sink) {
      if(name.length >= 3) {
        sink.add(name);
      } else {
        sink.addError('Mínimo 3 caracteres');
      }
    }
  );
}