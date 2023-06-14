import '../accounts/account_classes.dart';
import 'cash_action.dart';
import '../../../core/util/date_time_extension.dart';
import 'account.dart';
import '../../../presentation/config/constants.dart';

class AddInterest{
  final int id;
  String title;
  String description;
  String iconPath;
  int type;

  AddInterest({

    required this.id,
    required this.title,
    required this.description,
    required this.iconPath,
    required this.type,
  });

  static const endPeriod = 0; 
  static const firstDayOfMonth = 1; 
  static const lastDayOfMonth = 2; 
  static const endOfYear = 3; 
  static const startOfQuarter = 4;
  static const endOfQuarter = 5;
  static const fiscalYearEnd = 6;
  
  List<CashAction> getActions({ 

    required DateTime finishDate, 
    required Account toAccount,
  }){
    late final DateTime begin;
    late DateTime end;
    late bool ongoing;

    List<CashAction> actions = [];
    InterestTrans tb = InterestTrans(id: AccountTypesNames.no_id, user_id: AccountTypesNames.no_user_id, title: '${toAccount.accountName} interest', description: '', plannedDate: null, amount: 0, processed: 0);
    // set the beginng and end dates
    begin = (toAccount as InterestPerDay).accountStart!;
    ongoing = (toAccount as InterestPerDay).accountEnd == null;
    if(ongoing){
      end = finishDate;
    } else if((toAccount as InterestPerDay).accountEnd!.isBefore(finishDate)) {
      end = (toAccount as InterestPerDay).accountEnd!;
      end = end.endOfthisMonth();
    } else {
      end = finishDate;
    }         
    DateTime day = begin;    
    // now add the code in here for all types to determine if the day is correct to add the interest to the account.
    switch(type){
      case AddInterest.lastDayOfMonth:
        day = day.endOfthisMonth();
        while(day.isBeforeOrEqual(end)){
          if(!ongoing && day.isWithinThisMonth((toAccount as InterestPerDay).accountEnd!)){
            actions.add(CashActionDayEvent(tb: tb, account: toAccount, plannedDate: (toAccount as InterestPerDay).accountEnd!, amount: AppConstants.noBalance));
          } else {
            actions.add(CashActionDayEvent(tb: tb, account: toAccount, plannedDate: day, amount: AppConstants.noBalance));
          }
          day = DateTime(day.year, day.month, day.day + 1);
          day = day.endOfthisMonth();
        }
      break;
      case AddInterest.endOfYear:
        day = day.plusOneYear();
        while(day.isBeforeOrEqual(end)){
          if(!ongoing && day.isWithinOneYear((toAccount as InterestPerDay).accountEnd!)){
            actions.add(CashActionDayEvent(tb: tb, account: toAccount, plannedDate: (toAccount as InterestPerDay).accountEnd!, amount: AppConstants.noBalance));
          } else {
            actions.add(CashActionDayEvent(tb: tb, account: toAccount, plannedDate: day, amount: AppConstants.noBalance));
          }
          day = day.plusOneYear();
        }
      break;
     default:
      print('oops the wrong case has been chosen, no cash actions here');
    }
    return actions;
  }
  
}