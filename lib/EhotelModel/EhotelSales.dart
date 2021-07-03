
class EhotelSales {

  int _menusalesid;
  String _customerid;
  String _customername;
  String _mobilenumber;
  String _medate;
  String _Subtotal;
  String _discount;
  String _totalamount;
  String _payid;
  String  _transcationid;
  String _paypaymodeid;
  String _paymodename;
  String _Narration;
  String _menuid;
  String _menuname;
  String _menuquntity;
  String _menurate;
  String _menugst;
  String _menusubtotal;
  String _waiterId;
  String _waitername;
  int _oilcount;
  String _accounttypename;


  int get oilcount => _oilcount;

  set oilcount(int value) {
    _oilcount = value;
  }
  String get accounttypename => _accounttypename;

  set accounttypename(String value) {
    _accounttypename = value;
  }


  String get waiterId => _waiterId;

  set waiterId(String value) {
    _waiterId = value;
  }

  int get menusalesid => _menusalesid;

  set menusalesid(int value) {
    _menusalesid = value;
  }

  EhotelSales(
      this._menusalesid,
      this._customerid,
      this._customername,
      this._mobilenumber,
      this._medate,
      this._Subtotal,
      this._discount,
      this._totalamount,
      this._payid,
      this._transcationid,
      this._paypaymodeid,
      this._paymodename,
      this._Narration,
      this._menuid,
      this._menuname,
      this._menuquntity,
      this._menurate,
      this._menugst,
      this._menusubtotal,
      this._waiterId,
      this._waitername,
      this._accounttypename);


  EhotelSales.withCount(
      this._menusalesid,
      this._customerid,
      this._customername,
      this._mobilenumber,
      this._medate,
      this._Subtotal,
      this._discount,
      this._totalamount,
      this._payid,
      this._transcationid,
      this._paypaymodeid,
      this._paymodename,
      this._Narration,
      this._menuid,
      this._menuname,
      this._menuquntity,
      this._menurate,
      this._menugst,
      this._menusubtotal,this._waiterId,this._waitername,this._oilcount);


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_menusalesid != null) {
      map['menusalesid'] = _menusalesid;
    }
    map['customerid'] = _customerid;
    map['customername'] = _customername;
    map['mobilenumber'] = _mobilenumber;
    map['medate'] = _medate;
    map['Subtotal'] = _Subtotal;
    map['discount'] = _discount;
    map['totalamount'] = _totalamount;
    map['payid'] = _payid;
    map['transcationid'] = _transcationid;
    map['paypaymodeid'] = _paypaymodeid;
    map['paymodename'] = _paymodename;
    map['Narration'] = _Narration;
    map['menuid'] = _menuid;
    map['menuname'] = _menuname;
    map['menuquntity'] = _menuquntity;
    map['menurate'] = _menurate;
    map['menugst'] = _menugst;
    map['menusubtotal'] = _menusubtotal;
    map['waiterid'] = _waiterId;
    map['waitername'] = _waitername;
    map['oilcount'] = _oilcount;
    return map;
  }

  // Extract a Note object from a Map object

  EhotelSales.fromMapObject(Map<String, dynamic> map) {
    this._menusalesid = map['menusalesid'];
    this._customerid = map['customerid'];
    this._customername = map['customername'];
    this._mobilenumber = map['mobilenumber'];
    this._medate = map['medate'];
    this._Subtotal = map['Subtotal'];
    this._discount = map['discount'];
    this._totalamount = map['totalamount'];
    this._payid = map['payid'];
    this._transcationid = map['transcationid'];
    this._paypaymodeid = map['paypaymodeid'];
    this._paymodename = map['paymodename'];
    this._Narration = map['Narration'];
    this._menuid = map['menuid'];
    this._menuname = map['menuname'];
    this._menuquntity = map['menuquntity'];
    this._menurate = map['menurate'];
    this._menugst = map['menugst'];
    this._menusubtotal = map['menusubtotal'];
    this._waiterId = map['waiterid'] ;
    this._waitername = map['waitername'] ;
    this._oilcount = map['oilcount'] ;
  }


  String get customerid => _customerid;

  set customerid(String value) {
    _customerid = value;
  }

  String get customername => _customername;

  set customername(String value) {
    _customername = value;
  }

  String get mobilenumber => _mobilenumber;

  set mobilenumber(String value) {
    _mobilenumber = value;
  }

  String get medate => _medate;

  set medate(String value) {
    _medate = value;
  }

  String get Subtotal => _Subtotal;

  set Subtotal(String value) {
    _Subtotal = value;
  }

  String get discount => _discount;

  set discount(String value) {
    _discount = value;
  }

  String get totalamount => _totalamount;

  set totalamount(String value) {
    _totalamount = value;
  }

  String get payid => _payid;

  set payid(String value) {
    _payid = value;
  }

  String get transcationid => _transcationid;

  set transcationid(String value) {
    _transcationid = value;
  }

  String get paypaymodeid => _paypaymodeid;

  set paypaymodeid(String value) {
    _paypaymodeid = value;
  }

  String get paymodename => _paymodename;

  set paymodename(String value) {
    _paymodename = value;
  }

  String get Narration => _Narration;

  set Narration(String value) {
    _Narration = value;
  }

  String get menuid => _menuid;

  set menuid(String value) {
    _menuid = value;
  }

  String get menuname => _menuname;

  set menuname(String value) {
    _menuname = value;
  }

  String get menuquntity => _menuquntity;

  set menuquntity(String value) {
    _menuquntity = value;
  }

  String get menurate => _menurate;

  set menurate(String value) {
    _menurate = value;
  }

  String get menugst => _menugst;

  set menugst(String value) {
    _menugst = value;
  }

  String get menusubtotal => _menusubtotal;

  set menusubtotal(String value) {
    _menusubtotal = value;
  }

  String get waitername => _waitername;

  set waitername(String value) {
    _waitername = value;
  }


}