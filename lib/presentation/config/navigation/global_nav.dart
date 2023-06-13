import '../../../data/models/d_base.dart';
import 'app_navigation.dart';
import '../../../domain/entities/settings_data.dart';
import '../../../data/datasources/datasources.dart';
import '../../../data/datasources/local_data_source_imp.dart';
import '../../../domain/repositories/repositories_all.dart';
import '../../../data/repositories/user_repository_imp.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/usecases/user_usecase.dart';
// import '../../bloc/users/user_bloc.dart';
import '../../link/user/user_link.dart';

class GlobalNav {
  late final AppNavigation appNavigation;
  SettingsData? settingsData;
  AppDataSource? appDataSource;
  UserRepository? userRepository;
  UseCase? userUser;
  UserLink? userLink;

  static final GlobalNav instance = GlobalNav._internal();

  factory GlobalNav() {
    return instance;
  }

  GlobalNav._internal();

  init() async {
    appNavigation = AppNavigation();
    await database();
    appDataSource = LocalDataSource();
    userRepository = UserRepositoryImp(dataSource: appDataSource!);
    userUser = UserUser(repository: userRepository!);
    userLink = UserLink(userUser! as UserUser);
  }
}
