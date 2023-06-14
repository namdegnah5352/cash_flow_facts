import 'cash_action.dart';
import '../../../../presentation/config/constants.dart';

class CashItem {
  double balance;
  CashAction? action;
  bool isMulti = false;
  List<CashAction>? actions;
  String? summary;
  String? dialogData;

  CashItem({required this.balance, this.action});

  List<CashAction> allActions() {
    List<CashAction> acts = [];
    if (action != null) acts.add(action!);
    if (actions != null) {
      for (var act in actions!) {
        acts.add(act);
      }
    }
    return acts;
  }

  CashItem.noCashItem({this.balance = AppConstants.noCashItem});
  bool noCashItem() {
    if (balance == AppConstants.noCashItem) return true;
    return false;
  }
}
