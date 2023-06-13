import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/config/navigation/app_router.dart';
import 'presentation/config/navigation/global_nav.dart';
import 'presentation/screens/home.dart';
import 'presentation/config/enums.dart';
import 'domain/entities/settings_data.dart';
// import 'presentation/config/providers.dart';

late GlobalNav globalNav;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  globalNav = GlobalNav();
  await globalNav.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SettingsData? settingsData;
  ThemeMode themeMode = ThemeMode.system;
  ColorSeed colorSelected = ColorSeed.baseColor;
  ColorImageProvider imageSelected = ColorImageProvider.leaves;
  ColorScheme? imageColorScheme = const ColorScheme.light();
  ColorSelectionMethod colorSelectionMethod = ColorSelectionMethod.colorSeed;

  bool get useLightMode {
    switch (themeMode) {
      case ThemeMode.system:
        return View.of(context).platformDispatcher.platformBrightness == Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void handleColorSelect(int value) {
    setState(() {
      colorSelectionMethod = ColorSelectionMethod.colorSeed;
      colorSelected = ColorSeed.values[value];
    });
  }

  void handleImageSelect(int value) {
    final String url = ColorImageProvider.values[value].url;
    ColorScheme.fromImageProvider(provider: NetworkImage(url)).then((newScheme) {
      setState(() {
        colorSelectionMethod = ColorSelectionMethod.image;
        imageSelected = ColorImageProvider.values[value];
        imageColorScheme = newScheme;
      });
    });
  }

  void updateSettingsData() {
    settingsData = SettingsData(
      colorSelected: colorSelected,
      colorSelectionMethod: colorSelectionMethod,
      handleBrightnessChange: handleBrightnessChange,
      handleColorSelect: handleColorSelect,
      handleImageSelect: handleImageSelect,
      imageSelected: imageSelected,
      useLightMode: useLightMode,
    );
    GlobalNav.instance.settingsData = settingsData!;
  }

  @override
  Widget build(BuildContext context) {
    updateSettingsData();
    final AppRouter appRouter = AppRouter();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        colorSchemeSeed: colorSelectionMethod == ColorSelectionMethod.colorSeed ? colorSelected.color : null,
        colorScheme: colorSelectionMethod == ColorSelectionMethod.image ? imageColorScheme : null,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: colorSelectionMethod == ColorSelectionMethod.colorSeed ? colorSelected.color : imageColorScheme!.primary,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      navigatorKey: GlobalNav.instance.appNavigation.navigatorKey,
      onGenerateRoute: appRouter.onGenerateRoute,
      home: const Home(),
    );
  }
}
