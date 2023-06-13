import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'create_db.dart';
import '../../presentation/config/constants.dart';

Future<sql.Database> database() async {
  const String dbName = AppConstants.databaseName;
  try {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, dbName),
      version: 1,
      onCreate: (db, version) {
        List<String> sqls = CreateDataBase.getSQL();
        for (var sql in sqls) {
          // ignore: avoid_print
          // print(sql);
          db.execute(sql);
        }
        db.execute('PRAGMA foreign_keys = ON;');
      },
    );
  } catch (error) {
    rethrow;
  }
}
