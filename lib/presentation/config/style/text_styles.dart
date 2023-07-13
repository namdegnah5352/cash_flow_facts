import 'package:flutter/material.dart';
import 'app_colors.dart';

TextStyle anyStyle({
  required TextStyle start,
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
  TextDecoration? decoration,
  double? letterSpacing,
  double? height,
  double? decorationThickness,
  Color? decorationColor,
  List<Shadow>? shadows,
}) {
  start = start.copyWith(color: color);
  start = start.copyWith(fontSize: fontSize);
  start = start.copyWith(fontWeight: fontWeight);
  start = start.copyWith(decoration: decoration);
  start = start.copyWith(letterSpacing: letterSpacing);
  start = start.copyWith(height: height);
  start = start.copyWith(decorationThickness: decorationThickness);
  start = start.copyWith(decorationColor: decorationColor);
  start = start.copyWith(shadows: shadows);
  return start;
}

TextStyle start = const TextStyle(fontSize: 12, color: simplyBlack, fontWeight: FontWeight.normal);
// TextStyle whiteButtonText = GoogleFonts.roboto(fontSize: 14, color: simplyWhite, fontWeight: FontWeight.w600);
// TextStyle footerStyle = GoogleFonts.roboto(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w400, height: 1.33);
TextStyle unfocussed = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: simplyWhite, height: 1, letterSpacing: 1.2);

TextStyle focussed = anyStyle(
  start: unfocussed,
  fontWeight: FontWeight.w600,
  decoration: TextDecoration.underline,
  decorationThickness: 2,
  decorationColor: Colors.white,
  color: Colors.transparent,
  height: 1.6,
  letterSpacing: 1,
  shadows: [const Shadow(offset: Offset(0, -2), color: Colors.white)],
);
TextStyle drawerMenu = anyStyle(
  start: start,
  color: simplyWhite,
);
// TextStyle appBarHeading = GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.w100, letterSpacing: 0.5, height: 1.36);
// TextStyle bodyBlueFilterStyle = GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold, color: clearFilterText);
// TextStyle dashboardHi20 = GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: -0.5, height: 1.4, color: dashboardHi);
// TextStyle wrapLabel = GoogleFonts.roboto(fontSize: 9, fontWeight: FontWeight.bold, color: simplyBlack);
// TextStyle wrapText = anyStyle(start: wrapLabel, fontSize: 12, fontWeight: FontWeight.w500, height: 1.1);
// TextStyle whiteDetails = anyStyle(start: wrapText, fontWeight: FontWeight.bold, letterSpacing: 1.1,);
// TextStyle textFormFieldLabel = GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w500, height: 1, letterSpacing: 0.5, color: textFormFieldColor);
// TextStyle bottomNavigation = GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400, color: filterDropText);
// TextStyle dropdownEntry = GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400, color: filterDropText, height: 1.5);
// TextStyle billerSearchResults = GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w800, color: dashboardHi, height: 1.4, letterSpacing: 1.1);
// TextStyle customerDataHeading = GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.bold);
// TextStyle customerData = GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w600);
// TextStyle resultsBig = GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.normal);
// TextStyle resultsSmall = GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.normal);
// TextStyle basketPriceStyle = anyStyle(start: basketStyle, letterSpacing: 0.5, height: 1, fontWeight: FontWeight.w700);
// TextStyle basketStyle = GoogleFonts.roboto(fontSize: 16, color: countryCodeTextColor);
// TextStyle yourBasketMobile = anyStyle(start: yourBasket, color: basketTotalHeader);
// TextStyle basketContentsStyle = anyStyle(start: basketStyle, fontSize: 16, height: 1.25, letterSpacing: 0.5);
// TextStyle mobileBasketContentStyle = anyStyle(start: basketContentsStyle, fontSize: 14);
// TextStyle basketQuanity = anyStyle(start: basketStyle, fontSize: 10, height: 1.4, letterSpacing: 0.5, fontWeight: FontWeight.w700);
// TextStyle countryCodeText = anyStyle(start: resultsBig, fontWeight: FontWeight.w500, height: 1, letterSpacing: 0.5, color: countryCodeTextColor);
// TextStyle yourBasket = anyStyle(start: basketStyle, fontSize: 18, letterSpacing: 1, height: 1, color: dashboardHi, fontWeight: FontWeight.w500);
// TextStyle basketTotalHeaderText = anyStyle(start: basketStyle, fontSize: 16, letterSpacing: 1.04, height: 1.19, fontWeight: FontWeight.w400);
// TextStyle basketTotalMinorText = anyStyle(start: basketTotalHeaderText, height: 1, color: basketTotalHeader);
// TextStyle basketTotal = anyStyle(start: basketTotalHeaderText, letterSpacing: 0.5, fontWeight: FontWeight.w700);
// TextStyle basketWeHave = anyStyle(start: basketQuanity, letterSpacing: 1, height: 1, fontWeight: FontWeight.w400);
TextStyle skillsHeader = anyStyle(start: start, fontWeight: FontWeight.bold, fontSize: 20);
TextStyle skillsBody = anyStyle(start: start, fontSize: 16);
TextStyle skillsBodySmall = anyStyle(start: start, fontSize: 13);
TextStyle footerBig = anyStyle(start: start, fontWeight: FontWeight.bold, fontSize: 16);
TextStyle footerSmall = anyStyle(start: start, fontWeight: FontWeight.w600, fontSize: 12);

TextStyle getContextStyle(BuildContext context) {
  return anyStyle(start: start, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w700, fontSize: 24);
}

TextStyle getContextHelperStyle(BuildContext context) {
  return anyStyle(start: start, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500, fontSize: 12);
}

TextStyle oppositeWay(BuildContext context) {
  return anyStyle(start: getContextHelperStyle(context), color: Theme.of(context).colorScheme.primary);
}

TextStyle smallPrimary(BuildContext context) => anyStyle(start: oppositeWay(context), fontSize: 16);

TextStyle getDialogHeaderStyle(BuildContext context) {
  return anyStyle(start: getContextHelperStyle(context), fontSize: 16);
}
