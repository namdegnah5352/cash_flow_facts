import 'package:flutter/material.dart';
import '../../domain/entities/settings_data.dart';
import '../config/enums.dart';
import '../../domain/usecases/calls.dart';
import '../config/navigation/global_nav.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  // final SettingsData settingsData;
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void resetSettings() {
    setState(() {});
  }

  SettingsData? settingsData;
  GlobalNav globalNav = GlobalNav.instance;

  bool showMediumSizeLayout = false;
  bool showLargeSizeLayout = false;
  @override
  Widget build(BuildContext context) {
    settingsData = globalNav.settingsData!;
    return Scaffold(
      appBar: createAppBar(resetSettings, settingsData!),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: () => loadHome(),
              child: const Text('Home'),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget createAppBar(
      VoidCallback resetSettings, SettingsData settingsData) {
    return AppBar(
      title: const Text('Settings'),
      actions: !showMediumSizeLayout && !showLargeSizeLayout
          ? [
              _BrightnessButton(
                handleBrightnessChange: settingsData.handleBrightnessChange,
              ),
              _ColorSeedButton(
                resetSettings: resetSettings,
                handleColorSelect: settingsData.handleColorSelect,
                colorSelected: settingsData.colorSelected,
                colorSelectionMethod: settingsData.colorSelectionMethod,
              ),
              _ColorImageButton(
                handleImageSelect: settingsData.handleImageSelect,
                imageSelected: settingsData.imageSelected,
                colorSelectionMethod: settingsData.colorSelectionMethod,
              )
            ]
          : [Container()],
    );
  }
}

class _BrightnessButton extends StatelessWidget {
  const _BrightnessButton({
    required this.handleBrightnessChange,
    this.showTooltipBelow = true,
  });

  final Function handleBrightnessChange;
  final bool showTooltipBelow;

  @override
  Widget build(BuildContext context) {
    final isBright = Theme.of(context).brightness == Brightness.light;
    return Tooltip(
      preferBelow: showTooltipBelow,
      message: 'Toggle brightness',
      child: IconButton(
        icon: isBright
            ? const Icon(Icons.dark_mode_outlined)
            : const Icon(Icons.light_mode_outlined),
        onPressed: () => handleBrightnessChange(!isBright),
      ),
    );
  }
}

class _ColorSeedButton extends StatelessWidget {
  const _ColorSeedButton({
    required this.resetSettings,
    required this.handleColorSelect,
    required this.colorSelected,
    required this.colorSelectionMethod,
  });
  final VoidCallback resetSettings;
  final void Function(int) handleColorSelect;
  final ColorSeed colorSelected;
  final ColorSelectionMethod colorSelectionMethod;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.palette_outlined,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      tooltip: 'Select a seed color',
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) {
        return List.generate(ColorSeed.values.length, (index) {
          ColorSeed currentColor = ColorSeed.values[index];

          return PopupMenuItem(
            value: index,
            enabled: currentColor != colorSelected ||
                colorSelectionMethod != ColorSelectionMethod.colorSeed,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    currentColor == colorSelected &&
                            colorSelectionMethod != ColorSelectionMethod.image
                        ? Icons.color_lens
                        : Icons.color_lens_outlined,
                    color: currentColor.color,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(currentColor.label),
                ),
              ],
            ),
          );
        });
      },
      onSelected: (value) {
        handleColorSelect(value);
        resetSettings();
      },
    );
  }
}

class _ColorImageButton extends StatelessWidget {
  const _ColorImageButton({
    required this.handleImageSelect,
    required this.imageSelected,
    required this.colorSelectionMethod,
  });

  final void Function(int) handleImageSelect;
  final ColorImageProvider imageSelected;
  final ColorSelectionMethod colorSelectionMethod;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.image_outlined,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      tooltip: 'Select a color extraction image',
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) {
        return List.generate(ColorImageProvider.values.length, (index) {
          ColorImageProvider currentImageProvider =
              ColorImageProvider.values[index];

          return PopupMenuItem(
            value: index,
            enabled: currentImageProvider != imageSelected ||
                colorSelectionMethod != ColorSelectionMethod.image,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 48),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image(
                          image: NetworkImage(
                              ColorImageProvider.values[index].url),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(currentImageProvider.label),
                ),
              ],
            ),
          );
        });
      },
      onSelected: handleImageSelect,
    );
  }
}
