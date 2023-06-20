import '../../data/models/trans_base_abstract.dart';
import '../../../../presentation/config/constants.dart';

class Transaction extends TransBase {
  int accountId;
  Transaction({
    required id,
    required userId,
    required title,
    required plannedDate,
    required amount,
    required processed,
    required this.accountId,
  }) : super(id: id, userId: userId, title: title, plannedDate: plannedDate, amount: amount, processed: processed);

  Transaction.startUp({this.accountId = AppConstants.createIDConstant})
      : super(
          id: AppConstants.createIDConstant,
          userId: AppConstants.createIDConstant,
          amount: 0.0,
          plannedDate: null,
          processed: AppConstants.processedNo,
          title: '',
        );
}
