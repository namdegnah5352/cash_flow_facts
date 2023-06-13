import 'package:fpdart/fpdart.dart';
import '../datasources/datasources.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/repositories_all.dart';
import '../../presentation/config/constants.dart';

typedef _UserOrFailure = Future<List<User>> Function();

class UserRepositoryImp extends UserRepository {
  final AppDataSource dataSource;
  UserRepositoryImp({required this.dataSource});

  @override
  Future<Either<Failure, List<User>>> insertUser(User user) async {
    return await _getResults(() async {
      await dataSource.insert(UserNames.tableName, _toUser(user));
      return await _userList();
    });
  }

  @override
  Future<Either<Failure, List<User>>> userList() async {
    return await _getResults(() async {
      return await _userList();
    });
  }

  @override
  Future<Either<Failure, User>> user(int id) async {
    try {
      final _dataList = await dataSource.getAllDataWhere(UserNames.tableName, id);
      final List<User> _items = _dbToList(_dataList);
      return Right(_items[0]);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on Exception catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<User>>> deleteUser(int id) async {
    try {
      await dataSource.delete(UserNames.tableName, id);
      return Right(await _userList());
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on Exception catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<User>>> updateUser(User user) async {
    try {
      await dataSource.update(UserNames.tableName, user.id, _toUser(user));
      return Right(await _userList());
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on Exception catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  Future<List<User>> _userList() async {
    final _dataList = await dataSource.getData(UserNames.tableName);
    return _dbToList(_dataList);
  }

  List<User> toUsers(List<Map<String, dynamic>> data) {
    return _dbToList(data);
  }

  List<User> _dbToList(List<Map<String, dynamic>> data) {
    final List<User> _items = data
        .map(
          (item) => User(
            id: item[UserNames.id],
            name: item[UserNames.name],
            password: item[UserNames.password],
            email: item[UserNames.email],
          ),
        )
        .toList();
    return _items;
  }

  Future<Either<Failure, List<User>>> _getResults(_UserOrFailure userOrFailure) async {
    try {
      final userList = await userOrFailure();
      return Right(userList);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on Exception catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  Map<String, Object> _toUser(User user) {
    return {
      UserNames.name: user.name,
      UserNames.password: user.password,
      UserNames.email: user.email,
    };
  }
}
