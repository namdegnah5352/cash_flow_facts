abstract class TransBase {
  int id;
  int userId;
  String title;
  DateTime? nextTransactionDate;
  double amount;
  bool usedForCashFlow;
  int processed;

  TransBase({
    required this.id,
    required this.userId,
    required this.title,
    required this.nextTransactionDate,
    required this.amount,
    this.usedForCashFlow = true,
    required this.processed,
  });
}
