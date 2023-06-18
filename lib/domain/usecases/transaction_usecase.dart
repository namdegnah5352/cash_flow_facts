import 'package:cash_flow_facts/presentation/config/constants.dart';
import 'package:fpdart/fpdart.dart';
import '../../data/models/params.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/transaction.dart';
import '../entities/user.dart';
import '../repositories/repositories_all.dart';
import '../../presentation/config/navigation/global_nav.dart';

class TransactionUser extends UseCase<List<Transaction>, Params> {
  final TransactionRepository repository;
  TransactionUser({required this.repository});

  // not used
  @override
  Future<Either<Failure, List<Transaction>>> call(Params params) async {
    return await repository.transactionList(GlobalNav.instance.sharedPreferences!.getInt(AppConstants.userId)!, 1);
  }

  Future<Either<Failure, List<Transaction>>> getTransactions(int userId, int accountId) async {
    return await repository.transactionList(userId, accountId);
  }

  Future<Either<Failure, List<Transaction>>> insertTransaction(Transaction transaction) async {
    return await repository.insertTransaction(transaction);
  }

  Future<Either<Failure, List<Transaction>>> updateTransaction(Transaction transaction) async {
    return await repository.updateTransaction(transaction);
  }

  Future<Either<Failure, List<Transaction>>> deleteTransaction(Transaction transaction) async {
    return await repository.deleteTransaction(transaction);
  }
}
