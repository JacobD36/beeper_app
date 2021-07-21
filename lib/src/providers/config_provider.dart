import 'package:flutter/cupertino.dart';

class ConfigProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String campusNameField = '';
  String addressNameField = '';

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}