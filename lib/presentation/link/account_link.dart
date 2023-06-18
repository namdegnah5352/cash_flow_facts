import 'package:cash_flow_facts/domain/calls/calls.dart';
import '../../domain/calls/account_calls.dart';
import 'package:fpdart/fpdart.dart';
import '../../../domain/usecases/account_usecase.dart';
import '../../../domain/entities/accounts/account.dart';
import '../../../domain/entities/user.dart';
import '../../../core/errors/failures.dart';
import '../config/navigation/global_nav.dart';
import '../config/constants.dart';

class AccountLink {
  final AccountUser accountUser;

  AccountLink(this.accountUser);

  void _linkAccounts(Either<Failure, List<Account>> either) {
    either.fold(
      (failure) => loadErrorHandler(failure.message),
      (listAccounts) => loadAccountList(listAccounts),
    );
  }

  void _linkAccountDashboard(Either<Failure, List<Account>> either) {
    either.fold(
      (failure) => loadErrorHandler(failure.message),
      (listAccounts) => loadAccountDashboard(listAccounts),
    );
  }

  void _linkAccount(Either<Failure, Account> either) {
    either.fold(
      (failure) => loadErrorHandler(failure.message),
      (account) => loadAccount(account),
    );
  }

  void linkGetAccounts() async {
    var either = await accountUser.getAccounts(GlobalNav.instance.sharedPreferences!.getInt(AppConstants.userId)!);
    _linkAccountDashboard(either);
  }

  void linkGetAccountsForDashboard() async {
    var either = await accountUser.getAccounts(GlobalNav.instance.sharedPreferences!.getInt(AppConstants.userId)!);
    _linkAccounts(either);
  }

  Future<List<Account>> getListAccounts() async {
    List<Account> accounts = [];
    var either = await accountUser.getAccounts(GlobalNav.instance.sharedPreferences!.getInt(AppConstants.userId)!);
    either.fold(
      (failure) => loadErrorHandler(failure.message),
      (listAccounts) => accounts = listAccounts,
    );
    return accounts;
  }

  void linkDeleteAccount(Account account) async {
    var either = await accountUser.deleteAccount(account);
    _linkAccountDashboard(either);
  }

  void linkUpdateAccount(Account account) async {
    var either = await accountUser.updateAccount(account);
    _linkAccountDashboard(either);
  }

  void linkCreateAccount(Account account) async {
    var either = await accountUser.insertAccount(account);
    _linkAccountDashboard(either);
  }

  void linkShareAccount(Account account, User user) async {
    var either = await accountUser.shareAccount(account, user);
    _linkAccount(either);
  }
}
