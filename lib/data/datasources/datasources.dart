abstract class AppDataSource {
  Future<int> insert(String tableName, Map<String, dynamic> data);
  Future<List<Map<String, dynamic>>> getData(String tableName);
  Future<List<Map<String, dynamic>>> getDataWhere(
      {required String table, required String columns, required String where, required int args});
  Future<List<Map<String, dynamic>>> getAllDataWhere(String tableName, int id);
  Future<List<Map<String, dynamic>>> getAllDataWhereAny(String tableName, String field, int id);
  Future<void> delete(String tableName, int id);
  Future<void> deleteWhere(String tableName, String column, int id);
  Future<void> deleteMultiple(String tableName, List<String> fields, List<int> ids);
  Future<void> update(String tableName, int id, Map<String, dynamic> data);
  Future<void> updateWhere(String tableName, List<String> columns, List<int> args, Map<String, Object> data);
  Future<List<List<Map<String, dynamic>>>> getMulitipleData(List<String> tableNames);
  Future<List<Map<String, dynamic>>> getAllDataFullIntQuery(String table, List<String> columns, List<int> args);
  Future<List<Map<String, dynamic>>> getDataLinkWhere(
      {required String tableName,
      required String linkTable,
      required String tableField,
      required String linkField,
      required String whereClause});
  Future<void> executeStatement({required String statement});
}
