import '../../presentation/config/navigation/navigation_paths.dart';
import '../../presentation/config/navigation/global_nav.dart';
import '../entities/user.dart';
import '../entities/accounts/account.dart';
import 'package:cash_flow_facts/presentation/config/constants.dart';

GlobalNav globalNav = GlobalNav.instance;

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
  List<User> users = await globalNav.userLink!.getListUsers();
  ({Account account, List<User> users}) parts;
  parts = (account: account, users: users);
  await globalNav.appNavigation.pushNamed(NavigationPaths.account, arguments: parts);
}

Future<void> loadAccountList(List<Account> accounts) async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.accountList, arguments: accounts);
}
