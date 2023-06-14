abstract class TransBase {
  int id;
  int user_id;
  String title;
  String description;
  DateTime? plannedDate;
  double amount;
  bool usedForCashFlow;
  int processed;

  TransBase({
    required this.id, 
    required this.user_id,
    required this.title, 
    required this.description, 
    required this.plannedDate, 
    required this.amount, 
    this.usedForCashFlow = true,
    required this.processed,
  });
}