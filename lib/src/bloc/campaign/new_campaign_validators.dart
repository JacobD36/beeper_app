import 'dart:async';

class NewCampaignValidators {
  final validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      if(name.length >= 3) {
        sink.add(name);
      } else {
        sink.addError('Mínimo 3 caracteres');
      }
    }
  );

  final validateDesc = StreamTransformer<String, String>.fromHandlers(
    handleData: (desc, sink) {
      if(desc.length >= 20) {
        sink.add(desc);
      } else {
        sink.addError('Mínino 20 caracteres');
      }
    }
  );

  final validateResponsable = StreamTransformer<String, String>.fromHandlers(
    handleData: (fStart, sink) {
      if(fStart.length >= 3) {
        sink.add(fStart);
      } else {
        sink.addError('Mínimo 3 caracteres');
      }
    }
  );

  final validatePhone = StreamTransformer<String, String>.fromHandlers(
    handleData: (fEnd, sink) {
      if(fEnd.length >= 8) {
        sink.add(fEnd);
      } else {
        sink.addError('Número telefónico válido');
      }
    }
  );
}