class LedgerModel {
  String _ledgerId;
  String _ledgerCustomername;
  String _ledgerComapanyPersonName;
  String _ledgerMobileNumber;
  String _ledgerEmail;
  String _ledgerAddress;
  String _ledgerUdyogAadhar;
  String _ledgerCINNumber;
  String _ledgerGSTType;
  String _ledgerGSTNumber;
  String _ledgerFAXNumber;
  String _ledgerPANNumber;
  String _ledgerLicenseType;
  String _ledgerLicenseName;
  String _ledgerBankName;
  String _ledgerBankBranch;
  String _ledgerAccountType;
  String _ledgerAccountNumber;
  String _ledgerIFSCCode;
  String _ledgerUPINumber;

  LedgerModel(
      this._ledgerId,
      this._ledgerCustomername,
      this._ledgerComapanyPersonName,
      this._ledgerMobileNumber,
      this._ledgerEmail,
      this._ledgerAddress,
      this._ledgerUdyogAadhar,
      this._ledgerCINNumber,
      this._ledgerGSTType,
      this._ledgerGSTNumber,
      this._ledgerFAXNumber,
      this._ledgerPANNumber,
      this._ledgerLicenseType,
      this._ledgerLicenseName,
      this._ledgerBankName,
      this._ledgerBankBranch,
      this._ledgerAccountType,
      this._ledgerAccountNumber,
      this._ledgerIFSCCode,
      this._ledgerUPINumber);


  factory LedgerModel.fromJson(Map<String, dynamic> n) {
    if (n == null) return null;
    return LedgerModel(
      n["ledgerId"],
      n["ledgerCustomername"],
      n["ledgerComapanyPersonName"],
      n["ledgerMobileNumber"],
      n["ledgerEmail"],
      n["ledgerAddress"],
      n["ledgerUdyogAadhar"],
      n["ledgerCINNumber"],
      n["ledgerGSTType"],
      n["ledgerGSTNumber"],
      n["ledgerFAXNumber"],
      n["ledgerPANNumber"],
      n["ledgerLicenseType"],
      n["ledgerLicenseName"],
      n["ledgerBankName"],
      n["ledgerBankBranch"],
      n["ledgerAccountType"],
      n["ledgerAccountNumber"],
      n["ledgerIFSCCode"],
      n["ledgerUPINumber"],
    );
  }

  String get ledgerId => _ledgerId;

  set ledgerId(String value) {
    _ledgerId = value;
  }

  String get ledgerCustomername => _ledgerCustomername;

  set ledgerCustomername(String value) {
    _ledgerCustomername = value;
  }

  String get ledgerComapanyPersonName => _ledgerComapanyPersonName;

  set ledgerComapanyPersonName(String value) {
    _ledgerComapanyPersonName = value;
  }

  String get ledgerMobileNumber => _ledgerMobileNumber;

  set ledgerMobileNumber(String value) {
    _ledgerMobileNumber = value;
  }

  String get ledgerEmail => _ledgerEmail;

  set ledgerEmail(String value) {
    _ledgerEmail = value;
  }

  String get ledgerAddress => _ledgerAddress;

  set ledgerAddress(String value) {
    _ledgerAddress = value;
  }

  String get ledgerUdyogAadhar => _ledgerUdyogAadhar;

  set ledgerUdyogAadhar(String value) {
    _ledgerUdyogAadhar = value;
  }

  String get ledgerCINNumber => _ledgerCINNumber;

  set ledgerCINNumber(String value) {
    _ledgerCINNumber = value;
  }

  String get ledgerGSTType => _ledgerGSTType;

  set ledgerGSTType(String value) {
    _ledgerGSTType = value;
  }

  String get ledgerGSTNumber => _ledgerGSTNumber;

  set ledgerGSTNumber(String value) {
    _ledgerGSTNumber = value;
  }

  String get ledgerFAXNumber => _ledgerFAXNumber;

  set ledgerFAXNumber(String value) {
    _ledgerFAXNumber = value;
  }

  String get ledgerPANNumber => _ledgerPANNumber;

  set ledgerPANNumber(String value) {
    _ledgerPANNumber = value;
  }

  String get ledgerLicenseType => _ledgerLicenseType;

  set ledgerLicenseType(String value) {
    _ledgerLicenseType = value;
  }

  String get ledgerLicenseName => _ledgerLicenseName;

  set ledgerLicenseName(String value) {
    _ledgerLicenseName = value;
  }

  String get ledgerBankName => _ledgerBankName;

  set ledgerBankName(String value) {
    _ledgerBankName = value;
  }

  String get ledgerBankBranch => _ledgerBankBranch;

  set ledgerBankBranch(String value) {
    _ledgerBankBranch = value;
  }

  String get ledgerAccountType => _ledgerAccountType;

  set ledgerAccountType(String value) {
    _ledgerAccountType = value;
  }

  String get ledgerAccountNumber => _ledgerAccountNumber;

  set ledgerAccountNumber(String value) {
    _ledgerAccountNumber = value;
  }

  String get ledgerIFSCCode => _ledgerIFSCCode;

  set ledgerIFSCCode(String value) {
    _ledgerIFSCCode = value;
  }

  String get ledgerUPINumber => _ledgerUPINumber;

  set ledgerUPINumber(String value) {
    _ledgerUPINumber = value;
  }

  static List<LedgerModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => LedgerModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.ledgerId} ${this.ledgerCustomername}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(LedgerModel model) {
    return this?.ledgerId == model?.ledgerId;
  }

  @override
  String toString() => ledgerCustomername;
}
