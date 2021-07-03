class CustomerModel {
  int _custId;
  String _date;
  String _custName;
  String _custMobileNo;
  String _custEmail;
  String _custAddress;
  String _custCreditType;
  String _taxSupplier;
  int _custType;

  CustomerModel(
      this._date,
      this._custName,
      this._custMobileNo,
      this._custEmail,
      this._custAddress,
      this._custCreditType,
      this._taxSupplier,
      this._custType);

  CustomerModel.withId(
      this._custId,
      this._date,
      this._custName,
      this._custMobileNo,
      this._custEmail,
      this._custAddress,
      this._custCreditType,
      this._taxSupplier,
      this._custType);

  int get custId => _custId;

  set custId(int value) {
    _custId = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get custName => _custName;

  set custName(String value) {
    _custName = value;
  }

  String get custMobileNo => _custMobileNo;

  set custMobileNo(String value) {
    _custMobileNo = value;
  }

  String get custEmail => _custEmail;

  set custEmail(String value) {
    _custEmail = value;
  }

  String get custAddress => _custAddress;

  set custAddress(String value) {
    _custAddress = value;
  }

  String get custCreditType => _custCreditType;

  set custCreditType(String value) {
    _custCreditType = value;
  }

  String get taxSupplier => _taxSupplier;

  set taxSupplier(String value) {
    _taxSupplier = value;
  }

  int get custType => _custType;

  set custType(int value) {
    _custType = value;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_custId != null) {
      map['pro_cust_id'] = _custId;
    }

    map['cust_date'] = _date;
    map['cust_name'] = _custName;
    map['cust_mob_no'] = _custMobileNo;
    map['cust_email'] = _custEmail;
    map['cust_address'] = _custAddress;
    map['cust_credit_type'] = _custCreditType;
    map['cust_tax_supplier'] = _taxSupplier;
    map['cust_type'] = _custType;
    return map;
  }

  // Extract a Note object from a Map object
  CustomerModel.fromMapObject(Map<String, dynamic> map) {
    this._custId = map['pro_cust_id'];
    this._date = map['cust_date'];
    this._custName = map['cust_name'];
    this._custMobileNo = map['cust_mob_no'];
    this._custEmail = map['cust_email'];
    this._custAddress = map['cust_address'];
    this._custCreditType = map['cust_credit_type'];
    this._taxSupplier = map['cust_tax_supplier'];
    this._custType = map['cust_type'];
  }

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return CustomerModel.withId(
        int.parse(json["CustomerId"]),
        json["CustomerDate"],
        json["CustomerName"],
        json["CustomerMobNo"],
        json["CustomerEmail"],
        json["CustomerAddress"],
        json["CustomerCreditType"],
        json["CustomerTaxSupplier"],
        int.parse(json["CustomerType"]));
  }

  static List<CustomerModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => CustomerModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.custId} ${this.custName}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(CustomerModel model) {
    return this?.custId == model?.custId;
  }

  @override
  String toString() => custName;
}
