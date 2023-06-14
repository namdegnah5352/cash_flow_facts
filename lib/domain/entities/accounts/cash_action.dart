import '../../../data/models/trans_base_abstract.dart';
import 'account.dart';
import 'account_classes.dart';

class CashAction {
  TransBase? tb;
  Account account;
  double amount;
  DateTime plannedDate;

  CashAction({required this.tb, required this.account, required this.amount, required this.plannedDate});

  bool isPlainAccount() {
    if (this is CashActionDayEvent) return false;
    if (this is OnThisDay) return false;
    return true;
  }
}

abstract class OnThisDay {
  double? transferTempInterestAndReturn();
  double? transferInterestAndReturn();
}

class CashActionDayEvent extends CashAction implements OnThisDay {
  CashActionDayEvent({required TransBase tb, required Account account, required double amount, required DateTime plannedDate})
      : super(tb: tb, account: account, amount: amount, plannedDate: plannedDate);

  double transferInterestAndReturn() {
    if (account is InterestPerDay) {
      amount = (account as InterestPerDay).getInterestAndTransfer();
      return amount;
    } else {
      return 0.0;
    }
  }

  double transferTempInterestAndReturn() {
    if (account is InterestPerDay) {
      amount = (account as InterestPerDay).getTempInterestAndTransfer();
      return amount;
    } else {
      return 0.0;
    }
  }
}
