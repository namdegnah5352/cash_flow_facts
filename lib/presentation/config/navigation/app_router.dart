import 'package:flutter/material.dart';
import 'navigation_paths.dart';
import '../../screens/settings.dart';
import '../../screens/home.dart';
import '../../screens/error_handler.dart';
// user
import '../../screens/user_screen.dart';
import '../../widgets/users/users_list.dart';
import '../../../domain/entities/user.dart';
// account
import '../../widgets/accounts/account_dashboard.dart';
import '../../../domain/entities/accounts/account.dart';
import '../../screens/account_screen.dart';
import '../../widgets/accounts/accounts_list.dart';
// transaction
import '../../../domain/entities/transaction.dart';
import '../../widgets/transactions/transaction_list.dart';
import '../../screens/transaction/trans_step1.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    var arg = settings.arguments;

    switch (settings.name) {
      case NavigationPaths.settings:
        return MaterialPageRoute(
          builder: (_) => const Settings(),
        );
      case NavigationPaths.home:
        return MaterialPageRoute(
          builder: (_) => const Home(),
        );
      case NavigationPaths.user:
        return MaterialPageRoute(
          builder: (_) => UserScreen(user: arg as User),
        );
      case NavigationPaths.errorHandler:
        return MaterialPageRoute(
          builder: (_) => ErrorHandler(
            message: arg as String,
          ),
        );
      case NavigationPaths.userList:
        return MaterialPageRoute(
          builder: (_) => UserList(
            arg as List<User>,
          ),
        );
      case NavigationPaths.account:
        // ({Account account, List<User> users}) parts;
        // parts = arg as ({Account account, List<User> users});
        return MaterialPageRoute(
          builder: (_) => AccountScreen(account: arg as Account),
        );
      // case NavigationPaths.accountList:
      //   ({List<Account> account, Function callback}) listParts;
      //   listParts = arg as ({List<Account> account, Function callback});
      //   return MaterialPageRoute(
      //     builder: (_) => AccountList(listParts.account, listParts.callback, () {}, (){}),
      //   );
      case NavigationPaths.accountDashboard:
        return MaterialPageRoute(
          builder: (_) => AccountDashboard(arg as List<Account>),
        );
      // case NavigationPaths.newTransactionStep1:
      //   return MaterialPageRoute(
      //     builder: (_) => TransStep1(),
      //   );
      default:
        return null;
    }
  }
}
