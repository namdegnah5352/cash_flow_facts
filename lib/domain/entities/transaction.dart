import '../../data/models/trans_base_abstract.dart';
import '../../../../presentation/config/constants.dart';

class Transaction extends TransBase {
  int accountId;
  int recurrenceId;
  DateTime? endDate;
  Transaction({
    required id,
    required userId,
    required title,
    required nextTransactionDate,
    required amount,
    required processed,
    required this.accountId,
    required this.recurrenceId,
    this.endDate,
  }) : super(id: id, userId: userId, title: title, nextTransactionDate: nextTransactionDate, amount: amount, processed: processed);

  Transaction.startUp({this.accountId = AppConstants.createIDConstant, this.recurrenceId = AppConstants.createIDConstant})
      : super(
          id: AppConstants.createIDConstant,
          userId: AppConstants.createIDConstant,
          amount: 0.0,
          nextTransactionDate: null,
          processed: AppConstants.processedNo,
          title: '',
        );
}
