import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database db;

class DatabaseCreator {

  static const productTable = 'tbl_product_table';
  static const pid = 'pid';
  static const productname = 'pro_name';
  static const productcat = 'pro_cat';
  static const productprice = 'pro_price';
  static const productquntity = 'pro_quant';
  static const productrecption = 'pro_recption';
  static const productexpirydate = 'pro_expiry';
  static const isDeleted = 'isDeleted';


  static void databaseLog(String functionName, String sql,
      [List<Map<String, dynamic>> selectQueryResult, int insertAndUpdateQueryResult, List<dynamic> params]) {
    print(functionName);
    print(sql);
    if (params != null) {
      print(params);
    }
    if (selectQueryResult != null) {
      print(selectQueryResult);
    } else if (insertAndUpdateQueryResult != null) {
      print(insertAndUpdateQueryResult);
    }
  }

  Future<void> createProductTable(Database db) async {

    final productSql = '''CREATE TABLE $productTable
    (
      $pid INTEGER PRIMARY KEY,
      $productname TEXT,
      $productcat INTEGER,
      $productprice INTEGER,
      $productquntity INTEGER,
      $productrecption TEXT,
      $productexpirydate TEXT,
      $isDeleted BIT NOT NULL
    )''';

    await db.execute(productSql);
  }

  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    //make sure the folder exists
    if (await Directory(dirname(path)).exists()) {
      //await deleteDatabase(path);
    } else {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> initDatabase() async {

    final path = await getDatabasePath('retail_db');
    db = await openDatabase(path, version: 1, onCreate: onCreate);
    print(db);

  }

  Future<void> onCreate(Database db, int version) async {
    await createProductTable(db);
  }
}
