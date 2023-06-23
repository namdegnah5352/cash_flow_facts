import 'package:cash_flow_facts/domain/entities/recurrence.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/accounts/account_type.dart';
import '../../domain/calls/account_calls.dart';
import '../../domain/entities/accounts/account.dart';
import 'package:intl/intl.dart';

class Currencies {
  static final _values = ['\u0024', '\u00A3', '\u00A5', '\u20AC'];
  static final _terms = ['Dollar', 'Pound', 'Yen', 'Euro'];
  static String currencyTerm(int currency) => _terms[currency];
  static String currencyValue(int currency) => _values[currency];
  static List<PopupMenuItem> getCurrencyItems() {
    return [
      PopupMenuItem(
        value: 0,
        child: Text(_terms[0]),
      ),
      PopupMenuItem(
        value: 1,
        child: Text(_terms[1]),
      ),
      PopupMenuItem(
        value: 2,
        child: Text(_terms[2]),
      ),
      PopupMenuItem(
        value: 3,
        child: Text(_terms[3]),
      ),
    ];
  }
}

class AppConstants {
  static const databaseName = 'multiUserToDo';
  static const userId = 'userId';
  static const defaultUserId = 1;
  static const maxAccountNumber = 'maxAccountNumber';
  static const startAccountNumber = 1;
  static const noAccount = -1010101;
  static const double noCashItem = -1010101;
  static const double noBalance = -1010101;
  static const doOnce = 'doOnce';
  static const doOnceNotDone = 0;
  static const doOnceDone = 1;
  static const usedInCashFlowYes = 1;
  static const usedInCashFlowNo = 0;
  static const processedYes = 1;
  static const processedNo = 0;
  static const lastDate = 'lastDate';
  static const falseMessage =
      'This is the message and now I can see what happens if the text of the message grows and grows and becomes very long indeed and then transfer the money to xxxxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
  static const errorCustomPainterWidth = 55;
  static const stateError = 'An unxepected state was returned, please take a screen shot and email to the developer';
  static const createIDConstant = -1;
}

class UserNames {
  static const single = 'user';
  static const plural = 'users';
  static const id = 'id';
  static const name = 'name';
  static const password = 'password';
  static const tableName = 'users';
  static const email = 'email';
}

class AccountNames {
  static const single = 'Account';
  static const plural = 'Accounts';
  static const id = 'id';
  static const idPrefix = 'PA';
  static const accountName = 'accountName';
  static const description = 'description';
  static const balance = 'balance';
  static const usedForCashFlow = 'usedForCashFlow';
  static const usedForSummary = 'usedForSummary';
  static const tableName = 'accounts';
  static const no_account = -1;
  static const number = 'number';
  static const dummy = 'abc';
  static const noEntry = '';
  static const userId = 'userId';
  static const ongoing = -1;
}

class UserAccountNames {
  static const user_id = 'user_id';
  static const account_id = 'account_id';
  static const tableName = 'user_account';
}

class AccountTypesNames {
  static const tableName = 'account_types';
  static const id = 'id';
  static const iconPath = 'iconPath';
  static const typeName = 'typeName';
  static const plainAccount = 1;
  static const savingAccount = 2;
  static const simpleSavingAccount = 3;
  static const creditCardAccount = 4;
  static const mortgageAccount = 5;
  static const loanAccount = 6;
  static const no_id = -1;
  static const no_user_id = -1;
}

class CategoryNames {
  static const single = 'Category';
  static const plural = 'Catagories';
  static const id = 'id';
  static const categoryName = 'categoryName';
  static const description = 'description';
  static const iconPath = 'iconPath';
  static const usedForCashFlow = 'usedForCashFlow';
  static const tableName = 'categories';
  static const bank_interest_category_id = 14;
  static const bank_charges_category_id = 15;
}

class RecurrenceNames {
  static const single = 'Recurrence';
  static const plural = 'Recurrences';
  static const id = 'id';
  static const title = 'title';
  static const description = 'description';
  static const iconPath = 'iconPath';
  static const type = 'type';
  static const noOccurences = 'noOcurrences';
  static const endDate = 'endDate';
  static const tableName = 'recurences';
  static const no_recurrence = -1;
}

class TransfersNames {
  static const single = 'Transfer';
  static const plural = 'Transfers';
  static const id = 'id';
  static const user_id = 'user_id';
  static const title = 'title';
  static const description = 'description';
  static const fromAccountId = 'fromAccountId';
  static const toAccountId = 'toAccountId';
  static const recurrenceId = 'recurrenceId';
  static const categoryId = 'categoryId';
  static const plannedDate = 'plannedDate';
  static const amount = 'amount';
  static const usedForCashFlow = 'usedForCashFlow';
  static const tableName = 'transfers';
  static const processed = 'processed';
}

class TransactionNames {
  static const single = 'Transaction';
  static const plural = 'Transactions';
  static const id = 'id';
  static const user_id = 'user_id';
  static const title = 'title';
  static const description = 'description';
  static const accountId = 'accountId';
  static const categoryId = 'categoryId';
  static const recurrenceId = 'recurrenceId';
  static const nextTransactionDate = 'nextTransactionDate';
  static const amount = 'amount';
  static const credit = 'credit';
  static const usedForCashFlow = 'usedForCashFlow';
  static const processed = 'processed';
  static const tableName = 'plannedTransactions';
  static const endDate = 'endDate';
  static const byName = 0;
  static const byAccount = 1;
  static const byCategory = 2;
}

class AccountSavingsNames {
  static const tableName = 'savings_account';
  static const savingsRate = 'savingsRate';
  static const save_recurrenceId = 'save_recurrenceId';
  static const chargeRate = 'chargeRate';
  static const charge_recurrenceId = 'charge_recurrenceId';
  static const accountStart = 'accountStart'; // here
  static const interestAccrued = 'interestAccrued';
  static const accountEnd = 'accountEnd';
  static const capitalCeiling = 'capitalCeiling';
  static const savingsAccountId = 'savingsAccount';
  static const chargeAccountId = 'chargeAccount';
  static const generatedTransaction = -1;
  static const lastInterestAdded = 'lastInterestAdded';
}

class UserSavingsNames {
  static const user_id = 'user_id';
  static const account_id = 'account_id';
  static const tableName = 'user_savings';
}

class AccountSimpleSavingsNames {
  static const tableName = 'simple_savings_account';
  static const savingsRate = 'savingsRate';
  static const addInterestId = 'addInterestId';
  static const chargeRate = 'chargeRate';
  static const charge_recurrenceId = 'charge_recurrenceId';
  static const accountStart = 'accountStart';
  static const accountEnd = 'accountEnd';
  static const interestAccrued = 'interestAccrued';
  static const generatedTransaction = -1;
  static const lastInterestAdded = 'lastInterestAdded';
  static const no_add_interest = -1;
}

class UserSimpleSavingsNames {
  static const user_id = 'user_id';
  static const account_id = 'account_id';
  static const tableName = 'user_simple_savings';
}

class SettingNames {
  static const id = 'id';
  static const tableName = 'settings';
  static const settingName = 'settingName';
  static const barChartTotal = -1;
  static const barChartTotalName = 'Total';
  static const userArchiveTrue = 1;
  static const userArchiveFalse = 0;
  static const autoProcessedTrue = 1;
  static const autoProcessedFalse = 0;
  static const defaultCurrency = 1;
  static const processed_interest_temp = -666;
}

class UserSettingNames {
  static const tableName = 'user_settings';
  static const user_id = 'user_id';
  static const setting_id = 'setting_id';
  static const value = 'value';
  static const setting_auto_process = 1;
  static const setting_auto_archive = 2;
  static const setting_bar_chart = 3;
  static const setting_currency = 4;
  static const setting_endDate = 5;
}

class AddInterestNames {
  static const single = 'Add Interest';
  static const id = 'id';
  static const title = 'title';
  static const description = 'description';
  static const iconPath = 'iconPath';
  static const type = 'type';
  static const tableName = 'addinterest';
  static const no_add_interest = -1;
}

List<AccountType> types = [
  AccountType(id: 1, typeName: 'Account', iconPath: 'assets/images/accounts/ac03.jpg', loadThis: returAccountScreen(Account.startUp())),
  AccountType(id: 2, typeName: 'Savings', iconPath: 'assets/images/accounts/ac01.jpg', loadThis: returAccountScreen(Account.startUp())),
  AccountType(id: 3, typeName: 'Loan', iconPath: 'assets/images/accounts/ac06.jpg', loadThis: returAccountScreen(Account.startUp())),
  AccountType(id: 4, typeName: 'Credit Card', iconPath: 'assets/images/accounts/ac04.jpg', loadThis: returAccountScreen(Account.startUp()))
];
List<Recurrence> recurrences = [
  Recurrence(id: 1, title: 'One Off', duration: null, icon: Icons.event_busy),
  Recurrence(id: 2, title: 'Ongoing', duration: null, icon: Icons.event_repeat),
  Recurrence(id: 3, title: 'Weekly', duration: const Duration(days: 7), icon: Icons.next_week),
  Recurrence(id: 4, title: 'Fortnight', duration: const Duration(days: 14), icon: Icons.calendar_view_day),
  Recurrence(id: 5, title: '4 weeks', duration: const Duration(days: 28), icon: Icons.view_week),
  Recurrence(id: 6, title: 'Month', duration: null, icon: Icons.calendar_view_month),
  Recurrence(id: 7, title: 'Quarter', duration: null, icon: Icons.calendar_view_week),
  Recurrence(id: 8, title: 'Half Year', duration: null, icon: Icons.calendar_today),
  Recurrence(id: 9, title: 'Year', duration: null, icon: Icons.date_range),
  Recurrence(id: 10, title: 'End of Month', duration: null, icon: Icons.upcoming),
  Recurrence(id: 11, title: 'First of Month', duration: null, icon: Icons.schedule_send),
];
final formattedDate = DateFormat('dd-MM-yyyy');
