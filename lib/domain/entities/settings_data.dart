import '../../presentation/config/enums.dart';

class SettingsData {
  bool useLightMode;
  ColorSeed colorSelected;
  ColorImageProvider imageSelected;
  ColorSelectionMethod colorSelectionMethod;
  final void Function(bool useLightMode) handleBrightnessChange;
  final void Function(int value) handleColorSelect;
  final void Function(int value) handleImageSelect;

  SettingsData({
    required this.useLightMode,
    required this.colorSelected,
    required this.imageSelected,
    required this.colorSelectionMethod,
    required this.handleBrightnessChange,
    required this.handleColorSelect,
    required this.handleImageSelect,
  });
}
