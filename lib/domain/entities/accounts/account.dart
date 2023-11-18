import 'dart:convert';
import 'cash_action.dart';
import 'cash_item.dart';
import 'account_balance_at.dart';
import '../../../../presentation/screens/paint/bar_loader.dart';
import '../../../../presentation/config/constants.dart';

List<Account> accountModelFromJson(String str) => List<Account>.from(json.decode(str)["notLearnt"].map((x) => Account.fromJson(x)));
String accontModelToJson(List<Account> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Account {
  late int id;
  late String accountName;
  late String description;
  late double balance;
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

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountName = json['accountName'];
    balance = json['balance'];
    usedForCashFlow = json['usedForCashFlow'];
  }
  Map<String, dynamic> toJson() {
    // not finished
    final data = <String, dynamic>{};
    data['"id"'] = '"$id"';
    data['"accountName"'] = '"$accountName"';
    data['"description"'] = '"$description"';
    data['"balance"'] = '"$balance"';
    return data;
  }

  Account.startUp({this.id = AppConstants.createIDConstant, this.accountName = '', this.description = '', this.balance = 0.0});
  Account.noAccount({this.id = AppConstants.noAccount, this.accountName = '', this.description = '', this.balance = 0.0});
  bool isNoAccount() {
    if (id == AppConstants.noAccount) return true;
    return false;
  }
}
