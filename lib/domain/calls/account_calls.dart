import 'package:cash_flow_facts/presentation/widgets/accounts/account_dashboard.dart';

import '../../presentation/config/navigation/navigation_paths.dart';
import '../../presentation/config/navigation/global_nav.dart';
import '../entities/user.dart';
import '../entities/accounts/account.dart';
import 'package:cash_flow_facts/presentation/config/constants.dart';
import 'package:flutter/material.dart';
import '../entities/accounts/account_type.dart';
import '../../presentation/widgets/common_widgets.dart';
import '../../presentation/screens/account_screen.dart';

GlobalNav globalNav = GlobalNav.instance;

// Account
void navigateToNewAccount() async {
  await loadAccount(Account(id: AppConstants.createIDConstant, accountName: '', description: '', balance: 0.0, usedForCashFlow: true));
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

Future<Widget> returAccountScreen(Account account) async {
  List<User> users = await globalNav.userLink!.getListUsers();
  return AccountScreen(account: account, users: users);
}

Future<Widget> returnDashBoadScreen() async {
  List<Account> accounts = await globalNav.accountLink!.getListAccounts();
  return AccountDashboard(accounts);
}

Future<void> loadAccountList(List<Account> accounts) async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.accountList, arguments: accounts);
}

Future<void> loadAccountDashboard(List<Account> accounts) async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.accountDashboard, arguments: accounts);
}

Future<User?> showUsersDialog(BuildContext context, List<User> users) async {
  return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (_) => SimpleDialog(
      title: const Text('Users Dialog'),
      contentPadding: const EdgeInsets.all(15),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          8.0,
        ),
        side: const BorderSide(width: 2.0, color: Colors.grey),
      ),
      children: _convertUsers(context, users),
    ),
  );
}

List<Widget> _convertUsers(BuildContext context, List<User> users) {
  List<Widget> lsdo = [];
  int userId = GlobalNav.instance.sharedPreferences!.getInt(AppConstants.userId)!;
  for (User user in users) {
    if (user.id != userId) {
      lsdo.add(Row(
        children: <Widget>[
          const SizedBox(width: 5),
          const SizedBox(width: 3),
          SimpleDialogOption(
            child: Text(user.name),
            onPressed: () => Navigator.pop<User>(context, user),
          ),
        ],
      ));
      lsdo.add(const Divider(thickness: 1));
    }
  }
  lsdo.removeLast();
  return lsdo;
}

Future<AccountType?> showAccountTypeDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => SimpleDialog(
      title: const Text('Account Types Dialog'),
      contentPadding: const EdgeInsets.all(15),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          8.0,
        ),
        side: const BorderSide(width: 2.0, color: Colors.grey),
      ),
      children: _convertAccountType(context),
    ),
  );
}

List<Widget> _convertAccountType(BuildContext context) {
  List<Widget> lsdo = [];

  for (AccountType accountType in types) {
    lsdo.add(Row(
      children: <Widget>[
        const SizedBox(width: 5),
        IconListImage(accountType.iconPath, 25),
        const SizedBox(width: 3),
        SimpleDialogOption(
          child: Text(accountType.typeName),
          onPressed: () => Navigator.pop(context, accountType),
        ),
      ],
    ));
    lsdo.add(const Divider(thickness: 1));
  }
  if (lsdo.isNotEmpty) lsdo.removeLast();
  return lsdo;
}
