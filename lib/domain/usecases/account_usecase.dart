import 'package:cash_flow_facts/presentation/config/constants.dart';
import 'package:fpdart/fpdart.dart';
import '../../data/models/params.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/accounts/account.dart';
import '../repositories/repositories_all.dart';
import '../../presentation/config/navigation/global_nav.dart';

class AccountUser extends UseCase<List<Account>, Params> {
  final AccountRepository repository;
  AccountUser({required this.repository});

  @override
  Future<Either<Failure, List<Account>>> call(Params params) async {
    return await repository.accountList(GlobalNav.instance.sharedPreferences!.getInt(AppConstants.userId)!);
  }

  Future<Either<Failure, List<Account>>> getAccounts(int userId) async {
    return await repository.accountList(userId);
  }

  Future<Either<Failure, Account>> shareAccount(Account account, int userId) async {
    return await repository.shareAccount(account, userId);
  }

  Future<Either<Failure, List<Account>>> insertAccount(Account account) async {
    return await repository.insertAccount(account);
  }

  Future<Either<Failure, List<Account>>> updateAccount(Account account) async {
    return await repository.updateAccount(account);
  }

  Future<Either<Failure, List<Account>>> deleteAccount(Account account) async {
    return await repository.deleteAccount(account);
  }
}
