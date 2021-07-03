import 'dart:collection';
import 'package:flutter/cupertino.dart';

class Supplier {
  int _Supplierid;
  String _SupplierComapanyName;
  String _SupplierComapanyPersonName;
  String _SupplierMobile;
  String _SupplierEmail;
  String _SupplierAddress;
  String _SupplierUdyogAadhar;
  String _SupplierCINNumber;
  String _SupplierGSTType;
  String _SupplierGSTNumber;
  String _SupplierFAXNumber;
  String _SupplierPANNumber;
  String _SupplierLicenseType;
  String _SupplierLicenseName;
  String _SupplierBankName;
  String _SupplierBankBranch;
  String _SupplierAccountType;
  String _SupplierAccountNumber;
  String _SupplierIFSCCode;
  String _SupplierUPINumber;

  Supplier(
      this._Supplierid,
      this._SupplierComapanyName,
      this._SupplierComapanyPersonName,
      this._SupplierMobile,
      this._SupplierEmail,
      this._SupplierAddress,
      this._SupplierUdyogAadhar,
      this._SupplierCINNumber,
      this._SupplierGSTType,
      this._SupplierGSTNumber,
      this._SupplierFAXNumber,
      this._SupplierPANNumber,
      this._SupplierLicenseType,
      this._SupplierLicenseName,
      this._SupplierBankName,
      this._SupplierBankBranch,
      this._SupplierAccountType,
      this._SupplierAccountNumber,
      this._SupplierIFSCCode,
      this._SupplierUPINumber);

  Supplier.copyWith(
      this._SupplierComapanyName,
      this._SupplierComapanyPersonName,
      this._SupplierMobile,
      this._SupplierEmail,
      this._SupplierAddress,
      this._SupplierUdyogAadhar,
      this._SupplierCINNumber,
      this._SupplierGSTType,
      this._SupplierGSTNumber,
      this._SupplierFAXNumber,
      this._SupplierPANNumber,
      this._SupplierLicenseType,
      this._SupplierLicenseName,
      this._SupplierBankName,
      this._SupplierBankBranch,
      this._SupplierAccountType,
      this._SupplierAccountNumber,
      this._SupplierIFSCCode,
      this._SupplierUPINumber);

  Supplier.cust(this._SupplierLicenseType, this._SupplierLicenseName);

  Supplier.WithIdname(this._Supplierid, this._SupplierComapanyName);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (Supplierid != null) {
      map['Supplier_id'] = _Supplierid;
    }
    map['Supplier_Comapany_Name'] = _SupplierComapanyName;
    map['Supplier_Comapany_Person_Name'] = _SupplierComapanyPersonName;
    map['Supplier_Mobile'] = _SupplierMobile;
    map['Supplier_Email'] = _SupplierEmail;
    map['Supplier_Address'] = _SupplierAddress;
    map['Supplier_Udyog_Aadhar'] = _SupplierUdyogAadhar;
    map['Supplier_CIN_Number'] = _SupplierCINNumber;
    map['Supplier_GST_Type'] = _SupplierGSTType;
    map['Supplier_GST_Number'] = _SupplierGSTNumber;
    map['Supplier_FAX_Number'] = _SupplierFAXNumber;
    map['Supplier_PAN_Number'] = _SupplierPANNumber;
    map['Supplier_License_Type'] = _SupplierLicenseType;
    map['Supplier_License_Name'] = _SupplierLicenseName;
    map['Supplier_Bank_Name'] = _SupplierBankName;
    map['Supplier_Bank_Branch'] = _SupplierBankBranch;
    map['Supplier_Account_Type'] = _SupplierAccountType;
    map['Supplier_Account_Number'] = _SupplierAccountNumber;
    map['Supplier_IFSC_Code'] = _SupplierIFSCCode;
    map['Supplier_UPI_Number'] = _SupplierUPINumber;
    return map;
  }

  Supplier.fromMapObject(Map<String, dynamic> map) {
    this._Supplierid = map['Supplier_id'];
    this._SupplierComapanyName = map['Supplier_Comapany_Name'];
    this._SupplierComapanyPersonName = map['Supplier_Comapany_Person_Name'];
    this._SupplierMobile = map['Supplier_Mobile'];
    this._SupplierEmail = map['Supplier_Email'];
    this._SupplierAddress = map['Supplier_Address'];
    this._SupplierUdyogAadhar = map['Supplier_Udyog_Aadhar'];
    this._SupplierCINNumber = map['Supplier_CIN_Number'];
    this._SupplierGSTType = map['Supplier_GST_Type'];
    this._SupplierGSTNumber = map['Supplier_GST_Number'];
    this._SupplierFAXNumber = map['Supplier_FAX_Number'];
    this._SupplierPANNumber = map['Supplier_PAN_Number'];
    this._SupplierLicenseType = map['Supplier_License_Type'];
    this._SupplierLicenseName = map['Supplier_License_Name'];
    this._SupplierBankName = map['Supplier_Bank_Name'];
    this._SupplierBankBranch = map['Supplier_Bank_Branch'];
    this._SupplierAccountType = map['Supplier_Account_Type'];
    this._SupplierAccountNumber = map['Supplier_Account_Number'];
    this._SupplierIFSCCode = map['Supplier_IFSC_Code'];
    this._SupplierUPINumber = map['Supplier_UPI_Number'];
  }

  String get SupplierUPINumber => _SupplierUPINumber;

  set SupplierUPINumber(String value) {
    _SupplierUPINumber = value;
  }

  String get SupplierIFSCCode => _SupplierIFSCCode;

  set SupplierIFSCCode(String value) {
    _SupplierIFSCCode = value;
  }

  String get SupplierAccountNumber => _SupplierAccountNumber;

  set SupplierAccountNumber(String value) {
    _SupplierAccountNumber = value;
  }

  String get SupplierAccountType => _SupplierAccountType;

  set SupplierAccountType(String value) {
    _SupplierAccountType = value;
  }

  String get SupplierBankBranch => _SupplierBankBranch;

  set SupplierBankBranch(String value) {
    _SupplierBankBranch = value;
  }

  String get SupplierBankName => _SupplierBankName;

  set SupplierBankName(String value) {
    _SupplierBankName = value;
  }

  String get SupplierLicenseName => _SupplierLicenseName;

  set SupplierLicenseName(String value) {
    _SupplierLicenseName = value;
  }

  String get SupplierLicenseType => _SupplierLicenseType;

  set SupplierLicenseType(String value) {
    _SupplierLicenseType = value;
  }

  String get SupplierPANNumber => _SupplierPANNumber;

  set SupplierPANNumber(String value) {
    _SupplierPANNumber = value;
  }

  String get SupplierFAXNumber => _SupplierFAXNumber;

  set SupplierFAXNumber(String value) {
    _SupplierFAXNumber = value;
  }

  String get SupplierGSTNumber => _SupplierGSTNumber;

  set SupplierGSTNumber(String value) {
    _SupplierGSTNumber = value;
  }

  String get SupplierGSTType => _SupplierGSTType;

  set SupplierGSTType(String value) {
    _SupplierGSTType = value;
  }

  String get SupplierCINNumber => _SupplierCINNumber;

  set SupplierCINNumber(String value) {
    _SupplierCINNumber = value;
  }

  String get SupplierUdyogAadhar => _SupplierUdyogAadhar;

  set SupplierUdyogAadhar(String value) {
    _SupplierUdyogAadhar = value;
  }

  String get SupplierAddress => _SupplierAddress;

  set SupplierAddress(String value) {
    _SupplierAddress = value;
  }

  String get SupplierEmail => _SupplierEmail;

  set SupplierEmail(String value) {
    _SupplierEmail = value;
  }

  String get SupplierMobile => _SupplierMobile;

  set SupplierMobile(String value) {
    _SupplierMobile = value;
  }

  String get SupplierComapanyPersonName => _SupplierComapanyPersonName;

  set SupplierComapanyPersonName(String value) {
    _SupplierComapanyPersonName = value;
  }

  String get SupplierComapanyName => _SupplierComapanyName;

  set SupplierComapanyName(String value) {
    _SupplierComapanyName = value;
  }

  int get Supplierid => _Supplierid;

  set Supplierid(int value) {
    _Supplierid = value;
  }

  factory Supplier.fromJson(Map<String, dynamic> n) {
    if (n == null) return null;
    return Supplier.WithIdname(n["SupplierId"], n["SupplierCustomername"]);
  }

  static List<Supplier> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => Supplier.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.Supplierid} ${this.SupplierComapanyName}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(Supplier model) {
    return this?.Supplierid == model?.Supplierid;
  }

  @override
  String toString() => SupplierComapanyName;
}

//-------------------Provider-------------------------------------
class SupplierProvider with ChangeNotifier {
  List<Supplier> _supplierItems = [];

  int get itemCount {
    return _supplierItems.length;
  }

  UnmodifiableListView<Supplier> get pSupplier {
    return UnmodifiableListView(_supplierItems);
  }

  void addSupplierLicence(Supplier item) {
    _supplierItems.add(item);
    notifyListeners();
  }

  void removeItem(Supplier item) {
    _supplierItems.remove(item);
    notifyListeners();
  }

  void clear() {
    _supplierItems.clear();
    notifyListeners();
  }
}
