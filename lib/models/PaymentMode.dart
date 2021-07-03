class AllPaymentModeType{
  String _PaymentModeId;
  String _PaymentModeName;
  String _AccountType;

  AllPaymentModeType(this._PaymentModeId, this._PaymentModeName);

  String get PaymentModeId => _PaymentModeId;

  set PaymentModeId(String value) {
    _PaymentModeId = value;
  }

  String get PaymentModeName => _PaymentModeName;

  set PaymentModeName(String value) {
    _PaymentModeName = value;
  }

  String get AccountType => _AccountType;

  set AccountType(String value) {
    _AccountType = value;
  }

  factory AllPaymentModeType.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return AllPaymentModeType(
        json['paymentmodeid'],
        json['paymodename']);
  }

  static List<AllPaymentModeType> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => AllPaymentModeType.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.PaymentModeId} ${this.PaymentModeName}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(AllPaymentModeType model) {
    return this?.PaymentModeId == model?.PaymentModeId;
  }


  @override
  String toString() => PaymentModeName;

}
