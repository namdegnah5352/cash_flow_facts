import '../entities/transaction.dart';
import '../entities/accounts/account.dart';
import '../entities/accounts/cash_action.dart';
import '../../core/util/date_time_extension.dart';

extension TransactionExtension on Transaction {
  Account createCashActions({
    required DateTime nextPaymentDate,
    required Duration duration,
    required Account account,
    required double amount,
    required DateTime finish,
  }) {
    DateTime plannedDate = nextPaymentDate;
    while (finish.isAfterOrEqual(nextPaymentDate)) {
      account.cashActions.add(CashAction(account: account, amount: amount, plannedDate: plannedDate, tb: this));
      plannedDate = plannedDate.add(duration);
    }
    return account;
  }
}
