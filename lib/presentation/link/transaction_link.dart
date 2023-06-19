import 'package:cash_flow_facts/domain/calls/calls.dart';
import '../../domain/calls/transaction_calls.dart';
import 'package:fpdart/fpdart.dart';
import '../../../domain/usecases/transaction_usecase.dart';
import '../../../domain/entities/transaction.dart';
import '../../../domain/entities/user.dart';
import '../../../core/errors/failures.dart';
import '../config/navigation/global_nav.dart';
import '../config/constants.dart';

class TransactionLink {
  final TransactionUser transactionUser;

  TransactionLink(this.transactionUser);

  void _linkTransactions(Either<Failure, List<Transaction>> either) {
    either.fold(
      (failure) => loadErrorHandler(failure.message),
      (listTransactions) => loadTransactionList(listTransactions),
    );
  }

  void _linkTransaction(Either<Failure, Transaction> either) {
    either.fold(
      (failure) => loadErrorHandler(failure.message),
      (transaction) => loadTransaction(transaction),
    );
  }

  void linkGetTransactions(int accountId) async {
    var either = await transactionUser.getTransactions(GlobalNav.instance.sharedPreferences!.getInt(AppConstants.userId)!, accountId);
    _linkTransactions(either);
  }

  Future<List<Transaction>> getListTransactions(int accountId) async {
    List<Transaction> accounts = [];
    var either = await transactionUser.getTransactions(GlobalNav.instance.sharedPreferences!.getInt(AppConstants.userId)!, accountId);
    either.fold(
      (failure) => loadErrorHandler(failure.message),
      (listTransactions) => accounts = listTransactions,
    );
    return accounts;
  }

  void linkDeleteTransaction(Transaction transaction) async {
    var either = await transactionUser.deleteTransaction(transaction);
    _linkTransactions(either);
  }

  void linkUpdateTransaction(Transaction transaction) async {
    var either = await transactionUser.updateTransaction(transaction);
    _linkTransactions(either);
  }

  void linkCreateTransaction(Transaction transaction) async {
    var either = await transactionUser.insertTransaction(transaction);
    _linkTransactions(either);
  }
}
