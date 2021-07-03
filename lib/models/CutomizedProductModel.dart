class CustoProductModel{

  String _cpid;
  String _cpname;
  String _cpprice;
  String _cpdate;
  String _pid;
  String _pname;
  String _pqty;
  String _pcatid;

  CustoProductModel(this._cpid, this._cpname, this._cpprice, this._cpdate,
      this._pid, this._pname, this._pqty, this._pcatid);

  String get pcatid => _pcatid;

  set pcatid(String value) {
    _pcatid = value;
  }

  String get pqty => _pqty;

  set pqty(String value) {
    _pqty = value;
  }

  String get pname => _pname;

  set pname(String value) {
    _pname = value;
  }

  String get pid => _pid;

  set pid(String value) {
    _pid = value;
  }

  String get cpdate => _cpdate;

  set cpdate(String value) {
    _cpdate = value;
  }

  String get cpprice => _cpprice;

  set cpprice(String value) {
    _cpprice = value;
  }

  String get cpname => _cpname;

  set cpname(String value) {
    _cpname = value;
  }

  String get cpid => _cpid;

  set cpid(String value) {
    _cpid = value;
  }


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_cpid != null) {
      map['cat_id'] = _cpid;
    }
    map['pro_cat_name'] = _cpname;
    return map;
  }

  // Extract a Note object from a Map object
  CustoProductModel.fromMapObject(Map<String, dynamic> map) {
    this._cpid = map['CustomizedProductId'];
    this._cpname = map['CustomizedProductName'];
    this._cpprice = map['CustomizedProductPrice'];
    this._cpdate = map['CustomizedProductDate'];
    this._pid = map['Productid'];
    this._pname = map['Productname'];
    this._pqty = map['Productquntity'];
    this._pcatid = map['Productcatid'];
  }

  factory CustoProductModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return CustoProductModel(
      json['CustomizedProductId'],
        json['CustomizedProductName'],
      json['CustomizedProductPrice'],
        json['CustomizedProductDate'],
      json['Productid'],
        json['Productname'],
      json['Productquntity'],
        json['Productcatid'],
    );
  }

  static List<CustoProductModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => CustoProductModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this._cpid} ${this._cpname}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(CustoProductModel model) {
    return this?._cpid == model?._cpid;
  }

  @override
  String toString() => _cpname;

}