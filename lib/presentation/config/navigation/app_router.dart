import 'package:flutter/material.dart';
import 'navigation_paths.dart';
import '../../screens/settings.dart';
import '../../screens/home.dart';
// user
import '../../screens/user_screen.dart';
import '../../widgets/users/users_list.dart';
import '../../../domain/entities/user.dart';
// account
import '../../../domain/entities/accounts/account.dart';
import '../../screens/account_screen.dart';
import '../../screens/error_handler.dart';
import '../../widgets/accounts/accounts_list.dart';

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
        return MaterialPageRoute(
          builder: (_) => AccountScreen(account: arg as Account),
        );
      case NavigationPaths.accountList:
        return MaterialPageRoute(
          builder: (_) => AccountList(
            arg as List<Account>,
          ),
        );
      default:
        return null;
    }
  }
}
