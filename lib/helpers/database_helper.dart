import 'package:retailerp/Const/add_Supplier_col.dart';
import 'package:retailerp/Const/add_purchase_col.dart';
import 'package:retailerp/Const/add_sales_col.dart';
import 'package:retailerp/Const/add_shop_details_col.dart';
import 'package:retailerp/LocalDbModels/POSModels/product.dart';
import 'package:retailerp/LocalDbModels/customer_model.dart';
import 'package:retailerp/LocalDbModels/product_category.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/LocalDbModels/product_rate.dart';
import 'package:retailerp/models/Purchase.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/models/Shop.dart';
import 'package:retailerp/models/supplier.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database;
  static const productTable = 'tbl_product_table';
  static const tempproductTable = 'tbl_product_temp';
  static const pid = 'pid';
  static const productname = 'pro_name';
  static const productcat = 'pro_cat';
  static const productprice = 'pro_price';
  static const productquntity = 'pro_quant';
  static const productrecption = 'pro_recption';
  static const productexpirydate = 'pro_expiry';
  static const isDeleted = 'isDeleted';

  //Add shop Details

  static const addProductCategoryTable = 'tbl_add_product_category_table';
  static const colProCatId = 'cat_id';
  static const colProductCatName = 'pro_cat_name';
  static const colProductParentId = 'pro_parent_cat_id';
  static const colProductParentName = 'pro_parent_cat_name';

  static const addProductTable = 'tbl_add_product_table';
  static const colProId = 'pro_id';
  static const colProductType = 'pro_type';
  static const colProductCode = 'pro_code';
  static const colProductName = 'pro_name';
  static const colProCompName = 'pro_company_name';
  static const colProductCatType = 'pro_cat_type';
  static const colProPurchasePrice = 'pro_pur_price';
  static const colProSellingPrice = 'pro_sell_price';
  static const colProHSNCode = 'pro_hsn_code';
  static const colProTax = 'pro_tax';
  static const colProImage = 'pro_image';
  static const colProUnit = 'pro_unit';
  static const colProOpeningBalance = 'pro_opening_balance';
  static const colProBillMethod = 'pro_bill_method';
  static const colProIntegrated_Tax = 'pro_integrated_tax';
  static const colDate = 'date';

  static const addProductRateTable = 'tbl_add_product_rate_table';
  static const colProRateId = 'pro_rate_id';
  static const colProDate = 'pro_date';
  static const colProRate = 'pro_rate';

  static const addCutsomerTable = 'tbl_add_customer_table';
  static const colCustId = 'pro_cust_id';
  static const colCustDate = 'cust_date';
  static const colCustName = 'cust_name';
  static const colCustMobNo = 'cust_mob_no';
  static const colCustEmail = 'cust_email';
  static const colCustAddress = 'cust_address';
  static const colCustCreditType = 'cust_credit_type';
  static const colCustTaxSupplier = 'cust_tax_supplier';
  static const colCustType = 'cust_type';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'retailerp.db';
    print('Path of database: $path');
    // Open/create the database at a given path
    var imconnectDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return imconnectDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $productTable($pid INTEGER PRIMARY KEY AUTOINCREMENT, $productname TEXT, '
        '$productcat INTEGER, $productprice INTEGER, $productquntity INTEGER, $productrecption TEXT, $productexpirydate TEXT, $isDeleted BIT NOT NULL)');
    await db.execute(
        'CREATE TABLE $tempproductTable($pid INTEGER PRIMARY KEY AUTOINCREMENT, $productname TEXT, '
        '$productcat INTEGER, $productprice INTEGER, $productquntity INTEGER, $productrecption TEXT, $productexpirydate TEXT, $isDeleted BIT NOT NULL)');
    //Shop_Details
    await db.execute(
        'CREATE TABLE $AddShopDetailsTable($sid INTEGER PRIMARY KEY AUTOINCREMENT, $shopname TEXT, $shopmobilenumber TEXT, '
        '$shopownername TEXT, $shopemail TEXT, $shopgstnumber TEXT, $shopcinnumber TEXT, $shoppannumber TEXT, $shopssinnumber TEXT, $shopaddress TEXT)');
    //purchase
    await db.execute(
        'CREATE TABLE $AddPurchaseTable($Purchaseid INTEGER PRIMARY KEY AUTOINCREMENT, $PurchaseCompnyName TEXT, $PurchaseDate TEXT, $PurchaseProduct TEXT,$PurchaseRate TEXT,$PurchaseQty TEXT,$PurchaseProductSubTotal TEXT,'
        '$PurchaseSubTotal double, $PurchaseDiscount double, $PurchaseGST double, $PurchaseMiscellaneons double, $PurchaseTotal double,$PurchaseNarration TEXT)');
    //Sales
    await db.execute(
        'CREATE TABLE $AddSalesTable($Salesid INTEGER PRIMARY KEY AUTOINCREMENT, $SalesCustomerName TEXT, $SalesDate TEXT, $SalesProduct TEXT,$SalesRate TEXT,$SalesQty TEXT,$SalesProductSubTotal TEXT,'
        '$SalesSubTotal double, $SalesDiscount double, $SalesGST double, $SalesTotal double,$SalesNarration TEXT,$SalesPaymentMode TEXT)');
    //Supplier
    await db.execute(
        'CREATE TABLE $AddSupplierTable($Supplierid INTEGER PRIMARY KEY AUTOINCREMENT, $SupplierComapanyName TEXT, $SupplierComapanyPersonName TEXT, $SupplierMobile TEXT,$SupplierEmail TEXT,$SupplierAddress TEXT,$SupplierUdyogAadhar TEXT,'
        '$SupplierCINNumber TEXT, $SupplierGSTType TEXT, $SupplierGSTNumber TEXT, $SupplierFAXNumber TEXT,$SupplierPANNumber TEXT,$SupplierLicenseType TEXT,$SupplierLicenseName TEXT,$SupplierBankName TEXT,$SupplierBankBranch TEXT,$SupplierAccountType TEXT,$SupplierAccountNumber TEXT,$SupplierIFSCCode TEXT,$SupplierUPINumber TEXT)');

    await db.execute(
        'CREATE TABLE $addProductCategoryTable($colProCatId INTEGER PRIMARY KEY AUTOINCREMENT, $colProductCatName TEXT, '
        '$colProductParentId INTEGER, $colProductParentName TEXT)');

    await db.execute(
        'CREATE TABLE $addProductTable($colProId INTEGER PRIMARY KEY AUTOINCREMENT, $colProductType TEXT, '
        '$colProductCode INTEGER, $colProductName TEXT, $colProCompName TEXT, $colProductCatType TEXT, '
        '$colProCatId INTEGER, $colProPurchasePrice INTEGER, $colProSellingPrice INTEGER, $colProHSNCode TEXT, $colProTax TEXT, '
        '$colProImage TEXT, $colProUnit TEXT, $colProOpeningBalance INTEGER, $colProBillMethod TEXT, $colProIntegrated_Tax TEXT, $colDate TEXT)');

    await db.execute(
        'CREATE TABLE $addProductRateTable($colProRateId INTEGER PRIMARY KEY AUTOINCREMENT, $colProId INTEGER, '
        '$colProductName TEXT, $colProCatId INTEGER, $colProductCatName TEXT, $colProDate TEXT, $colProRate DOUBLE)');

    await db.execute(
        'CREATE TABLE $addCutsomerTable($colCustId INTEGER PRIMARY KEY AUTOINCREMENT, $colCustDate TEXT, '
        '$colCustName TEXT, $colCustMobNo INTEGER, $colCustEmail TEXT, $colCustAddress TEXT, $colCustCreditType TEXT, '
        '$colCustTaxSupplier TEXT, $colCustType INTEGER)');
  }

//
//   Future<List<Map<String, dynamic>>> getTodoMapList() async {
//     Database db = await this.database;
//
// //		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
//     var result = await db.query(productTable, orderBy: '$productname ASC');
//     return result;
//   }

//   Future<List<Map<String, dynamic>>> getTempProductMapList() async {
//     Database db = await this.database;
//
// //		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
//     var result = await db.query(tempproductTable, orderBy: '$pid ASC');
//     return result;
//   }

  // Insert Operation: Insert a _todo object to database
  Future<int> insertTodo(Product product) async {
    Database db = await this.database;
    var result = await db.insert(productTable, product.toMap());
    return result;
  }

  //Insert operation:Insert shop _Details
  Future<int> insertShop(Shop shop) async {
    Database db = await this.database;
    var result = await db.insert(AddShopDetailsTable, shop.toMap());
    return result;
  }

  //Insert operation:Insert Purchase
  Future<int> insertPurchase(Purchase purchase) async {
    Database db = await this.database;
    var result = await db.insert(AddPurchaseTable, purchase.toMap());
    return result;
  }

  //Insert operation:Insert Sales
  Future<int> insertSales(Sales sales) async {
    Database db = await this.database;
    var result = await db.insert(AddSalesTable, sales.toMap());
    return result;
  }

  //Insert operation:Insert Supplier
  Future<int> insertSupplier(Supplier supplier) async {
    Database db = await this.database;
    var result = await db.insert(AddSupplierTable, supplier.toMap());
    return result;
  }

  Future<int> insertTempodo(Product product) async {
    Database db = await this.database;
    var result = await db.insert(tempproductTable, product.toMap());
    return result;
  }

  // Update Operation: Update a _todo object and save it to database
  Future<int> updateTodo(Product product) async {
    var db = await this.database;
    var result = await db.update(productTable, product.toMap(),
        where: '$pid = ?', whereArgs: [product.pid]);
    return result;
  }

// Delete Operation: Delete a _todo object from database
  Future<int> deleteTodo() async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE  FROM $tempproductTable');
    return result;
  }

//temp list
  Future<List<Product>> getTempProdList() async {
    var todoMapList =
        await getTempProductMapList(); // Get 'Map List' from database
    int count =
        todoMapList.length; // Count the number of map entries in db table

    List<Product> productList = List<Product>();
    // For loop to create a '_todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      productList.add(Product.fromMapObject(todoMapList[i]));
    }
    print("Printing/////////////////List Recived $productList");
    return productList;
  }

  //Shop details------------------------------------------------------
  Future<List<Map<String, dynamic>>> getShopMapList() async {
    Database db = await this.database;
//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(AddShopDetailsTable, orderBy: '$sid ASC');
    return result;
  }

  Future<List<Shop>> getShopdetailsList() async {
    var todoMapList = await getShopMapList(); // Get 'Map List' from database
    int count =
        todoMapList.length; // Count the number of map entries in db table

    List<Shop> shopList = List<Shop>();
    // For loop to create a '_todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      shopList.add(Shop.fromMapObject(todoMapList[i]));
    }
    print("Printing/////////////////List Recived ${shopList.length}");
    return shopList;
  }

  ///------------------------------------------------------

  //Purchase-----------------------------------------------
  Future<List<Map<String, dynamic>>> getPurchaseMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(AddPurchaseTable, orderBy: '$Purchaseid ASC');
    return result;
  }

  Future<List<Purchase>> getPurchaseList() async {
    var todoMapList =
        await getPurchaseMapList(); // Get 'Map List' from database
    int count =
        todoMapList.length; // Count the number of map entries in db table

    List<Purchase> PurchaseList = List<Purchase>();
    // For loop to create a '_todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      PurchaseList.add(Purchase.fromMapObject(todoMapList[i]));
    }
    print("Printing/////////////////List Recived ${PurchaseList.length}");
    return PurchaseList;
  }

//----------------------------------------------------------------------------

  //sales-----------------------------------------------
  Future<List<Map<String, dynamic>>> getSalesMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(AddSalesTable, orderBy: '$Salesid ASC');
    return result;
  }

  Future<List<Sales>> getSalesList() async {
    var todoMapList = await getSalesMapList(); // Get 'Map List' from database
    int count =
        todoMapList.length; // Count the number of map entries in db table

    List<Sales> SalesList = List<Sales>();
    // For loop to create a '_todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      SalesList.add(Sales.fromMapObject(todoMapList[i]));
    }
    print("Printing/////////////////List Recived ${SalesList.length}");
    return SalesList;
  }

//----------------------------------------------------------------------------

  //Supplier-----------------------------------------------
  Future<List<Map<String, dynamic>>> getSupplierMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(AddSupplierTable, orderBy: '$Supplierid ASC');
    return result;
  }

  Future<List<Supplier>> getSupplierList() async {
    var todoMapList =
        await getSupplierMapList(); // Get 'Map List' from database
    int count =
        todoMapList.length; // Count the number of map entries in db table

    List<Supplier> SupplierList = List<Supplier>();
    // For loop to create a '_todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      SupplierList.add(Supplier.fromMapObject(todoMapList[i]));
    }
    print("Printing/////////////////List Recived ${SupplierList.length}");
    return SupplierList;
  }

  //Shop delete
  Future<int> deleteShopRecord(int id) async {
    var db = await this.database;
    print('parent Id : ${id}');
    int result = await db.delete(
      '$AddShopDetailsTable',
      where: '$sid = ?',
      whereArgs: [id],
    );

    return result;
  }

//----------------------------------------------------------------------------

// Sanket DB

  Future<List<Map<String, dynamic>>> getTodoMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(productTable, orderBy: '$productname ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getProductCatMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(addProductCategoryTable,
        orderBy: '$colProductCatName DESC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getProductMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(addProductTable, orderBy: '$colProId ASC');

    print(await db.query(DatabaseHelper.addProductTable));

    return result;
  }

  Future<List<Map<String, dynamic>>> getLastProduct() async {
    Database db = await this.database;

    var result =
        await db.query(addProductTable, orderBy: '$colProId DESC', limit: 1);

    print(await db.query(DatabaseHelper.addProductTable));

    return result;
  }

  Future<List<Map<String, dynamic>>> getCustomerMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(addCutsomerTable, orderBy: '$colCustId ASC');

    print(await db.query(DatabaseHelper.addCutsomerTable));

    return result;
  }

  Future<List<Map<String, dynamic>>> getCreditCustomerMapList(
      String custType) async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(addCutsomerTable,
        where: "$colCustCreditType= ?",
        whereArgs: ['$custType'],
        orderBy: '$colCustId ASC');

    print(await db.query(DatabaseHelper.addCutsomerTable));

    return result;
  }

  Future<List<Map<String, dynamic>>> getProductRateMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result =
        await db.query(addProductRateTable, orderBy: '$colProRateId ASC');

    print(await db.query(DatabaseHelper.addProductRateTable));

    return result;
  }

  Future<List<Map<String, dynamic>>> getProductRateMapCustList() async {
    Database db = await this.database;

    var result = await db.rawQuery(
        'SELECT * From $addProductRateTable where $colProRateId IN (SELECT MAX($colProRateId) FROM $addProductRateTable GROUP BY $colProductName)');

    print(await db.query(DatabaseHelper.addProductRateTable));

    return result;
  }

  Future<List<Map<String, dynamic>>> getProductMapData(int id) async {
    Database db = await this.database;
    var result = await db
        .query(addProductTable, where: "$colProId = ?", whereArgs: ['$id']);
    print(await db.query(DatabaseHelper.addProductTable));
    return result;
  }

  Future<List<Map<String, dynamic>>> getProductRateMapData(int id) async {
    Database db = await this.database;
    var result = await db.query(addProductRateTable,
        where: "$colProRateId = ?", whereArgs: ['$id']);
    print(await db.query(DatabaseHelper.addProductRateTable));
    return result;
  }

  Future<List<Map<String, dynamic>>> getCustMapData(int id) async {
    Database db = await this.database;
    var result = await db
        .query(addCutsomerTable, where: "$colCustId = ?", whereArgs: ['$id']);
    print(await db.query(DatabaseHelper.addCutsomerTable));
    return result;
  }

  Future<List<Map<String, dynamic>>> getTempProductMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(tempproductTable, orderBy: '$pid ASC');
    return result;
  }

  // Insert Operation: Insert a _todo object to database
  // Future<int> insertTodo(Product product) async {
  //   Database db = await this.database;
  //   var result = await db.insert(productTable, product.toMap());
  //   return result;
  // }

  Future<int> insertProduct(ProductModel productmodel) async {
    Database db = await this.database;
    var result = await db.insert(addProductTable, productmodel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('insertProduct Row ID: $result');

    return result;
  }

  Future<int> insertProductRate(ProductRate productRate) async {
    Database db = await this.database;
    var result = await db.insert(addProductRateTable, productRate.toMap());
    return result;
  }

  Future<int> insertCustomerData(CustomerModel customerModel) async {
    Database db = await this.database;
    var result = await db.insert(addCutsomerTable, customerModel.toMap());
    return result;
  }

  Future<int> insertAddProductCategory(ProductCategory productCategory) async {
    Database db = await this.database;
    var result =
        await db.insert(addProductCategoryTable, productCategory.toMap());
    return result;
  }

  // Future<int> insertTempodo(Product product) async {
  //   Database db = await this.database;
  //   var result = await db.insert(tempproductTable, product.toMap());
  //   return result;
  // }
  //
  // // Update Operation: Update a _todo object and save it to database
  // Future<int> updateTodo(Product product) async {
  //   var db = await this.database;
  //   var result = await db.update(productTable, product.toMap(),
  //       where: '$pid = ?', whereArgs: [product.pid]);
  //   return result;
  // }

  Future<int> updateProductCategory(ProductCategory productCategory) async {
    var db = await this.database;
    var result = await db.update(
        addProductCategoryTable, productCategory.toMap(),
        where: '$colProCatId = ?', whereArgs: [productCategory.catid]);
    return result;
  }

  Future<int> updateProduct(ProductModel productModel, int id) async {
    var db = await this.database;
    var result = await db.update(addProductTable, productModel.toMap(),
        where: '$colProId = ?', whereArgs: [id]);
    return result;
  }

  Future<int> updateProductRate(String productRate, String date, int id) async {
    var db = await this.database;
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.colProRate: '$productRate',
      DatabaseHelper.colProDate: '$date',
    };

    var result = await db.update(addProductRateTable, row,
        where: '$colProRateId = ?', whereArgs: [id]);
    return result;
  }

  Future<int> updateCustomer(CustomerModel customerModel, int id) async {
    var db = await this.database;
    var result = await db.update(addCutsomerTable, customerModel.toMap(),
        where: '$colCustId = ?', whereArgs: [id]);
    return result;
  }

// Delete Operation: Delete a _todo object from database
//   Future<int> deleteTodo() async {
//     var db = await this.database;
//     int result = await db.rawDelete('DELETE  FROM $tempproductTable');
//     return result;
//   }

  Future<int> deleteProductCateory(int id) async {
    var db = await this.database;
    List<Map<String, dynamic>> parentList = (await db.rawQuery(
        'SELECT * FROM $addProductCategoryTable where $colProductParentId = $id UNION SELECT * FROM $addProductCategoryTable WHERE $colProductParentId IN(SELECT $colProCatId FROM $addProductCategoryTable WHERE $colProductParentId = $id)'));
// 'SELECT * FROM $addProductCategoryTable where $colProductParentId = $id OR $colProCatId = $id'
    // List<Map<String, dynamic>> parentList = (await db.rawQuery(
    //     "SELECT $colProCatId, $colProductCatName, $colProductParentId, $colProductParentName FROM (select * from $addProductCategoryTable order by $colProductParentId, $colProCatId) $colProCatId, (select @pv = $id) initialisation where find_in_set($colProductParentId, @pv) > 0 and @pv = concat(@pv, ',', $colProCatId)"));

    // List<Map<String, dynamic>> parentList = (await db.rawQuery(
    //     'SELECT * FROM $addProductCategoryTable where $colProductParentId = $id OR $colProCatId = $id'));

    print('parentList Length: ${parentList.length}');

    for (int i = 0; i < parentList.length; i++) {
      print('ParentList: ${parentList[i]['cat_id']}');
      await db.delete(
        '$addProductCategoryTable',
        where: '$colProCatId = ?',
        whereArgs: [parentList[i]['cat_id']],
      );
    }

    // int result = 0;
    print('parent Id : ${id}');
    int result =   await db.delete(
      '$addProductCategoryTable',
      where: '$colProCatId = ?',
      whereArgs: [id],
    );

    return result;
  }

  Future<int> deleteProduct(int id) async {
    var db = await this.database;
    print('parent Id : ${id}');
    int result = await db.delete(
      '$addProductTable',
      where: '$colProId = ?',
      whereArgs: [id],
    );

    return result;
  }

  Future<int> deleteProductRate(int id) async {
    var db = await this.database;
    print('parent Id : ${id}');
    int result = await db.delete(
      '$addProductRateTable',
      where: '$colProRateId = ?',
      whereArgs: [id],
    );

    return result;
  }

  Future<int> deleteCustomer(int id) async {
    var db = await this.database;
    print('parent Id : ${id}');
    int result = await db.delete(
      '$addCutsomerTable',
      where: '$colCustId = ?',
      whereArgs: [id],
    );

    return result;
  }

  Future<String> getParentProductName(int id) async {
    print('Id: $id');
    String result;
    var db = await this.database;
    List<Map<String, dynamic>> parentList = (await db.rawQuery(
        'SELECT * FROM $addProductCategoryTable where $colProCatId == $id'));

    List<ProductCategory> productList = List<ProductCategory>();
    for (int i = 0; i < parentList.length; i++) {
      productList.add(ProductCategory.fromMapObject(parentList[i]));
    }

    var temValue;
    productList.forEach((element) {
      temValue = element.pCategoryname;
    });

    result = temValue;
    print('resutlt: $result');
    return result;
  }

  Future<String> getProCatName(int id) async {
    print('Id: $id');
    String result;
    var db = await this.database;
    List<Map<String, dynamic>> parentList = (await db
        .rawQuery('SELECT * FROM $addProductTable where $colProId == $id'));

    List<ProductModel> productList = List<ProductModel>();
    for (int i = 0; i < parentList.length; i++) {
      productList.add(ProductModel.fromMapObject(parentList[i]));
    }

    var temValue;
    productList.forEach((element) {
      temValue = element.proCategory;
    });

    result = temValue;
    print('resutlt: $result');
    return result;
  }

  Future<String> getProdId(String name) async {
    print('name: $name');
    String result;
    var db = await this.database;
    String whereString = '${DatabaseHelper.colProductCatName} = ?';
    String procatname = name;
    List<dynamic> whereArguments = [procatname];
    // List<Map<String, dynamic>> parentList = (await db.rawQuery(
    //     'SELECT * FROM $addProductCategoryTable where $colProductCatName == $name'));
    List<Map<String, dynamic>> parentList = (await db.query(
        DatabaseHelper.addProductCategoryTable,
        where: whereString,
        whereArgs: whereArguments));

    print((await db.query(DatabaseHelper.addProductCategoryTable,
        where: whereString, whereArgs: whereArguments)));

    List<ProductCategory> productList = List<ProductCategory>();
    for (int i = 0; i < parentList.length; i++) {
      productList.add(ProductCategory.fromMapObject(parentList[i]));
    }

    var temValue;
    productList.forEach((element) {
      temValue = element.catid;
    });

    result = temValue;
    print('resutlt: $result');
    return result;
  }

  Future<int> getProdIntId(String name) async {
    print('name: $name');
    int result;
    var db = await this.database;
    String whereString = '${DatabaseHelper.colProductCatName} = ?';
    String procatname = name;
    List<dynamic> whereArguments = [procatname];
    // List<Map<String, dynamic>> parentList = (await db.rawQuery(
    //     'SELECT * FROM $addProductCategoryTable where $colProductCatName == $name'));
    List<Map<String, dynamic>> parentList = (await db.query(
        DatabaseHelper.addProductCategoryTable,
        where: whereString,
        whereArgs: whereArguments));

    print((await db.query(DatabaseHelper.addProductCategoryTable,
        where: whereString, whereArgs: whereArguments)));

    List<ProductCategory> productList = List<ProductCategory>();
    for (int i = 0; i < parentList.length; i++) {
      productList.add(ProductCategory.fromMapObject(parentList[i]));
    }

    var temValue;
    productList.forEach((element) {
      temValue = element.catid;
    });

    result = temValue;
    print('resutlt: $result');
    return result;
  }

  Future<String> getParentProName(int id) async {
    print('Id: $id');
    String result;
    var db = await this.database;
    List<Map<String, dynamic>> parentList = (await db
        .rawQuery('SELECT * FROM $addProductTable where $colProCatId == $id'));

    List<ProductModel> productList = List<ProductModel>();
    for (int i = 0; i < parentList.length; i++) {
      productList.add(ProductModel.fromMapObject(parentList[i]));
    }

    var temValue;
    productList.forEach((element) {
      temValue = element.proCategory;
    });

    result = temValue;
    print('resutlt: $result');
    return result;
  }

  void getRepalceNameProductCat(int id, String name) async {
    print('Id: $id');
    String result;
    var db = await this.database;
    List<Map<String, dynamic>> parentList = (await db.rawQuery(
        'SELECT * FROM $addProductCategoryTable where $colProductParentId == $id'));
    Map<String, dynamic> row = {
      DatabaseHelper.colProductParentName: '$name',
    };
    for (int i = 0; i < parentList.length; i++) {
      int updateCount = await db.update(
          DatabaseHelper.addProductCategoryTable, row,
          where: '${DatabaseHelper.colProductParentId} = ?', whereArgs: [id]);
    }
    // show the results: print all rows in the db
    print(await db.query(DatabaseHelper.addProductCategoryTable));

    // product table - category rename
    List<Map<String, dynamic>> productList = (await db
        .rawQuery('SELECT * FROM $addProductTable where $colProCatId == $id'));
    Map<String, dynamic> productrow = {
      DatabaseHelper.colProductCatType: '$name',
    };

    for (int i = 0; i < productList.length; i++) {
      int updateCount = await db.update(
          DatabaseHelper.addProductTable, productrow,
          where: '${DatabaseHelper.colProCatId} = ?', whereArgs: [id]);
    }

    // productRate table - category rename
    List<Map<String, dynamic>> productRateList = (await db.rawQuery(
        'SELECT * FROM $addProductRateTable where $colProCatId == $id'));
    Map<String, dynamic> productRateRow = {
      DatabaseHelper.colProductCatName: '$name',
    };

    for (int i = 0; i < productRateList.length; i++) {
      int updateCount = await db.update(
          DatabaseHelper.addProductRateTable, productRateRow,
          where: '${DatabaseHelper.colProCatId} = ?', whereArgs: [id]);
    }
  }

  void getRepalceProductName(int id, String name) async {
    print('Id: $id');
    String result;
    var db = await this.database;

    // productRate table - category rename
    List<Map<String, dynamic>> productRateList = (await db
        .rawQuery('SELECT * FROM $addProductRateTable where $colProId == $id'));
    Map<String, dynamic> productRateRow = {
      DatabaseHelper.colProductName: '$name',
    };

    for (int i = 0; i < productRateList.length; i++) {
      int updateCount = await db.update(
          DatabaseHelper.addProductRateTable, productRateRow,
          where: '${DatabaseHelper.colProId} = ?', whereArgs: [id]);
    }
  }

  void getRepalceProductData(int id, double selPrice) async {
    print('Id: $id');
    String result;
    var db = await this.database;

    // productRate table - category rename
    List<Map<String, dynamic>> productList = (await db
        .rawQuery('SELECT * FROM $addProductTable where $colProId == $id'));
    Map<String, dynamic> productPriceRow = {
      DatabaseHelper.colProSellingPrice: '$selPrice',
    };

    for (int i = 0; i < productList.length; i++) {
      int updateCount = await db.update(
          DatabaseHelper.addProductTable, productPriceRow,
          where: '${DatabaseHelper.colProId} = ?', whereArgs: [id]);
    }
  }

// Get number of _todo objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $productTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

// Get the 'Map List' [ List<Map> ] and convert it to '_todo List' [ List<_Todo> ]
  Future<List<Product>> getTodoList() async {
    var todoMapList = await getTodoMapList(); // Get 'Map List' from database
    int count =
        todoMapList.length; // Count the number of map entries in db table

    List<Product> productList = List<Product>();
    // For loop to create a '_todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      productList.add(Product.fromMapObject(todoMapList[i]));
    }
    return productList;
  }

  Future<List<ProductCategory>> getProductCatList() async {
    var productCatMapList =
        await getProductCatMapList(); // Get 'Map List' from database
    int count =
        productCatMapList.length; // Count the number of map entries in db table

    List<ProductCategory> productCatList = List<ProductCategory>();
    // For loop to create a '_todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      productCatList.add(ProductCategory.fromMapObject(productCatMapList[i]));
    }
    return productCatList;
  }

  Future<List<ProductModel>> getProductList() async {
    var productMapList =
        await getProductMapList(); // Get 'Map List' from database
    int count =
        productMapList.length; // Count the number of map entries in db table

    List<ProductModel> productList = List<ProductModel>();
    // For loop to create a '_todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      productList.add(ProductModel.fromMapObject(productMapList[i]));
    }
    return productList;
  }

  Future<List<ProductModel>> getLastProList() async {
    var productMapList =
        await getLastProduct(); // Get 'Map List' from database
    int count =
        productMapList.length; // Count the number of map entries in db table

    List<ProductModel> productList = List<ProductModel>();
    // For loop to create a '_todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      productList.add(ProductModel.fromMapObject(productMapList[i]));
    }
    return productList;
  }

  Future<List<CustomerModel>> getCustomerList() async {
    var customerMapList =
        await getCustomerMapList(); // Get 'Map List' from database
    int count =
        customerMapList.length; // Count the number of map entries in db table

    List<CustomerModel> customerList = List<CustomerModel>();
    // For loop to create a '_todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      customerList.add(CustomerModel.fromMapObject(customerMapList[i]));
    }
    return customerList;
  }

  Future<List<CustomerModel>> getCreditCustomerList(String custType) async {
    var customerMapList = await getCreditCustomerMapList(
        custType); // Get 'Map List' from database
    int count =
        customerMapList.length; // Count the number of map entries in db table

    List<CustomerModel> customerList = List<CustomerModel>();
    // For loop to create a '_todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      customerList.add(CustomerModel.fromMapObject(customerMapList[i]));
    }
    return customerList;
  }

  Future<List<ProductRate>> getProductRateList() async {
    var productRateMapList =
        await getProductRateMapList(); // Get 'Map List' from database
    int count = productRateMapList
        .length; // Count the number of map entries in db table

    List<ProductRate> productRateList = List<ProductRate>();
    // For loop to create a '_todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      productRateList.add(ProductRate.fromMapObject(productRateMapList[i]));
    }
    return productRateList;
  }

  Future<List<ProductRate>> getProductRateCustList() async {
    var productRateMapList =
        await getProductRateMapCustList(); // Get 'Map List' from database
    int count = productRateMapList
        .length; // Count the number of map entries in db table

    print('Cust ProDiuct Rate $count');

    List<ProductRate> productRateList = List<ProductRate>();
    // For loop to create a '_todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      productRateList.add(ProductRate.fromMapObject(productRateMapList[i]));
    }
    return productRateList;
  }

  Future<List<ProductModel>> getProductSingleData(int id) async {
    var productMapList =
        await getProductMapData(id); // Get 'Map List' from database
    int count =
        productMapList.length; // Count the number of map entries in db table

    List<ProductModel> productList = List<ProductModel>();
    // For loop to create a '_todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      productList.add(ProductModel.fromMapObject(productMapList[i]));
    }
    return productList;
  }

  Future<List<ProductRate>> getProductRateSingleData(int id) async {
    var productRateMapList =
        await getProductRateMapData(id); // Get 'Map List' from database
    int count = productRateMapList
        .length; // Count the number of map entries in db table

    List<ProductRate> productRateList = List<ProductRate>();
    // For loop to create a '_todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      productRateList.add(ProductRate.fromMapObject(productRateMapList[i]));
    }
    return productRateList;
  }

  Future<List<CustomerModel>> getCustomerSingleData(int id) async {
    var custMapList = await getCustMapData(id); // Get 'Map List' from database
    int count =
        custMapList.length; // Count the number of map entries in db table

    List<CustomerModel> custList = List<CustomerModel>();
    // For loop to create a '_todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      custList.add(CustomerModel.fromMapObject(custMapList[i]));
    }
    return custList;
  }

  Future close() async {
    var dbClient = await this.database;
    dbClient.close();
  }

  // Pratmesh

//Sales delete
  Future<int> deleteSalesRecord(int id) async {
    var db = await this.database;
    print('parent Id : ${id}');
    int result = await db.delete(
      '$AddSalesTable',
      where: '$Salesid = ?',
      whereArgs: [id],
    );

    return result;
  }

  //Purchase delete
  Future<int> deletePurchaseRecord(int id) async {
    var db = await this.database;
    print('parent Id : ${id}');
    int result = await db.delete(
      '$AddPurchaseTable',
      where: '$Purchaseid = ?',
      whereArgs: [id],
    );

    return result;
  }

  //Supplier delete
  Future<int> deleteSupplierRecord(int id) async {
    var db = await this.database;
    print('parent Id : ${id}');
    int result = await db.delete(
      '$AddSupplierTable',
      where: '$Supplierid = ?',
      whereArgs: [id],
    );

    return result;
  }
}
