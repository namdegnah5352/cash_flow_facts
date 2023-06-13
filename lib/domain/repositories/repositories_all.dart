import 'package:fpdart/fpdart.dart';
import '../entities/user.dart';
import '../../core/errors/failures.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> insertUser(User user);
  Future<Either<Failure, List<User>>> userList();
  Future<Either<Failure, User>> user(int id);
  Future<Either<Failure, List<User>>> deleteUser(int id);
  Future<Either<Failure, List<User>>> updateUser(User user);
}
