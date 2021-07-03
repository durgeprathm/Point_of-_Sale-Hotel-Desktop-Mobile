class Menu {
  String _id;
  String _menuName;
  String _menuProductId;
  String _menuProductName;
  String _menuProductQty;
  String _menucategoryId;
  String _menucategory;
  String _menuRate;
  String _menuGst;

  Menu(
      this._id,
      this._menuName,
      this._menuProductId,
      this._menuProductName,
      this._menuProductQty,
      this._menucategoryId,
      this._menucategory,
      this._menuRate,
      this._menuGst);

  Menu.onlymenu(
      this._id,
      this._menuName,
      this._menucategoryId,
      this._menucategory,
      this._menuRate,
      this._menuGst);

  Menu.withname(
      this._id,
      this._menuName,
      this._menuProductId,
      this._menuProductName,
      this._menuProductQty,
      this._menucategoryId,
      this._menuRate,
      this._menuGst,
      this._menucategory);

  String get menuRate => _menuRate;

  set menuRate(String value) {
    _menuRate = value;
  }

  String get menucategory => _menucategory;

  set menucategory(String value) {
    _menucategory = value;
  }

  String get menuProductQty => _menuProductQty;

  set menuProductQty(String value) {
    _menuProductQty = value;
  }

  String get menuProductName => _menuProductName;

  set menuProductName(String value) {
    _menuProductName = value;
  }

  String get menuProductId => _menuProductId;

  set menuProductId(String value) {
    _menuProductId = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get menuName => _menuName;

  set menuName(String value) {
    _menuName = value;
  }

  String get menuGst => _menuGst;

  set menuGst(String value) {
    _menuGst = value;
  }

  String get menucategoryId => _menucategoryId;

  set menucategoryId(String value) {
    _menucategoryId = value;
  }

  factory Menu.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Menu(
        json["MenuId"],
        json["MenuName"],
        json["MenuProductId"],
        json["MenuProductName"],
        json["MenuProductQty"],
        json["Menucategory"],
        json["Menucategioresname"],
        json["MenuRate"],
        json["MenuGST"]);
  }

  static List<Menu> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => Menu.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.menuName}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(Menu model) {
    return this?.id == model?.id;
  }

  @override
  String toString() => menuName;
}
