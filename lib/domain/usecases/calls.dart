import '../../presentation/config/navigation/navigation_paths.dart';
import '../../presentation/config/navigation/global_nav.dart';

GlobalNav globalNav = GlobalNav.instance;

Future<void> loadSettings() async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.settings, arguments: globalNav.settingsData!);
}

Future<void> loadHome() async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.home);
}

Future<void> loadErrorHandler(String message) async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.errorHandler, arguments: message);
}
