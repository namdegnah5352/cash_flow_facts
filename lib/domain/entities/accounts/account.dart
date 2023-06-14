import 'cash_action.dart';
import 'cash_item.dart';
import 'account_balance_at.dart';
import '../../../../presentation/screens/paint/bar_loader.dart';
import '../../../../presentation/config/constants.dart';

class Account {
  int id;
  String accountName;
  String description;
  double balance;
  bool usedForCashFlow = true;
  List<CashAction> cashActions = [];
  List<CashItem> cashFlow = [];
  List<AccountBalanceAt> balances = [];
  List<BarLoader> loaders = []; //how does the bar loader know the month?

  Account({
    required this.id,
    required this.accountName,
    required this.description,
    required this.balance,
    this.usedForCashFlow = true,
  });
  Account.noAccount({this.id = AppConstants.noAccount, this.accountName = '', this.description = '', this.balance = 0.0});
  bool isNoAccount() {
    if (id == AppConstants.noAccount) return true;
    return false;
  }
}
