import '../../core/errors/failures.dart';
import '../../core/errors/exceptions.dart';
import '../../domain/entities/transaction.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/repositories/repositories_all.dart';
import '../datasources/datasources.dart';
import '../../presentation/config/constants.dart';
import '../../presentation/config/navigation/global_nav.dart';

class TransactionRepositoryImp extends TransactionRepository {
  final AppDataSource dataSource;
  TransactionRepositoryImp({required this.dataSource});
  @override
  Future<Either<Failure, List<Transaction>>> deleteTransaction(Transaction transaction) async {
    try {
      await dataSource.delete(TransactionNames.tableName, transaction.id);
      var either = await transactionList(transaction.accountId);
      List<Transaction> res = [];
      either.fold(
        (failure) => throw ServerException(failure.message),
        (list) => res = list,
      );
      return Right(res);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on Exception catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> insertTransaction(Transaction transaction) async {
    await dataSource.insert(TransactionNames.tableName, _toTransaction(transaction));
    return transactionList(transaction.accountId);
  }

  @override
  Future<Either<Failure, List<Transaction>>> transactionList(int accountId) async {
    try {
      int userId = GlobalNav.instance.sharedPreferences!.getInt(AppConstants.userId)!;
      final dataList = await dataSource.getAllDataFullIntQuery(
        TransactionNames.tableName,
        [TransactionNames.processed, TransactionNames.user_id, TransactionNames.accountId],
        [SettingNames.autoProcessedFalse, userId, accountId],
      );
      return Right(_dbToList(dataList));
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on Exception catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> updateTransaction(Transaction transaction) async {
    // TODO: implement updateTransaction
    throw UnimplementedError();
  }

  List<Transaction> _dbToList(List<Map<String, dynamic>> data) {
    final List<Transaction> _items = data
        .map(
          (item) => Transaction(
            id: item[TransactionNames.id],
            userId: item[TransactionNames.user_id],
            title: item[TransactionNames.title],
            nextTransactionDate: item[TransactionNames.nextTransactionDate] == null ? null : DateTime.parse(item[TransactionNames.nextTransactionDate]),
            amount: item[TransactionNames.amount],
            processed: item[TransactionNames.processed],
            accountId: item[TransactionNames.accountId],
            recurrenceId: item[TransactionNames.recurrenceId],
          ),
        )
        .toList();
    return _items;
  }

  Map<String, dynamic> _toTransaction(Transaction transaction) {
    int user_id = GlobalNav.instance.sharedPreferences!.getInt(AppConstants.userId)!;
    return {
      TransactionNames.title: transaction.title,
      TransactionNames.user_id: user_id,
      TransactionNames.nextTransactionDate: transaction.nextTransactionDate == null ? null : transaction.nextTransactionDate!.toIso8601String(),
      TransactionNames.amount: transaction.amount,
      TransactionNames.accountId: transaction.accountId,
      TransactionNames.recurrenceId: transaction.recurrenceId,
      TransactionNames.usedForCashFlow: transaction.usedForCashFlow == true ? 1 : 0,
      TransactionNames.processed: transaction.processed,
    };
  }
}
