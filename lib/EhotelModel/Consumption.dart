class Consumption{
  int _consumption_id;
  String _consumption_Date;
  String _consumption_Product_id;
  String _consumption_Quntity;
  String _consumption_Product_Name;
  String _consumption_Opening_Balance;
  String _consumption_Department_Name;
  String _consumption_Department_Id;
  int srno;

  Consumption(this._consumption_id,this._consumption_Date,this._consumption_Department_Id,this._consumption_Department_Name,this._consumption_Opening_Balance,this._consumption_Product_id,this._consumption_Product_Name,this._consumption_Quntity);


  Consumption.withdep(this.srno,this._consumption_Product_id,this._consumption_Product_Name,this._consumption_Opening_Balance,this._consumption_Quntity,this._consumption_Department_Name);





  String get consumption_Department_Id => _consumption_Department_Id;

  set consumption_Department_Id(String value) {
    _consumption_Department_Id = value;
  }

  String get consumption_Department_Name => _consumption_Department_Name;

  set consumption_Department_Name(String value) {
    _consumption_Department_Name = value;
  }

  String get consumption_Opening_Balance => _consumption_Opening_Balance;

  set consumption_Opening_Balance(String value) {
    _consumption_Opening_Balance = value;
  }

  String get consumption_Product_Name => _consumption_Product_Name;

  set consumption_Product_Name(String value) {
    _consumption_Product_Name = value;
  }

  String get consumption_Quntity => _consumption_Quntity;

  set consumption_Quntity(String value) {
    _consumption_Quntity = value;
  }

  String get consumption_Product_id => _consumption_Product_id;

  set consumption_Product_id(String value) {
    _consumption_Product_id = value;
  }

  String get consumption_Date => _consumption_Date;

  set consumption_Date(String value) {
    _consumption_Date = value;
  }

  int get consumption_id => _consumption_id;

  set consumption_id(int value) {
    _consumption_id = value;
  }
}