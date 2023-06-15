import 'package:cash_flow_facts/domain/usecases/calls.dart';
import '../../../domain/usecases/account_calls.dart';
import 'package:fpdart/fpdart.dart';
import '../../../domain/usecases/account_usecase.dart';
import '../../../domain/entities/accounts/account.dart';
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

  void _linkAccount(Either<Failure, Account> either) {
    either.fold(
      (failure) => loadErrorHandler(failure.message),
      (account) => loadAccount(account),
    );
  }

  void linkGetAccounts() async {
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
    _linkAccounts(either);
  }

  void linkUpdateAccount(Account account) async {
    var either = await accountUser.updateAccount(account);
    _linkAccounts(either);
  }

  void linkCreateAccount(Account account) async {
    var either = await accountUser.insertAccount(account);
    _linkAccounts(either);
  }

  void linkShareAccount(Account account, int userId) async {
    var either = await accountUser.shareAccount(account, userId);
    _linkAccount(either);
  }
}
