class AccountType{
  int _AccountTypeID;
  String _AccountTypeName;

  AccountType(this._AccountTypeID,this._AccountTypeName);

  String get AccountTypeName => _AccountTypeName;

  set AccountTypeName(String value) {
    _AccountTypeName = value;
  }

  int get AccountTypeID => _AccountTypeID;

  set AccountTypeID(int value) {
    _AccountTypeID = value;
  }

  factory AccountType.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return AccountType(
      int.parse(json["accounttypeids"]),
      json["accounttypename"],
    );
  }

  static List<AccountType> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => AccountType.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.AccountTypeID} ${this.AccountTypeName}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(AccountType model) {
    return this?.AccountTypeID == model?.AccountTypeName;
  }

  @override
  String toString() => AccountTypeName;

}




