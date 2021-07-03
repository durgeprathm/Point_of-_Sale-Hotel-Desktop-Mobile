class LedgerPayTypeModel {
  String _ledgerId;
  String _ledgerPaymodename;
  String _ledgeraccounttypeid;
  String _accounttypename;

  LedgerPayTypeModel(this._ledgerId, this._ledgerPaymodename,
      this._ledgeraccounttypeid, this._accounttypename);

  String get ledgerId => _ledgerId;

  set ledgerId(String value) {
    _ledgerId = value;
  }

  String get accounttypename => _accounttypename;

  set accounttypename(String value) {
    _accounttypename = value;
  }

  String get ledgeraccounttypeid => _ledgeraccounttypeid;

  set ledgeraccounttypeid(String value) {
    _ledgeraccounttypeid = value;
  }

  String get ledgerPaymodename => _ledgerPaymodename;

  set ledgerPaymodename(String value) {
    _ledgerPaymodename = value;
  }

  factory LedgerPayTypeModel.fromJson(Map<String, dynamic> n) {
    if (n == null) return null;
    return LedgerPayTypeModel(n["ledgerId"], n["ledgerPaymodename"],
        n["ledgeraccounttypeid"], n["accounttypename"]);
  }

  static List<LedgerPayTypeModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => LedgerPayTypeModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.ledgerId} ${this.ledgerPaymodename}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(LedgerPayTypeModel model) {
    return this?.ledgerId == model?.ledgerId;
  }

  @override
  String toString() => ledgerPaymodename;
}
