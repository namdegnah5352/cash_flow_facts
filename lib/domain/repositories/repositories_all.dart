import 'package:fpdart/fpdart.dart';
import '../entities/user.dart';
import '../entities/accounts/account.dart';
import '../../core/errors/failures.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> insertUser(User user);
  Future<Either<Failure, List<User>>> userList();
  Future<Either<Failure, User>> user(int id);
  Future<Either<Failure, List<User>>> deleteUser(int id);
  Future<Either<Failure, List<User>>> updateUser(User user);
}

abstract class AccountRepository {
  Future<Either<Failure, List<Account>>> insertAccount(Account account);
  Future<Either<Failure, List<Account>>> accountList(int userId);
  Future<Either<Failure, List<Account>>> deleteAccount(Account account);
  Future<Either<Failure, List<Account>>> updateAccount(Account account);
  Future<Either<Failure, Account>> shareAccount(Account account, User user);
}
