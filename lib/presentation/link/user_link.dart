import 'package:cash_flow_facts/domain/usecases/user_calls.dart';
import '../../../domain/usecases/calls.dart';
import 'package:fpdart/fpdart.dart';
import '../../../domain/usecases/user_usecase.dart';
import '../../../domain/entities/user.dart';
import '../../../core/errors/failures.dart';

class UserLink {
  final UserUser userUser;

  UserLink(this.userUser);

  void _linkUsers(Either<Failure, List<User>> either) {
    either.fold(
      (failure) => loadErrorHandler(failure.message),
      (listUsers) => loadUserList(listUsers),
    );
  }

  void linkGetUsers() async {
    var either = await userUser.getUsers();
    _linkUsers(either);
  }

  Future<List<User>> getListUsers() async {
    List<User> users = [];
    var either = await userUser.getUsers();
    either.fold(
      (failure) => loadErrorHandler(failure.message),
      (listUsers) => users = listUsers,
    );
    return users;
  }

  void linkDeleteUser(int id) async {
    var either = await userUser.deleteUser(id);
    _linkUsers(either);
  }

  void linkUpdateUser(User user) async {
    var either = await userUser.updateUser(user);
    _linkUsers(either);
  }

  void linkCreateUser(User user) async {
    var either = await userUser.insertUser(user);
    _linkUsers(either);
  }
}
