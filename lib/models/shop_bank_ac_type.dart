class ShopBankACType {
  String _shopBankId;
  String _shopBankName;

  ShopBankACType(this._shopBankId, this._shopBankName);

  String get shopBankId => _shopBankId;

  set shopBankId(String value) {
    _shopBankId = value;
  }

  String get shopBankName => _shopBankName;

  set shopBankName(String value) {
    _shopBankName = value;
  }

  factory ShopBankACType.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ShopBankACType(
      json["ShopBankId"],
      json["ShopBankName"],
    );
  }

  static List<ShopBankACType> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => ShopBankACType.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.shopBankId} ${this.shopBankName}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(ShopBankACType model) {
    return this?.shopBankId == model?.shopBankName;
  }

  @override
  String toString() => shopBankName;
}
