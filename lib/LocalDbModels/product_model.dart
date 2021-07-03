class ProductModel {
  int _proId;
  String _proType;
  int _proCode;
  String _proName;
  String _proComName;
  String _proCategory;
  int _proCatId;
  int _proPurchasePrice;
  double _proSellingPrice;
  String _proHSNCode;
  String _proTax;
  String _proImage;
  String _proUnit;
  int _proOpeningBal;
  String _proBillingMethod;
  String _proIntegreatedTax;
  String _proDate;
  bool selected = false;
  String _productsale;
  String _productpurchse;
  String _productremaing;
  String _productStockid;

  ProductModel(
      this._proType,
      this._proCode,
      this._proName,
      this._proComName,
      this._proCategory,
      this._proCatId,
      this._proPurchasePrice,
      this._proSellingPrice,
      this._proHSNCode,
      this._proTax,
      this._proImage,
      this._proUnit,
      this._proOpeningBal,
      this._proBillingMethod,
      this._proIntegreatedTax,
      this._proDate);

  ProductModel.withId(
      this._proId,
      this._proType,
      this._proCode,
      this._proName,
      this._proComName,
      this._proCategory,
      this._proCatId,
      this._proPurchasePrice,
      this._proSellingPrice,
      this._proHSNCode,
      this._proTax,
      this._proImage,
      this._proUnit,
      this._proOpeningBal,
      this._proBillingMethod,
      this._proIntegreatedTax,
      this._proDate);

  ProductModel.stocklist(
    this._productpurchse,
    this._productsale,
    this._productremaing,
    this._productStockid,
    this._proComName,
    this._proName,
    this._proCategory,
  );

  String get productsale => _productsale;

  set productsale(String value) {
    _productsale = value;
  }

  String get productStockid => _productStockid;

  set productStockid(String value) {
    _productStockid = value;
  }

  ProductModel.onlyProId(this._proId);

  ProductModel.withIdGST(this._proId, this._proName, this._proCategory,
      this._proSellingPrice, this._proIntegreatedTax);

  ProductModel.withproductname(
    this._proName,
  );
  ProductModel.withProductCompanyName(
    this._proComName,
  );

  int get proId => _proId;

  set proId(int value) {
    _proId = value;
  }

  String get proType => _proType;

  set proType(String value) {
    _proType = value;
  }

  int get proCode => _proCode;

  set proCode(int value) {
    _proCode = value;
  }

  String get proName => _proName;

  set proName(String value) {
    _proName = value;
  }

  String get proComName => _proComName;

  set proComName(String value) {
    _proComName = value;
  }

  String get proCategory => _proCategory;

  set proCategory(String value) {
    _proCategory = value;
  }

  int get proCatId => _proCatId;

  set proCatId(int value) {
    _proCatId = value;
  }

  int get proPurchasePrice => _proPurchasePrice;

  set proPurchasePrice(int value) {
    _proPurchasePrice = value;
  }

  double get proSellingPrice => _proSellingPrice;

  set proSellingPrice(double value) {
    _proSellingPrice = value;
  }

  String get proHSNCode => _proHSNCode;

  set proHSNCode(String value) {
    _proHSNCode = value;
  }

  String get proTax => _proTax;

  set proTax(String value) {
    _proTax = value;
  }

  String get proImage => _proImage;

  set proImage(String value) {
    _proImage = value;
  }

  String get proUnit => _proUnit;

  set proUnit(String value) {
    _proUnit = value;
  }

  int get proOpeningBal => _proOpeningBal;

  set proOpeningBal(int value) {
    _proOpeningBal = value;
  }

  String get proBillingMethod => _proBillingMethod;

  set proBillingMethod(String value) {
    _proBillingMethod = value;
  }

  String get proIntegreatedTax => _proIntegreatedTax;

  set proIntegreatedTax(String value) {
    _proIntegreatedTax = value;
  }

  String get proDate => _proDate;

  set proDate(String value) {
    _proDate = value;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_proId != null) {
      map['pro_id'] = _proId;
    }

    map['pro_type'] = _proType;
    map['pro_code'] = _proCode;
    map['pro_name'] = _proName;
    map['pro_company_name'] = _proComName;
    map['pro_cat_type'] = _proCategory;
    map['cat_id'] = _proCatId;
    map['pro_pur_price'] = _proPurchasePrice;
    map['pro_sell_price'] = _proSellingPrice;
    map['pro_hsn_code'] = _proHSNCode;
    map['pro_tax'] = _proTax;
    map['pro_image'] = _proImage;
    map['pro_unit'] = _proUnit;
    map['pro_opening_balance'] = _proOpeningBal;
    map['pro_bill_method'] = _proBillingMethod;
    map['pro_integrated_tax'] = _proIntegreatedTax;
    map['date'] = _proDate;
    return map;
  }

  // Extract a Note object from a Map object
  ProductModel.fromMapObject(Map<String, dynamic> map) {
    this._proId = map['pro_id'];
    this._proType = map['pro_type'];
    this._proCode = map['pro_code'];
    this._proName = map['pro_name'];
    this._proComName = map['pro_company_name'];
    this._proCategory = map['pro_cat_type'];
    this._proCatId = map['cat_id'];
    this._proPurchasePrice = map['pro_pur_price'];
    this._proSellingPrice = map['pro_sell_price'];
    this._proHSNCode = map['pro_hsn_code'];
    this._proTax = map['pro_tax'];
    this._proImage = map['pro_image'];
    this._proUnit = map['pro_unit'];
    this._proOpeningBal = map['pro_opening_balance'];
    this._proBillingMethod = map['pro_bill_method'];
    this._proIntegreatedTax = map['pro_integrated_tax'];
    this._proDate = map['date'];
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ProductModel.withIdGST(
        int.parse(json['ProductId']),
        json['ProductName'],
        json['ProductCategories'],
        json['ProductSellingPrice'],
        json['IntegratedTax']);
  }
  static List<ProductModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => ProductModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.proId} ${this.proName}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(ProductModel model) {
    return this?.proId == model?.proId;
  }

  @override
  String toString() => proName;

  String get productpurchse => _productpurchse;

  String get productremaing => _productremaing;

  set productremaing(String value) {
    _productremaing = value;
  }

  set productpurchse(String value) {
    _productpurchse = value;
  }
}
