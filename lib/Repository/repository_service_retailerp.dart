//import 'package:retailerp/LocalDbModels/product.dart';
//import 'database_creator.dart';
//
//class RepositoryServiceTodo {
//
//  static Future<List<Product>> getAllTodos() async {
//    final sql = '''SELECT * FROM ${DatabaseCreator.productTable}
//    WHERE ${DatabaseCreator.isDeleted} = 0''';
//    final data = await db.rawQuery(sql);
//    List<Product> todos = List();
//
//    for (final node in data) {
//      final todo = Product.fromJson(node);
//      todos.add(todo);
//    }
//    return todos;
//  }
//
//  static Future<Product> getTodo(int id) async {
//    //final sql = '''SELECT * FROM ${DatabaseCreator.todoTable}
//    //WHERE ${DatabaseCreator.id} = $id''';
//    //final data = await db.rawQuery(sql);
//
//    final sql = '''SELECT * FROM ${DatabaseCreator.productTable}
//    WHERE ${DatabaseCreator.pid} = ?''';
//
//    List<dynamic> params = [id];
//    final data = await db.rawQuery(sql, params);
//
//    final todo = Product.fromJson(data.first);
//    return todo;
//  }
//
//  static Future<void> addTodo(Product product) async {
//    /*final sql = '''INSERT INTO ${DatabaseCreator.todoTable}
//    (
//      ${DatabaseCreator.id},
//      ${DatabaseCreator.name},
//      ${DatabaseCreator.info},
//      ${DatabaseCreator.isDeleted}
//    )
//    VALUES
//    (
//      ${todo.id},
//      "${todo.name}",
//      "${todo.info}",
//      ${todo.isDeleted ? 1 : 0}
//    )''';*/
//
//    final sql = '''INSERT INTO ${DatabaseCreator.productTable}
//    (
//      ${DatabaseCreator.pid},
//      ${DatabaseCreator.productname},
//      ${DatabaseCreator.productcat},
//      ${DatabaseCreator.productprice},
//      ${DatabaseCreator.productquntity},
//      ${DatabaseCreator.productrecption},
//      ${DatabaseCreator.productexpirydate},
//      ${DatabaseCreator.isDeleted}
//
//    )
//    VALUES (?,?,?,?,?,?,?,?)''';
//    List<dynamic> params = [product.pid, product.productname, product.productcat,product.productprice,product.productquntity,product.productrecption,product.productexpirydate, product.isDeleted ? 1 : 0];
//    final result = await db.rawInsert(sql, params);
//    DatabaseCreator.databaseLog('Add product', sql, null, result, params);
//  }
//
//  static Future<void> deleteTodo(Product product) async {
//    /*final sql = '''UPDATE ${DatabaseCreator.todoTable}
//    SET ${DatabaseCreator.isDeleted} = 1
//    WHERE ${DatabaseCreator.id} = ${todo.id}
//    ''';*/
//
//    final sql = '''UPDATE ${DatabaseCreator.productTable}
//    SET ${DatabaseCreator.isDeleted} = 1
//    WHERE ${DatabaseCreator.pid} = ?
//    ''';
//
//    List<dynamic> params = [product.pid];
//    final result = await db.rawUpdate(sql, params);
//
//    DatabaseCreator.databaseLog('Delete todo', sql, null, result, params);
//  }
//
//  static Future<void> updateTodo(Product product) async {
//    /*final sql = '''UPDATE ${DatabaseCreator.todoTable}
//    SET ${DatabaseCreator.name} = "${todo.name}"
//    WHERE ${DatabaseCreator.id} = ${todo.id}
//    ''';*/
//
//    final sql = '''UPDATE ${DatabaseCreator.productTable}
//    SET ${DatabaseCreator.productname} = ?
//    WHERE ${DatabaseCreator.pid} = ?
//    ''';
//
//    List<dynamic> params = [product.productname, product.pid];
//    final result = await db.rawUpdate(sql, params);
//
//    DatabaseCreator.databaseLog('Update product', sql, null, result, params);
//  }
//
//  static Future<int> productsCount() async {
//    final data = await db.rawQuery('''SELECT COUNT(*) FROM ${DatabaseCreator.productTable}''');
//
//    int count = data[0].values.elementAt(0);
//    int idForNewItem = count++;
//    return idForNewItem;
//  }
//}
