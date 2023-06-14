import '../../../data/models/facts_base.dart';
import 'cash_action.dart';
import '../../../data/models/trans_base_abstract.dart';

abstract class InterestPerDay {
  void addInterestThisDay(DateTime day);
  void addTempInterestThisDay(DateTime day);
  double getInterestAndTransfer();
  double getTempInterestAndTransfer();
  DateTime? get accountEnd;
  DateTime? get accountStart;
  List<CashAction> getActions(FactsBase factsbase, DateTime startDate, DateTime finishDate);
}
class InterestTrans extends TransBase {
  InterestTrans({required super.id, required super.user_id, required super.title, required super.description, required super.plannedDate, required super.amount, required super.processed});
  
}