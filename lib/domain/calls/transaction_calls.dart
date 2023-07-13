import '../../presentation/config/navigation/navigation_paths.dart';
import '../../presentation/config/navigation/global_nav.dart';
import '../entities/user.dart';
import '../entities/transaction.dart';
import '../entities/accounts/account.dart';
import '../entities/recurrence.dart';
import 'package:cash_flow_facts/presentation/config/constants.dart';
import 'package:flutter/material.dart';
import '../../presentation/widgets/transactions/transaction_list.dart';
import '../../presentation/screens/transaction/trans_step1.dart';
import '../../presentation/screens/transaction/trans_step2.dart';
import '../../presentation/screens/transaction/trans_step3.dart';
import '../../presentation/screens/transaction/trans_step4.dart';
import '../../presentation/screens/transaction/trans_step5.dart';
import '../../presentation/screens/transaction/trans_step6.dart';
import '../../presentation/config/style/text_styles.dart';
import '../../core/util/journey_list.dart';
import '../../core/util/date_time_extension.dart';
import '../../presentation/config/enums.dart';
import '../../presentation/widgets/common_widgets.dart';

GlobalNav globalNav = GlobalNav.instance;

// Transaction
void navigateToNewTransaction() async {
  await loadTransaction(Transaction(
    id: AppConstants.createIDConstant,
    amount: 0.0,
    nextTransactionDate: null,
    processed: false,
    title: '',
    userId: AppConstants.createIDConstant,
    accountId: AppConstants.createIDConstant,
    recurrenceId: AppConstants.createIDConstant,
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

Future<Widget> returnTransactionsScreen(Account account, Function rebuildDashboard) async {
  List<Transaction> transactions = await globalNav.transactionLink!.getListTransactions(account.id);
  return TransactionList(transactions, rebuildDashboard, account);
}
// This loads the journey and starts from Step 1, completing saves not inserts
// Future<Widget> returnTransactionScreen(Transaction transaction, Account account, Function rebuildDashboard) async {
//                     globalNav.transactionJourney.init(transaction);
//                   globalNav.setDashboardWidget(globalNav.transactionJourney.start()(rebuildDashboard, account), NavIndex.transactions.index);
//                   rebuildDashboard();

//   return TransactionList(transactions, rebuildDashboard, account);
// }
Future<void> loadTransactionList(List<Transaction> transactions) async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.transactionList, arguments: transactions);
}

Future<void> newTransactionStep1() async {
  await globalNav.appNavigation.pushNamed(NavigationPaths.newTransactionStep1);
}

Future<Widget> loadStep1(Function callback, Account account) async {
  return TransStep1(callback, account);
}

Future<Widget> loadStep2(Function callback, Account account) async {
  return TransStep2(callback, account);
}

Future<Widget> loadStep3(Function callback, Account account) async {
  return TransStep3(callback, account);
}

Future<Widget> loadStep4(Function callback, Account account) async {
  return TransStep4(callback, account);
}

Future<Widget> loadStep5(Function callback, Account account) async {
  return TransStep5(callback, account);
}

Future<Widget> loadStep6(Function callback, Account account) async {
  return TransStep6(callback, account);
}

Future<Recurrence?> showRecurrenceDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => SimpleDialog(
      title: Text('Gap till next transaction', style: getDialogHeaderStyle(context)),
      contentPadding: const EdgeInsets.all(15),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          8.0,
        ),
        side: const BorderSide(width: 2.0, color: Colors.grey),
      ),
      children: _convertRecurrences(context),
    ),
  );
}

List<Widget> _convertRecurrences(BuildContext context) {
  List<Widget> lsdo = [];

  for (Recurrence recurrence in recurrences) {
    lsdo.add(Row(
      children: <Widget>[
        const SizedBox(width: 5),
        Icon(recurrence.icon, color: Theme.of(context).colorScheme.primary, size: 25),
        const SizedBox(width: 3),
        SimpleDialogOption(
          child: Text(recurrence.title),
          onPressed: () => Navigator.pop(context, recurrence),
        ),
      ],
    ));
    lsdo.add(const Divider(thickness: 1));
  }
  if (lsdo.isNotEmpty) lsdo.removeLast();
  return lsdo;
}

extension Verbs on JourneyList<Future<Widget> Function(Function, Account), Transaction> {
  void init(Transaction newJourney) => modelData = newJourney;
}

void createOrUpdate(GlobalNav globalNav, Account account, Function refreshDashboard) {
  var trans = globalNav.transactionJourney.modelData;
  trans.accountId = account.id;
  trans.userId = globalNav.sharedPreferences!.getInt(AppConstants.userId)!;
  if (trans.id == AppConstants.createIDConstant) {
    globalNav.transactionLink!.insertTransaction(trans).then((value) {
      refreshDashboard();
    });
  } else {
    globalNav.transactionLink!.updateTransaction(trans).then((value) {
      refreshDashboard();
    });
  }
  globalNav.setDashboardWidget(returnTransactionsScreen(account, refreshDashboard), NavIndex.transactions.index);
}

Widget getSaveButton({
  required GlobalKey<FormState> formKey,
  int? recurrenceId,
  required Function refreshDashboard,
  required Account account,
  TextEditingController? controller,
  required GlobalNav globalNav,
  bool? enableOverride,
}) {
  return simpleButton(
    bottomMargin: 20,
    sideMargin: 20,
    onTap: () async {
      final isValid = formKey.currentState!.validate();
      if (!isValid) return;
      formKey.currentState!.save();
      if (recurrenceId != null) globalNav.transactionJourney.modelData.recurrenceId = recurrenceId;
      createOrUpdate(globalNav, account, refreshDashboard);
    },
    enableButton: enableOverride ??= controller!.text.isNotEmpty,
    label: 'Save',
  );
}

Widget getContinueButton({
  required GlobalKey<FormState> formKey,
  int? recurrenceId,
  required Function refreshDashboard,
  required Account account,
  required TransIndex nextPage,
  TextEditingController? controller,
  bool? enableOverride,
}) {
  return simpleButton(
    bottomMargin: 20,
    sideMargin: 20,
    onTap: () async {
      final isValid = formKey.currentState!.validate();
      if (!isValid) return;
      formKey.currentState!.save();
      if (recurrenceId != null) globalNav.transactionJourney.modelData.recurrenceId = recurrenceId;
      globalNav.setDashboardWidget(
        globalNav.transactionJourney[nextPage.index](refreshDashboard, account),
        NavIndex.transactions.index,
      );
      refreshDashboard();
    },
    enableButton: enableOverride ??= controller!.text.isNotEmpty,
    label: 'Continue',
  );
}
