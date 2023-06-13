import 'package:sqflite/sqflite.dart' as sql;
import '../../data/models/d_base.dart';

//SQLite implementation
class DBHelper {
  static Future<int> insert(String table, Map<String, dynamic> data) async {
    int id;
    try {
      final db = await database();
      id = await db.insert(
        table,
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
      return id;
    } catch (error) {
      throw Exception(
          'Could not insert into : ' + table + ' : ' + error.toString());
    }
  }

  static Future<void> update(
      String table, int id, Map<String, dynamic> data) async {
    try {
      final db = await database();
      db.update(
        table,
        data,
        where: 'id = ?',
        whereArgs: [id],
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
    } catch (error) {
      throw Exception(
          'could not update table ' + table + ' : ' + error.toString());
    }
  }
  static Future<void> updateWhere(String table, List<String> columns, List<int> args, Map<String, Object> data) async {      
    try {
      final String whereClause = getWhereClause(columns);
      final db = await database();
      db.update(
        table,
        data,
        where: whereClause,
        whereArgs: args,
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
    } catch (error) {
      throw Exception(
          'could not update table ' + table + ' : ' + error.toString());
    }
  }

  static Future<int> delete(String table, int id) async {
    try {
      final db = await database();
      return await db.delete(table, where: 'id = ?', whereArgs: [id]);
    } catch (error) {
      throw Exception(
          'could not delete from table ' + table + ' : ' + error.toString());
    }
  }
  static Future<int> deleteMultiple(String table, List<String> fields, List<int> ids) async {
    try {
      final db = await database();
      String whereClause = getWhereClause(fields);
      return await db.delete(table, where: whereClause, whereArgs: ids);
    } catch (error) {
      throw Exception(
          'could not delete from table ' + table + ' : ' + error.toString());
    }    
  }
  static Future<int> deleteWhere(String table, String column, int id) async {
    try {
      final db = await database();
      final String whereClause = '$column = ?';
      int noRows = await db.delete(table, where: whereClause, whereArgs: [id]);
      //print(noRows);
      return noRows;
    } catch (error) {
      throw Exception(
          'could not delete from table ' + table + ' : ' + error.toString());
    }
  }

  static Future<List<List<Map<String, dynamic>>>> getMulitipleData(List<String> tables) async {
      
    List<List<Map<String, dynamic>>> out = [];
    try {
      final db = await database();
      for (String table in tables) {
        out.add(await db.query(table));
      }
      return out;
    } catch (error) {
      throw Exception('could not retrieve data from getMulitipleData : ' +
          error.toString());
    }
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    try {
      final db = await database();
      return await db.query(table); // list of maps
    } catch (error) {
      throw Exception(
          'could not retrieve data from ' + table + ' : ' + error.toString());
    }
  }
  static Future<List<Map<String, dynamic>>> getDataLinkWhere(String tableName, String linkTable, String tableField, String linkField, String whereClause) async {
    try {
      final db = await database();
      String sql = "SELECT * FROM " + tableName + " INNER JOIN " + linkTable + " ON " + tableName + "." + tableField + " = " + linkTable + "." + linkField;
      sql = sql + " WHERE " + whereClause;
      //print(sql);
      return await db.rawQuery(sql); // list of maps
    } catch (error) {
      throw Exception(
          'could not retrieve data from ' + tableName + ' : ' + error.toString());
    }    
  }
  /// table is the name of the table
  /// columns is the name of the column to be returned
  /// where is the column name to be integorated
  /// args is an int which is the data
  /// SELECT column FROM table WHERE where = args
  /// Select title from transfers WHERE id = 3
  /// Returns null if no records match
  /// Returns List of Maps if records match
  static Future<List<Map<String, dynamic>>> getDataWhere({required String table, required String columns, required String where, required int args}) async {
      
    try {
      final String whereClause = '$where = ?';
      final db = await database();
      List<Map<String, dynamic>> list = await db.query(table, columns: [columns], where: whereClause, whereArgs: [args]);         
      return list; // list of maps
    } catch (error) {
      throw Exception('table ' + table + ' : ' + error.toString());
    }
  }

  static Future<List<Map<String, dynamic>>> getAllDataFullIntQuery({required String tableName, required List<String> columns, required List<int> args}) async {
      
    try {
      final db = await database();
      String whereClause = getWhereClause(columns);
      List<Map<String, dynamic>> list = await db.query(tableName, where: whereClause, whereArgs: args);          
      return list; // list of maps
    } catch (error) {
      throw Exception('table ' + tableName + ' : ' + error.toString());
    }
  }

  static Future<List<Map<String, dynamic>>> getAllDataWhere({required String table, required int args}) async {      
    try {
      const String whereClause = 'id = ?';
      final db = await database();
      List<Map<String, dynamic>> list = await db.query(table, where: whereClause, whereArgs: [args]);          
      if (list.isEmpty) {
        throw Exception('No id matches : $args');
      }
      return list; // list of maps
    } catch (error) {
      throw Exception('table ' + table + ' : ' + error.toString());
    }
  }

  static Future<List<Map<String, dynamic>>> getAllDataWhereAny({required String table, required String field, required int args}) async {     
    try {
      final String whereClause = '$field = ?';
      final db = await database();
      List<Map<String, dynamic>> list = await db.query(table, where: whereClause, whereArgs: [args]);         
      return list; // list of maps
    } catch (error) {
      throw Exception('table ' + table + ' : ' + error.toString());
    }
  }
  static Future<void> executeStatement({required String statement}) async {
    try{
      final db = await database();
      db.execute(statement);
    } catch(error){
      throw Exception('Executing statement ' + statement + ' : ' + error.toString());
    }
  }
  static Future<bool> isDuplicate({required String table, required String field, required String value}) async {
      
    try {
      final String whereClause = '$field = ?';
      final db = await database();
      List<Map<String, dynamic>> list = await db.query(table,
          columns: [field], where: whereClause, whereArgs: [value]);
      if (list.isEmpty) {
        return false;
      }
      var map = list.first;
      return map.isNotEmpty;
    } catch (error) {
      throw Exception(
          'could not retrieve data from ' + table + ' : ' + error.toString());
    }
  }

  static String getWhereClause(List<String> columns) {
    String _out = '';
    String clause = " = ? AND ";
    for (var column in columns) {
      _out += column + clause;
    }
    _out = _out.substring(0, _out.length - 5);
    return _out;
  }
}
