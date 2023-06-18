import 'package:flutter/material.dart';

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
