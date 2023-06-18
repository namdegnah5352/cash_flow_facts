import '../../presentation/config/navigation/navigation_paths.dart';
import '../../presentation/config/navigation/global_nav.dart';
import '../entities/user.dart';
import '../entities/transaction.dart';
import 'package:cash_flow_facts/presentation/config/constants.dart';

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

Future<void> loadTransactionList(List<Transaction> transactions) async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.transactionList, arguments: transactions);
}
