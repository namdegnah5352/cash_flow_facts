import 'package:fpdart/fpdart.dart';
import '../datasources/datasources.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/accounts/account.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/repositories_all.dart';
import '../../presentation/config/constants.dart';
import '../../core/util/general_util.dart';
import '../../presentation/config/navigation/global_nav.dart';

typedef _AccountsOrFailure = Future<List<Account>> Function();
typedef _AccountOrFailure = Future<Account> Function();

class AccountRepositoryImp extends AccountRepository {
  final AppDataSource dataSource;
  AccountRepositoryImp({required this.dataSource});

  @override
  Future<Either<Failure, List<Account>>> accountList(int userId) async {
    return await _getResults(() async {
      return await _accountList(userId);
    });
  }

  @override
  Future<Either<Failure, List<Account>>> insertAccount(Account account) async {
    int accountId = await dataSource.insert(AccountNames.tableName, _toAccount(account, getNextAccountNumber()));
    await dataSource.insert(UserAccountNames.tableName, _toUserAccount(accountId));
    return await _getResults(() async {
      return await _accountList(GlobalNav.instance.sharedPreferences!.getInt(AppConstants.userId)!);
    });
  }

  @override
  Future<Either<Failure, Account>> shareAccount(Account account, int userId) async {
    try {
      await dataSource.insert(UserAccountNames.tableName, _toUserAccountShared(account, userId));
      return Right(account);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on Exception catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Account>>> deleteAccount(Account account) async {
    await dataSource.delete(AccountNames.tableName, account.id);
    return await _getResults(() async {
      return await _accountList(GlobalNav.instance.sharedPreferences!.getInt(AppConstants.userId)!);
    });
  }

  @override
  Future<Either<Failure, List<Account>>> updateAccount(Account account) async {
    await dataSource.update(AccountNames.tableName, account.id, _toAccount(account, account.id));
    return await _getResults(() async {
      return await _accountList(GlobalNav.instance.sharedPreferences!.getInt(AppConstants.userId)!);
    });
  }

  Future<Either<Failure, List<Account>>> _getResults(_AccountsOrFailure accountsOrFailure) async {
    try {
      final accountList = await accountsOrFailure();
      return Right(accountList);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on Exception catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  Future<Either<Failure, Account>> _getResult(_AccountOrFailure accountOrFailure) async {
    try {
      final account = await accountOrFailure();
      return Right(account);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on Exception catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  Future<List<Account>> _accountList(int userId) async {
    List<Account> accounts;
    String whereClause = "${UserAccountNames.tableName}.${UserAccountNames.user_id} = $userId";
    final dataList = await dataSource.getDataLinkWhere(
        tableName: AccountNames.tableName,
        linkTable: UserAccountNames.tableName,
        tableField: AccountNames.id,
        linkField: UserAccountNames.account_id,
        whereClause: whereClause);
    accounts = fromDBtoAccountList(dataList);
    return accounts;
  }

  List<Account> fromDBtoAccountList(List<Map<String, dynamic>> data) {
    final List<Account> _items = data
        .map(
          (item) => Account(
            id: item[AccountNames.id],
            accountName: item[AccountNames.accountName],
            description: item[AccountNames.description],
            balance: item[AccountNames.balance],
            usedForCashFlow: item[AccountNames.usedForCashFlow] == 1 ? true : false,
          ),
        )
        .toList();
    return _items;
  }

  Map<String, Object> _toAccount(Account account, int id) {
    return {
      AccountNames.id: id,
      AccountNames.accountName: account.accountName,
      AccountNames.description: account.description,
      AccountNames.balance: account.balance,
      AccountNames.usedForCashFlow: account.usedForCashFlow,
    };
  }

  Map<String, Object> _toUserAccount(int accountId) {
    return {
      UserAccountNames.user_id: GlobalNav.instance.sharedPreferences!.getInt(AppConstants.userId)!,
      UserAccountNames.account_id: accountId,
    };
  }

  Map<String, Object> _toUserAccountShared(Account account, int userId) {
    return {
      UserAccountNames.user_id: userId,
      UserAccountNames.account_id: account.id,
    };
  }
}
