import 'dart:async';

class NewCampusValidators {
  final validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      if(name.length >= 3) {
        sink.add(name);
      } else {
        sink.addError('Mínimo 3 caracteres');
      }
    }
  );

  final validateAddress = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      if(name.length >= 3) {
        sink.add(name);
      } else {
        sink.addError('Mínimo 3 caracteres');
      }
    }
  );
}