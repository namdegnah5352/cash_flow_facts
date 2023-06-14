import 'package:flutter/services.dart';

class NoCommaInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    final newText = text.replaceAll(RegExp(r','), '');
    return TextEditingValue(
      text: newText,
      selection: newValue.selection,
      composing: newValue.composing,
    );
  }
}

class TwoDecimalPlacesInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    final pattern = RegExp(r'(\d+)(\.\d{0,2})?');
    final match = pattern.firstMatch(text);

    if (match == null) {
      return newValue;
    }
    final newText = '${match.group(1) ?? ''}${match.group(2) ?? ''}';
    return TextEditingValue(
      text: newText,
      selection: (newText.length == newValue.text.length)
          ? TextSelection.collapsed(offset: newValue.selection.end)
          : TextSelection.collapsed(offset: newValue.selection.end - 1),
      composing: newValue.composing,
    );
  }
}
