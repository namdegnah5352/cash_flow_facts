import '../../presentation/config/navigation/navigation_paths.dart';
import '../../presentation/config/navigation/global_nav.dart';
import '../entities/user.dart';
import '../entities/accounts/account.dart';
import 'package:cash_flow_facts/presentation/config/constants.dart';

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

// Account
void navigateToNewAccount() async {
  await loadAccount(
      Account(id: AppConstants.createIDConstant, accountName: '', description: '', balance: 0.0, usedForCashFlow: true));
}

void navigateToExistingAccount(Account account) async {
  await loadAccount(account);
}

Future<void> loadAccounts() async {
  globalNav.accountLink!.linkGetAccounts();
}

Future<void> loadAccount(Account account) async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.account, arguments: account);
}

Future<void> loadAccountList(List<Account> accounts) async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.accountList, arguments: accounts);
}
