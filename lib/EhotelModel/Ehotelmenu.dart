class Ehotelmenu{

  String _Menu_date;
  String _menu_id;
  String _Menu_Name;
  String _Menu_cat_id;
  String _Menu_Qty_Sum;
  String _Menu_Rate;
  String _Menu_total_amount;
  String _Menu_Cat_Name;


  Ehotelmenu(this._Menu_date, this._menu_id, this._Menu_Name, this._Menu_cat_id,this._Menu_Qty_Sum, this._Menu_Rate,this._Menu_total_amount,this._Menu_Cat_Name);





  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_menu_id != null) {
      map['menu_id'] = _menu_id;
    }
    map['Menu_date'] =  _Menu_date;
    map['Menu_Name'] = _Menu_Name;
    map['Menu_cat_id'] = _Menu_cat_id;
    map['Menu_Qty_Sum'] = _Menu_Qty_Sum;
    map['Menu_Rate'] = _Menu_Rate;
    map['Menu_total_amount'] = _Menu_total_amount;
    map['Menu_Cat_Name'] = _Menu_Cat_Name;
    return map;
  }

// Extract a Note object from a Map object

  Ehotelmenu.fromMapObject(Map<String, dynamic> map) {
    this._menu_id = map['menu_id'];
    this._Menu_date = map['Menu_date'];
    this._Menu_Name = map['Menu_Name'];
    this._Menu_cat_id = map['Menu_cat_id'];
    this._Menu_Qty_Sum = map['Menu_Qty_Sum'];
    this._Menu_Rate = map['Menu_Rate'];
    this._Menu_total_amount = map['Menu_total_amount'];
    this._Menu_Cat_Name = map['Menu_Cat_Name'];
  }

  String get Menu_Cat_Name => _Menu_Cat_Name;

  set Menu_Cat_Name(String value) {
    _Menu_Cat_Name = value;
  }

  String get Menu_total_amount => _Menu_total_amount;

  set Menu_total_amount(String value) {
    _Menu_total_amount = value;
  }

  String get Menu_Rate => _Menu_Rate;

  set Menu_Rate(String value) {
    _Menu_Rate = value;
  }

  String get Menu_Qty_Sum => _Menu_Qty_Sum;

  set Menu_Qty_Sum(String value) {
    _Menu_Qty_Sum = value;
  }

  String get Menu_cat_id => _Menu_cat_id;

  set Menu_cat_id(String value) {
    _Menu_cat_id = value;
  }

  String get Menu_Name => _Menu_Name;

  set Menu_Name(String value) {
    _Menu_Name = value;
  }

  String get menu_id => _menu_id;

  set menu_id(String value) {
    _menu_id = value;
  }

  String get Menu_date => _Menu_date;

  set Menu_date(String value) {
    _Menu_date = value;
  }
}