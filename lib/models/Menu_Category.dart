class MenuCategory{
  String _MenuCatgoryId;
  String _MenuCatgoryName;


  MenuCategory(this._MenuCatgoryId,this._MenuCatgoryName);
  MenuCategory.OnlyName(this._MenuCatgoryName);


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_MenuCatgoryId != null) {
      map['Menu_Catgory_Id'] = _MenuCatgoryId;
    }
    map['Menu_Catgory_Name'] =  _MenuCatgoryName;
    return map;
  }

  // Extract a Note object from a Map object

  MenuCategory.fromMapObject(Map<String, dynamic> map) {
    this._MenuCatgoryId = map['Menu_Catgory_Id'];
    this._MenuCatgoryName = map['Menu_Catgory_Name'];
  }

  String get MenuCatgoryName => _MenuCatgoryName;

  set MenuCatgoryName(String value) {
    _MenuCatgoryName = value;
  }

  String get MenuCatgoryId => _MenuCatgoryId;

  set MenuCatgoryId(String value) {
    _MenuCatgoryId = value;
  }
}