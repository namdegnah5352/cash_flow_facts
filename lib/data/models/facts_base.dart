import '../../domain/entities/accounts/account.dart';
import '../../domain/entities/accounts/account_add_interest.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/accounts/cash_item.dart';
import '../../presentation/config/constants.dart';

class FactsBase {
  final List<Account> accounts;

  final List<User> users;
  final List<AddInterest>? addinterests;
  int? accountId;
  Account total =
      Account(id: SettingNames.barChartTotal, accountName: 'Total', description: '', balance: 0.0, usedForCashFlow: true);
  FactsBase({required this.accounts, required this.users, this.addinterests});
  int? get account => accountId;
  set account(int? id) => accountId = id;

  double get total_balance {
    double balance = 0.0;
    for (var account in accounts) {
      balance += account.balance;
    }
    return balance;
  }

  void voidCashAction() {
    total.cashActions = [];
    for (var account in accounts) account.cashActions = [];
  }

  List<CashItem> get cashFlow {
    if (accountId == null || accountId == -1) {
      return this.total.cashFlow;
    } else {
      Account account = this.accounts.firstWhere((acct) => acct.id == accountId);
      return account.cashFlow;
    }
  }

  String accountName(int accountId) {
    if (accountId == null || accountId == -1) {
      return this.total.accountName;
    } else {
      Account account = this.accounts.firstWhere((acct) => acct.id == accountId);
      return account.accountName;
    }
  }
}
