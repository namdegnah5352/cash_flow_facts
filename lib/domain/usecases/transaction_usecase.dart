import 'package:fpdart/fpdart.dart';
import '../../data/models/params.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/transaction.dart';
import '../repositories/repositories_all.dart';

class TransactionUser extends UseCase<List<Transaction>, Params> {
  final TransactionRepository repository;
  TransactionUser({required this.repository});

  // not used
  @override
  Future<Either<Failure, List<Transaction>>> call(Params params) async {
    // needs to change
    return await repository.transactionList(1);
  }

  Future<Either<Failure, List<Transaction>>> getTransactions(int userId, int accountId) async {
    return await repository.transactionList(accountId);
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
