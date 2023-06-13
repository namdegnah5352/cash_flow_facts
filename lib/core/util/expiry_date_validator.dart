import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/services.dart';

class ExpiryDateValidator extends TextFieldValidator{

  ExpiryDateValidator({required String errorText}) : super(errorText);

  @override 
  bool isValid(String? value){
    if(value!.length < 5) return true;
    if(value.length > 5) return false;
    if(value[value.length - 1] == 'Y') return false;
    int month = int.parse(value.substring(0, 2));
    int year = 2000 + int.parse(value.substring(3,5));
    DateTime now = DateTime.now();
    int lastday = DateTime(now.year, now.month + 1, 0).day;
    DateTime expiry = DateTime(year, month, lastday);
    if(expiry.isAfter(now)){
      return true;
    } else {
      return false;
    }
  } 
}
class MaskedTextInputFormatter extends TextInputFormatter{
  final String mask;
  final String separator;
  MaskedTextInputFormatter({
    required this.mask,
    required this.separator,
  });
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue){
    if(newValue.text.isNotEmpty){
      if(newValue.text.length > oldValue.text.length){
        if(newValue.text.length > mask.length) return oldValue;
        if(newValue.text[newValue.text.length - 1] == separator) return oldValue;
        if(newValue.text.length < mask.length && mask[newValue.text.length - 1] == separator){
          return TextEditingValue(
            text: '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(offset: newValue.selection.end + 1),
          );
        }
      }
    }
    return newValue;
  } 
}
class ExpiryDateFormatter extends TextInputFormatter{

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue){
    const String mask = 'MM/YY';

    if(newValue.text.isNotEmpty){
      if(newValue.text.length > mask.length) return oldValue;
      return TextEditingValue(
        text: mask,
        selection: TextSelection.collapsed(offset: newValue.selection.end + 1),
      );
    }
    return newValue;
  }
}