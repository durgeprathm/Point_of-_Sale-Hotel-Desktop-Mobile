
import 'package:retailerp/Repository/database_creator.dart';

class Shop {

  int _sid;
  String _shopname ;
  String _shopmobilenumber;
  String _shopownername;
  String _shopemail;
  String _shopgstnumber;
  String _shopcinnumber;
  String _shoppannumber;
  String _shopssinnumber;
  String _shopaddress;
  String _shoplogo;


  Shop(this._sid, this._shopname, this._shopmobilenumber, this._shopownername,this._shopemail, this._shopgstnumber,this._shopcinnumber,this._shoppannumber, this._shopssinnumber,this._shopaddress,this._shoplogo);

  Shop.copyWith(this._shopname, this._shopmobilenumber, this._shopownername,this._shopemail, this._shopgstnumber,this._shopcinnumber,this._shoppannumber, this._shopssinnumber,this._shopaddress,this._shoplogo);

  Shop.Withoutlogo(this._sid, this._shopname, this._shopmobilenumber, this._shopownername,this._shopemail, this._shopgstnumber,this._shopcinnumber,this._shoppannumber, this._shopssinnumber,this._shopaddress);


  int get sid => _sid;

  set sid(int value) {
    _sid = value;
  }

  String get shoplogo => _shoplogo;

  set shoplogo(String value) {
    _shoplogo = value;
  }

  String get shopname => _shopname;

  set shopname(String value) {
    _shopname = value;
  }

  String get shopmobilenumber => _shopmobilenumber;

  set shopmobilenumber(String value) {
    _shopmobilenumber = value;
  }

  String get shopownername => _shopownername;

  set shopownername(String value) {
    _shopownername = value;
  }

  String get shopemail => _shopemail;

  set shopemail(String value) {
    _shopemail = value;
  }

  String get shopgstnumber => _shopgstnumber;

  set shopgstnumber(String value) {
    _shopgstnumber = value;
  }

  String get shopcinnumber => _shopcinnumber;

  set shopcinnumber(String value) {
    _shopcinnumber = value;
  }

  String get shoppannumber => _shoppannumber;

  set shoppannumber(String value) {
    _shoppannumber = value;
  }

  String get shopssinnumber => _shopssinnumber;

  set shopssinnumber(String value) {
    _shopssinnumber = value;
  }

  String get shopaddress => _shopaddress;

  set shopaddress(String value) {
    _shopaddress = value;
  }


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (sid != null) {
      map['sid'] = _sid;
    }
    map['shop_name'] =  _shopname;
    map['Shop_mobilenumber'] = _shopmobilenumber;
    map['shop_ownername'] = _shopownername;
    map['shop_email'] = _shopemail;
    map['shop_gstnumber'] = _shopgstnumber;
    map['shop_cinnumber'] = _shopcinnumber;
    map['shop_pannumber'] = _shoppannumber;
    map['shop_ssinnumber'] = _shopssinnumber;
    map['shop_address'] = _shopaddress;
    map['shop_logo'] = _shoplogo;
    return map;
  }

// Extract a Note object from a Map object

  Shop.fromMapObject(Map<String, dynamic> map) {
    this._sid = map['sid'];
    this._shopname = map['shop_name'];
    this._shopmobilenumber = map['Shop_mobilenumber'];
    this._shopownername = map['shop_ownername'];
    this._shopemail = map['shop_email'];
    this._shopgstnumber = map['shop_gstnumber'];
    this._shopcinnumber = map['shop_cinnumber'];
    this._shoppannumber = map['shop_pannumber'];
    this._shopssinnumber = map['shop_ssinnumber'];
    this._shopaddress = map['shop_address'];
    this._shoplogo = map['shop_logo'];

  }


}
