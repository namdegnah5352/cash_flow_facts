import '../../data/models/trans_base_abstract.dart';
import '../../../../presentation/config/constants.dart';

class Transaction extends TransBase {
  int accountId;
  int recurrenceId;
  Transaction({
    required id,
    required userId,
    required title,
    required plannedDate,
    required amount,
    required processed,
    required this.accountId,
    required this.recurrenceId,
  }) : super(id: id, userId: userId, title: title, plannedDate: plannedDate, amount: amount, processed: processed);

  Transaction.startUp({this.accountId = AppConstants.createIDConstant, this.recurrenceId = AppConstants.createIDConstant})
      : super(
          id: AppConstants.createIDConstant,
          userId: AppConstants.createIDConstant,
          amount: 0.0,
          plannedDate: null,
          processed: AppConstants.processedNo,
          title: '',
        );
}
