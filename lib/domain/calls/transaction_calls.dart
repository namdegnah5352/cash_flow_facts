import '../../presentation/config/navigation/navigation_paths.dart';
import '../../presentation/config/navigation/global_nav.dart';
import '../entities/user.dart';
import '../entities/transaction.dart';
import '../entities/accounts/account.dart';
import 'package:cash_flow_facts/presentation/config/constants.dart';
import 'package:flutter/material.dart';
import '../../presentation/widgets/transactions/transaction_list.dart';
import '../../presentation/screens/transaction/next_payment_screen.dart';

GlobalNav globalNav = GlobalNav.instance;

// Transaction
void navigateToNewTransaction() async {
  await loadTransaction(Transaction(
    id: AppConstants.createIDConstant,
    amount: 0.0,
    plannedDate: null,
    processed: false,
    title: '',
    userId: AppConstants.createIDConstant,
    accountId: AppConstants.createIDConstant,
  ));
}

void navigateToExistingTransaction(Transaction transaction) async {
  await loadTransaction(transaction);
}

Future<void> loadTransactions(int accountId) async {
  globalNav.transactionLink!.linkGetTransactions(accountId);
}

Future<void> loadTransaction(Transaction transaction) async {
  List<User> users = await globalNav.userLink!.getListUsers();
  ({Transaction transaction, List<User> users}) parts;
  parts = (transaction: transaction, users: users);
  await globalNav.appNavigation.pushNamed(NavigationPaths.transaction, arguments: parts);
}

Future<Widget> returTransactionsScreen(Account account, Function rebuildDashboard) async {
  List<Transaction> transactions = await globalNav.transactionLink!.getListTransactions(account.id);
  return TransactionList(transactions, rebuildDashboard, account);
}

Future<void> loadTransactionList(List<Transaction> transactions) async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.transactionList, arguments: transactions);
}

Future<void> newTransactionStep1() async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.newTransactionStep1);
}

Future<Widget> loadStep1(Function callback, Account account) async {
  return NextPaymentScreen(callback, account);
}
