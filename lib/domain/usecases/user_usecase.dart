import 'package:fpdart/fpdart.dart';
import '../../data/models/params.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/repositories_all.dart';

class UserUser extends UseCase<List<User>, Params> {
  final UserRepository repository;
  UserUser({required this.repository});

  @override
  Future<Either<Failure, List<User>>> call(Params params) async {
    return await repository.userList();
  }

  Future<Either<Failure, List<User>>> getUsers() async {
    return await repository.userList();
  }

  Future<Either<Failure, List<User>>> insertUser(User user) async {
    return await repository.insertUser(user);
  }

  Future<Either<Failure, List<User>>> deleteUser(int id) async {
    return await repository.deleteUser(id);
  }

  Future<Either<Failure, List<User>>> updateUser(User user) async {
    return await repository.updateUser(user);
  }

  Future<Either<Failure, User>> user(int id) async {
    return await repository.user(id);
  }
}
