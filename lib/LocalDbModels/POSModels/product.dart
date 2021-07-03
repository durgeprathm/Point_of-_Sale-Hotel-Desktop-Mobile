
import 'package:retailerp/Repository/database_creator.dart';

class Product {

  int _pid;
  String _productname ;
  int _productcat;
  double _productprice;
  int _productquntity;
  String _productrecption;
  String _productexpirydate;
  int _isDeleted;
  double _subTotal;
  String _productimage;
  double _finalSubtotal;
  double _gstperce;


  Product(this._pid, this._productname, this._productcat, this._productprice,this._productquntity, this._productrecption,this._productexpirydate,this._isDeleted);

  Product.copyWith(this._pid,this._productname, this._productprice,this._productquntity,this._isDeleted,this._subTotal,this._finalSubtotal,this._gstperce);

  int get pid => _pid;

  set pid(int value) {
    _pid = value;
  }

  double get finalsubtotal => _finalSubtotal;

  set finalsubtotal(double value) {
    _finalSubtotal = value;
  }


  double get gstperce => _gstperce;

  set gstperce(double value) {
    _gstperce = value;
  }

  String get productimage => _productimage;

  set productimage(String value) {
    _productimage = value;
  }

  double get subTotal => _subTotal;

  set subTotal(double value) {
    _subTotal = value;
  }

  String get productname => _productname;

  set productname(String value) {
    this._productname = value;
  }

  void increaseQuanity(){
    _productquntity ++;
    print('Here I am Inside inc two $_productquntity');
  }

  void decreaseQuanity(){
      _productquntity --;
  }

  void updateSubTotal(){
   _subTotal = _subTotal + _productprice;
//   getFinalSubtotal(_subTotal);
  }

//  double getFinalSubtotal(int subTotal){
//    print("khjfkbghjlb////$_finalSubtotal");
//    if(_finalSubtotal == null){
//      print("khjfkbghjlb////$_finalSubtotal");
//      return _finalSubtotal = _finalSubtotal +  subTotal;
//    }
//  }

  double getFinalSubtotalminus(){
    return _finalSubtotal = _finalSubtotal -  _subTotal;
  }


  void deupdateSubTotal(){
    _subTotal = _subTotal - _productprice ;
  }

  int get productcat => _productcat;

  set productcat(int value) {
    this._productcat = value;
  }

  double get productprice => _productprice;

  set productprice(double value) {
    this._productprice = value;
  }

  int get productquntity => _productquntity;

  set productquntity(int value) {
    this._productquntity = value;
  }

  String get productrecption => _productrecption;

  set productrecption(String value) {
    this._productrecption = value;
  }

  String get productexpirydate => _productexpirydate;

  set productexpirydate(String value) {
    this._productexpirydate = value;
  }

  int get isDeleted => _isDeleted;

  set isDeleted(int value) {
    this._isDeleted = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_pid != null) {
      map['pid'] = _pid;
    }
    map['pro_name'] =  _productname;
    map['pro_cat'] = _productcat;
    map['pro_price'] = _productprice;
    map['pro_quant'] = _productquntity;
    map['pro_recption'] = _productrecption;
    map['pro_expiry'] = _productexpirydate;
    map['isDeleted'] = _isDeleted;
    return map;
  }

// Extract a Note object from a Map object

  Product.fromMapObject(Map<String, dynamic> map) {
    this._pid = map['pid'];
    this._productname = map['pro_name'];
    this._productcat = map['pro_cat'];
    this._productprice = map['pro_price'];
    this._productquntity = map['pro_quant'];
    this._productrecption = map['pro_recption'];
    this._productexpirydate = map['pro_expiry'];
    this._isDeleted = map['isDeleted'];

  }
}



//Product.fromJson(Map<String, dynamic> json) {
//    this.pid = json[DatabaseCreator.pid];
//    this.productname = json[DatabaseCreator.productname];
//    this.productcat = json[DatabaseCreator.productcat];
//    this.productprice = json[DatabaseCreator.productprice];
//    this.productquntity = json[DatabaseCreator.productquntity];
//    this.productrecption = json[DatabaseCreator.productrecption];
//    this.productexpirydate = json[DatabaseCreator.productexpirydate];
//    this.isDeleted = json[DatabaseCreator.isDeleted] == 1;
//  }