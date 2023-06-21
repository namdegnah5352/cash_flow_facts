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
    // TODO: implement deleteTransaction
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Transaction>>> insertTransaction(Transaction transaction) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Transaction>>> transactionList(int userId, int accountId) async {
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
            plannedDate: item[TransactionNames.plannedDate] == null ? null : DateTime.parse(item[TransactionNames.plannedDate]),
            amount: item[TransactionNames.amount],
            processed: item[TransactionNames.processed],
            accountId: item[TransactionNames.accountId],
            recurrenceId: item[TransactionNames.recurrenceId],
          ),
        )
        .toList();
    return _items;
  }
}
