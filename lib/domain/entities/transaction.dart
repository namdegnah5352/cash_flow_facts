import '../../data/models/trans_base_abstract.dart';

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
}
