import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/style/app_colors.dart';

class IconListImage extends StatelessWidget {
  final double sized;
  final String iconPath;

  IconListImage(this.iconPath, this.sized);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized,
      height: sized,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(iconPath),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}

Widget simpleButton({
  required Function()? onTap,
  required bool enableButton,
  String? label,
  double? radius,
  double? bottomMargin,
  double? sideMargin,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: bottomMargin ?? 0, left: sideMargin ?? 0, right: sideMargin ?? 0),
    child: FilledButton.tonal(
      style: ButtonStyle(
        shape: MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 25),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(20.0)),
        backgroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
          return states.contains(MaterialState.disabled) ? Colors.black54 : Colors.black;
        }),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      onPressed: enableButton ? onTap : null,
      child: Text(label ?? 'Next'),
    ),
  );
}

TextFormField textFormField({
  required TextEditingController controller,
  required Function()? editComplete,
  FocusNode? thisNode,
  required String labelText,
  Function()? onChanged,
  String? Function(String?)? validator,
  bool? autoFoucusMe,
  List<TextInputFormatter>? formatter,
  EdgeInsetsGeometry? padding,
}) {
  return TextFormField(
    autofocus: autoFoucusMe ?? false,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: validator,
    onEditingComplete: () => editComplete,
    onChanged: (String? value) => onChanged!(),
    focusNode: thisNode,
    inputFormatters: formatter,
    controller: controller,
    decoration: InputDecoration(
      contentPadding: padding,
      errorMaxLines: 2,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: textFormFieldBorder),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelText: labelText,
      labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      border: const OutlineInputBorder(
        gapPadding: 4.0,
        borderSide: BorderSide(color: textFormFieldBorder),
      ),
    ),
  );
}
