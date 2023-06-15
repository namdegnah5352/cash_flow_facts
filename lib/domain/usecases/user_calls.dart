import '../../presentation/config/navigation/navigation_paths.dart';
import '../../presentation/config/navigation/global_nav.dart';
import '../entities/user.dart';
import 'package:cash_flow_facts/presentation/config/constants.dart';

GlobalNav globalNav = GlobalNav.instance;

// Users
Future<void> loadUserList(List<User> users) async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.userList, arguments: users);
}

Future<void> loadUser(User user) async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.user, arguments: user);
}

void navigateToNewUser() async {
  await loadUser(User(id: AppConstants.createIDConstant, name: '', password: '', email: ''));
}

void navigateToExistingUser(User user) async {
  await loadUser(user);
}

Future<void> loadUsers() async {
  globalNav.userLink!.linkGetUsers();
}
