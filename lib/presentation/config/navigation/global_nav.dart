import 'package:cash_flow_facts/presentation/link/user/account_link.dart';

import '../../../data/models/d_base.dart';
import 'app_navigation.dart';
import '../../../domain/entities/settings_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
//Datasource
import '../../../data/datasources/datasources.dart';
import '../../../data/datasources/local_data_source_imp.dart';
//Repositories
import '../../../domain/repositories/repositories_all.dart';
import '../../../data/repositories/user_repository_imp.dart';
import '../../../data/repositories/account_repository_imp.dart';
//Usecase
import '../../../core/usecases/usecase.dart';
import '../../../domain/usecases/user_usecase.dart';
import '../../../domain/usecases/account_usecase.dart';
//Link
import '../../link/user/user_link.dart';
import '../../link/accounts/account_link.dart';

class GlobalNav {
  late final SharedPreferences? sharedPreferences;
  late final AppNavigation appNavigation;
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
    appDataSource = LocalDataSource();
    //user
    userRepository = UserRepositoryImp(dataSource: appDataSource!);
    userUser = UserUser(repository: userRepository!);
    userLink = UserLink(userUser! as UserUser);
    //account
    accountRepository = AccountRepositoryImp(dataSource: appDataSource!);
    accountUser = AccountUser(repository: accountRepository!);
    accountLink = AccountLink(accountUser!);
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
