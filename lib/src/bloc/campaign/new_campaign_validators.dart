import 'dart:async';

class NewCampaignValidators {
  final validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      if(name.length >= 3) {
        sink.add(name);
      } else {
        sink.addError('El nombre de la campaña debe contener al menos 3 caracteres');
      }
    }
  );

  final validateDesc = StreamTransformer<String, String>.fromHandlers(
    handleData: (desc, sink) {
      if(desc.length >= 20) {
        sink.add(desc);
      } else {
        sink.addError('La descripción de la campaña debe contener al menos 20 caracteres');
      }
    }
  );

  final validateResponsable = StreamTransformer<String, String>.fromHandlers(
    handleData: (fStart, sink) {
      if(fStart.length >= 3) {
        sink.add(fStart);
      } else {
        sink.addError('Por favor, ingrese un nombre para el responsable');
      }
    }
  );

  final validatePhone = StreamTransformer<String, String>.fromHandlers(
    handleData: (fEnd, sink) {
      if(fEnd.length >= 8) {
        sink.add(fEnd);
      } else {
        sink.addError('Por favor, ingrese un número telefónico válido');
      }
    }
  );
}