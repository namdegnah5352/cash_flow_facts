import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LunhCheckValidator extends TextFieldValidator {
  LunhCheckValidator({required String errorText}) : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  isValid(String? value) {
    return isLuhnCheckPassed(value!);
  }
}

class PasswordMatch extends TextFieldValidator {
  PasswordMatch({required String toCheck, required String errorText}) : super(errorText) {
    password = toCheck;
  }
  late String password;
  @override
  bool get ignoreEmptyValues => false;
  @override
  isValid(String? value) {
    return value!.compareTo(password) == 0;
  }
}

bool isLuhnCheckPassed(String creditCardNumber) {
  String _cleaned = creditCardNumber.replaceAll(RegExp('[^0-9.]'), '');
  late String _firstPart;
  late String _lastPart;
  late String _reversed;
  if (_cleaned.length < 16) return true;
  if (_cleaned.length == 16) {
    _firstPart = _cleaned.substring(0, 15);
    _lastPart = _cleaned.substring(15, 16);
  }
  _reversed = _firstPart.split('').reversed.join();
  int sum = luhnCalc(_reversed);
  int lastDigit = 10 - (sum % 10);
  if (lastDigit == int.parse(_lastPart)) return true;
  return false;
}

int luhnCalc(String values) {
  late int value;
  List<int> _steps = List<int>.filled(15, 0);
  for (int i = 0; i < 15; i++) {
    value = int.parse(values[i]);
    _steps[i] = i.isEven ? value * 2 : value;
    if (_steps[i] > 9) _steps[i] -= 9;
  }
  int _finalSum = _steps.reduce((a, b) => a + b);
  return _finalSum;
}
