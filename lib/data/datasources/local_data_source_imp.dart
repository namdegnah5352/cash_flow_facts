import 'datasources.dart';

import '../../core/util/db_helper.dart';
import '../../core/errors/exceptions.dart';

class LocalDataSource extends AppDataSource {
  @override
  Future<int> insert(String tableName, Map<String, dynamic> data) async {
    try {
      int id;
      id = await DBHelper.insert(tableName, data);
      return id;
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getData(String tableName) async {
    try {
      return await DBHelper.getData(tableName);
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<List<List<Map<String, dynamic>>>> getMulitipleData(List<String> tableNames) async {
    try {
      return await DBHelper.getMulitipleData(tableNames);
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getDataWhere(
      {required String table, required String columns, required String where, required int args}) async {
    try {
      return await DBHelper.getDataWhere(table: table, columns: columns, where: where, args: args);
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllDataWhere(String tableName, int id) async {
    try {
      return await DBHelper.getAllDataWhere(table: tableName, args: id);
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllDataWhereAny(String tableName, String field, int id) async {
    try {
      return await DBHelper.getAllDataWhereAny(table: tableName, field: field, args: id);
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllDataFullIntQuery(String table, List<String> columns, List<int> args) async {
    try {
      return await DBHelper.getAllDataFullIntQuery(tableName: table, columns: columns, args: args);
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<void> delete(String tableName, int id) async {
    try {
      await DBHelper.delete(tableName, id);
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<void> deleteWhere(String tableName, String column, int id) async {
    try {
      await DBHelper.deleteWhere(tableName, column, id);
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<void> deleteMultiple(String tableName, List<String> fields, List<int> ids) async {
    try {
      await DBHelper.deleteMultiple(tableName, fields, ids);
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<void> update(String tableName, int id, Map<String, dynamic> data) async {
    try {
      await DBHelper.update(tableName, id, data);
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<void> updateWhere(String tableName, List<String> columns, List<int> args, Map<String, Object> data) async {
    try {
      await DBHelper.updateWhere(tableName, columns, args, data);
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getDataLinkWhere(
      {required String tableName,
      required String linkTable,
      required String tableField,
      required String linkField,
      required String whereClause}) async {
    try {
      return await DBHelper.getDataLinkWhere(tableName, linkTable, tableField, linkField, whereClause);
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<void> executeStatement({required String statement}) async {
    try {
      return await DBHelper.executeStatement(statement: statement);
    } catch (error) {
      throw ServerException(error.toString());
    }
  }
}
