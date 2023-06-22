import 'package:cash_flow_facts/domain/calls/transaction_calls.dart';
import '../../../domain/entities/accounts/account.dart';
import '../../../data/models/d_base.dart';
import 'package:flutter/material.dart';
import 'app_navigation.dart';
import '../../../domain/entities/settings_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../../../core/util/journey_list.dart';
//Journey
import '../../../domain/entities/transaction.dart';
import '../../../data/models/constant_classes.dart';
//Datasource
import '../../../data/datasources/datasources.dart';
import '../../../data/datasources/local_data_source_imp.dart';
//Repositories
import '../../../domain/repositories/repositories_all.dart';
import '../../../data/repositories/user_repository_imp.dart';
import '../../../data/repositories/account_repository_imp.dart';
import '../../../data/repositories/transaction_repository_imp.dart';
//Usecase
import '../../../core/usecases/usecase.dart';
import '../../../domain/usecases/user_usecase.dart';
import '../../../domain/usecases/account_usecase.dart';
import '../../../domain/usecases/transaction_usecase.dart';
//Link
import '../../link/user_link.dart';
import '../../link/account_link.dart';
import '../../link/transaction_link.dart';

class GlobalNav {
  late final SharedPreferences? sharedPreferences;
  late final AppNavigation appNavigation;
  late final JourneyList<Future<Widget> Function(Function, Account), Transaction> transactionJourney;
  SettingsData? settingsData;
  AppDataSource? appDataSource;
  //User
  UserRepository? userRepository;
  UseCase? userUser;
  UserLink? userLink;
  //Account
  AccountRepository? accountRepository;
  AccountUser? accountUser;
  AccountLink? accountLink;
  //Transaction
  TransactionRepository? transactionRepository;
  TransactionUser? transactionUser;
  TransactionLink? transactionLink;
  //Journey
  late List<Widget> accountDashboardWidgets;

  void setDashboardWidget(Future<Widget> futureWidget, int index) async {
    Widget widget = await futureWidget;
    accountDashboardWidgets[index] = widget;
  }

  static final GlobalNav instance = GlobalNav._internal();

  factory GlobalNav() {
    return instance;
  }

  GlobalNav._internal();

  init() async {
    appNavigation = AppNavigation();
    sharedPreferences = await SharedPreferences.getInstance();
    setUpShared(sharedPreferences!);
    await database();
    accountDashboardWidgets = [const NoAccounts(), const NoTransactions(), const NoMoveMoney(), const NoSettings()];
    // load backend classes
    appDataSource = LocalDataSource();
    //Journey
    transactionJourney = JourneyList(Transaction.startUp());
    transactionJourney.addAll([loadStep1, loadStep2, loadStep3, loadStep4, loadStep5]);
    //user
    userRepository = UserRepositoryImp(dataSource: appDataSource!);
    userUser = UserUser(repository: userRepository!);
    userLink = UserLink(userUser! as UserUser);
    //account
    accountRepository = AccountRepositoryImp(dataSource: appDataSource!);
    accountUser = AccountUser(repository: accountRepository!);
    accountLink = AccountLink(accountUser!);
    //transaction
    transactionRepository = TransactionRepositoryImp(dataSource: appDataSource!);
    transactionUser = TransactionUser(repository: transactionRepository!);
    transactionLink = TransactionLink(transactionUser!);
  }
}

void setUpShared(SharedPreferences sharedPreferences) {
  // User_id the unique identifier of the user
  int? userChoice = sharedPreferences.getInt(AppConstants.userId);
  if (userChoice == null) sharedPreferences.setInt(AppConstants.userId, AppConstants.defaultUserId);
  // Maximum account number used due to several account types which all share a unique number to make most code simpler
  int? maxAccountNumber = sharedPreferences.getInt(AppConstants.maxAccountNumber);
  if (maxAccountNumber == null) sharedPreferences.setInt(AppConstants.maxAccountNumber, AppConstants.startAccountNumber);
}
