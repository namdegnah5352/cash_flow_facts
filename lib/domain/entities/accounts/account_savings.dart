import 'account.dart';
import 'account_classes.dart';
import '../../../presentation/config/constants.dart';
import '../../../core/util/general_util.dart';
import 'cash_action.dart';

class AccountSavings extends Account implements InterestPerDay {
  double _savingsRate = 0.0;
  int _addInterestId = AddInterestNames.no_add_interest;
  double _chargeRate = 0.0;
  int _chargeRecurrenceId = RecurrenceNames.no_recurrence;
  DateTime? _accountStart;
  DateTime? _accountEnd;
  double _interestAccrued = 0.0;
  DateTime? _lastInterestAdded;
  double _tempInterestAccrued = 0.0;
  AccountSavings({
    required DateTime? lastInterestAdded,
    required double interestAccrued,
    required double savingsRate,
    required int addInterestId,
    required DateTime? accountStart,
    required DateTime? accountEnd,
    required double chargeRate,
    required int chargeRecurrenceId,
    required int id,
    required String accountName,
    required String description,
    required double balance,
    required bool usedForCashFlow,
    int? accountInterestPaidIntoId,
  }) : super(id: id, accountName: accountName, description: description, balance: balance, usedForCashFlow: usedForCashFlow) {
    _lastInterestAdded = lastInterestAdded;
    _interestAccrued = interestAccrued;
    _savingsRate = savingsRate;
    _addInterestId = addInterestId;
    _chargeRate = chargeRate;
    _chargeRecurrenceId = chargeRecurrenceId;
    _accountStart = accountStart;
    _accountEnd = accountEnd;
    _tempInterestAccrued = 0.0;
  }
  double get interestAccrued => _interestAccrued;
  double get savingsRate => _savingsRate;
  int get addInterestId => _addInterestId;
  double get chargeRate => _chargeRate;
  int get chargeRecurrenceId => _chargeRecurrenceId;
  DateTime? get accountStart => _accountStart;
  DateTime? get accountEnd => _accountEnd;
  DateTime? get lastInterestAdded => _lastInterestAdded;
  double get tempInterestAccrued => _tempInterestAccrued;

  set interestAccrued(double interestAccrued) => _interestAccrued = interestAccrued;
  set savingsRate(double savingsRate) => _savingsRate = savingsRate;
  set addInterestId(int addInterestId) => _addInterestId = addInterestId;
  set chargeRate(double chargeRate) => _chargeRate = chargeRate;
  set chargeRecurrenceId(int chargeRecurrenceId) => _chargeRecurrenceId = chargeRecurrenceId;
  set accountStart(DateTime? accountStart) => _accountStart = accountStart;
  set accountEnd(DateTime? accountEnd) => _accountEnd = accountEnd;
  set lastInterestAdded(DateTime? lastInterestAdded) => _lastInterestAdded = lastInterestAdded;
  set tempInterestAccrued(double tempInterestAccrud) => _tempInterestAccrued = tempInterestAccrud;
  double interestPerDay() {
    double dailyInterestRate = _savingsRate / 100.0 / numberOfDaysThisYear();
    return dailyInterestRate * balance;
  }

  @override
  void addInterestThisDay(DateTime day) {
    _interestAccrued += interestPerDay();
    lastInterestAdded = day;
  }

  @override
  void addTempInterestThisDay(DateTime day) => _tempInterestAccrued += interestPerDay();
  @override
  double getInterestAndTransfer() {
    double ans = interestAccrued;
    interestAccrued = 0.0;
    return ans;
  }

  @override
  double getTempInterestAndTransfer() {
    double ans = tempInterestAccrued;
    tempInterestAccrued = 0.0;
    return ans;
  }
}
