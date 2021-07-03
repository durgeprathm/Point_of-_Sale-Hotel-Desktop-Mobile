class ProductRate {
  int _proRateId;
  int _proId;
  String _proName;
  String _proCatName;
  String _proDate;
  double _proRate;
  int _proCatId;
  int _proGST;

  ProductRate(this._proId, this._proName, this._proCatName, this._proDate,
      this._proRate, this._proCatId);

  ProductRate.withId(this._proRateId, this._proId, this._proName,
      this._proCatName, this._proDate, this._proRate, this._proCatId,this._proGST);

  int get proRateId => _proRateId;

  set proRateId(int value) {
    _proRateId = value;
  }

  int get proId => _proId;

  set proId(int value) {
    _proId = value;
  }

  String get proName => _proName;

  set proName(String value) {
    _proName = value;
  }

  String get proCatName => _proCatName;

  set proCatName(String value) {
    _proCatName = value;
  }

  String get proDate => _proDate;

  set proDate(String value) {
    _proDate = value;
  }

  double get proRate => _proRate;

  set proRate(double value) {
    _proRate = value;
  }

  int get proCatId => _proCatId;

  set proCatId(int value) {
    _proCatId = value;
  }


  int get proGST => _proGST;

  set proGST(int value) {
    _proGST = value;
  } // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_proRateId != null) {
      map['pro_rate_id'] = _proRateId;
    }

    map['pro_id'] = _proId;
    map['pro_name'] = _proName;
    map['pro_cat_name'] = _proCatName;
    map['pro_date'] = _proDate;
    map['pro_rate'] = _proRate;
    map['cat_id'] = _proCatId;
    return map;
  }

  // Extract a Note object from a Map object
  ProductRate.fromMapObject(Map<String, dynamic> map) {
    this._proRateId = map['pro_rate_id'];
    this._proId = map['pro_id'];
    this._proName = map['pro_name'];
    this._proCatName = map['pro_cat_name'];
    this._proDate = map['pro_date'];
    this._proRate = map['pro_rate'];
    this._proCatId = map['cat_id'];
  }
}
