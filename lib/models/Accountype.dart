class AllAccountType{
  String _AccountTypeID;
  String _AccountTypeName;


  AllAccountType(this._AccountTypeID, this._AccountTypeName);



  factory AllAccountType.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return AllAccountType(
        json['accounttypeids'],
        json['accounttypename']);
  }

  static List<AllAccountType> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => AllAccountType.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.AccountTypeID} ${this.AccountTypeName}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(AllAccountType model) {
    return this?.AccountTypeID == model?.AccountTypeID;
  }


  @override
  String toString() => AccountTypeName;

  String get AccountTypeName => _AccountTypeName;

  set AccountTypeName(String value) {
    _AccountTypeName = value;
  }

  String get AccountTypeID => _AccountTypeID;

  set AccountTypeID(String value) {
    _AccountTypeID = value;
  }
}
