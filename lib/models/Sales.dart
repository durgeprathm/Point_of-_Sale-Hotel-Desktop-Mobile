import 'package:retailerp/Repository/database_creator.dart';

class Sales {
  int _Salesid;
  String _SalesCustomerId;
  String _SalesCustomername;
  String _SalesCustomerMobileNo;
  String _SalesDate;
  String _SalesProductId;
  String _SalesProductName;
  String _SalesProductRate;
  String _SalesProductQty;
  String _SalesProductSubTotal;
  String _SalesSubTotal;
  String _SalesDiscount;
  String _SalesGST;
  String _SalesTotal;
  String _SalesNarration;
  String _SalesPaymentMode;
  String _SalesIDs;
  String _SalesPaymentCardType;
  String _SalesCardType;
  String _SalesNameOnCard;
  String _SalesCardNumber;
  String _SalesBankName;
  String _SalesUpiTransationId;

  Sales.withtotalamount(this._SalesTotal);

  Sales(
      this._Salesid,
      this._SalesCustomername,
      this._SalesDate,
      this._SalesProductName,
      this._SalesProductRate,
      this._SalesProductQty,
      this._SalesProductSubTotal,
      this._SalesSubTotal,
      this._SalesDiscount,
      this._SalesGST,
      this._SalesTotal,
      this._SalesNarration,
      this._SalesPaymentMode);

  Sales.copyWithCustId(
      this._SalesCustomerId,
      this._SalesCustomername,
      this._SalesCustomerMobileNo,
      this._SalesDate,
      this._SalesProductId,
      this._SalesProductName,
      this._SalesProductRate,
      this._SalesProductQty,
      this._SalesProductSubTotal,
      this._SalesSubTotal,
      this._SalesDiscount,
      this._SalesGST,
      this._SalesTotal,
      this._SalesNarration,
      this._SalesPaymentMode);

  Sales.copyWith(
      this._SalesCustomername,
      this._SalesDate,
      this._SalesProductName,
      this._SalesProductRate,
      this._SalesProductQty,
      this._SalesProductSubTotal,
      this._SalesSubTotal,
      this._SalesDiscount,
      this._SalesGST,
      this._SalesTotal,
      this._SalesNarration,
      this._SalesPaymentMode);

  Sales.copyWithId(
      this._SalesIDs,
      this._SalesCustomername,
      this._SalesDate,
      this._SalesProductName,
      this._SalesProductRate,
      this._SalesProductQty,
      this._SalesProductSubTotal,
      this._SalesSubTotal,
      this._SalesDiscount,
      this._SalesGST,
      this._SalesTotal,
      this._SalesNarration,
      this._SalesPaymentMode);

  Sales.ManageList(
      this._Salesid,
      this._SalesCustomername,
      this._SalesDate,
      this._SalesProductName,
      this._SalesProductRate,
      this._SalesProductQty,
      this._SalesProductSubTotal,
      this._SalesSubTotal,
      this._SalesDiscount,
      this._SalesGST,
      this._SalesTotal,
      this._SalesNarration,
      this._SalesPaymentMode,
      this._SalesIDs,
      this. _SalesPaymentCardType,
      this. _SalesCardType,
      this. _SalesNameOnCard,
      this. _SalesCardNumber,
      this. _SalesBankName,
      this. _SalesUpiTransationId);






  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (Salesid != null) {
      map['Sales_id'] = _Salesid;
    }
    map['Sales_Customer_Name'] = _SalesCustomername;
    map['Sales_Date'] = _SalesDate;
    map['Sales_Product_Name'] = _SalesProductName;
    map['Sales_Rate'] = _SalesProductRate;
    map['Sales_Quntity'] = _SalesProductQty;
    map['Sales_Product_SubTotal'] = _SalesProductSubTotal;
    map['Sales_SubTotal'] = _SalesSubTotal;
    map['Sales_Discount'] = _SalesDiscount;
    map['Sales_GST'] = _SalesGST;
    map['Sales_Total_Amount'] = _SalesTotal;
    map['Sales_Narration'] = _SalesNarration;
    map['Sales_Payment_Mode'] = _SalesPaymentMode;
    map['Sales_Payment_CardType'] = _SalesPaymentCardType;
    map['Sales_CardType'] = _SalesCardType;
    map['Sales_NameOn_Card'] = _SalesNameOnCard;
    map['Sales_Card_Number'] = _SalesCardNumber;
    map['Sales_Bank_Name'] = _SalesBankName;
    map['Sales_Upi_TransationId'] = _SalesUpiTransationId;
    return map;
  }

  // Extract a Note object from a Map object

  Sales.fromMapObject(Map<String, dynamic> map) {
    this._Salesid = map['Sales_id'];
    this._SalesCustomername = map['Sales_Customer_Name'];
    this._SalesDate = map['Sales_Date'];
    this._SalesProductName = map['Sales_Product_Name'];
    this._SalesProductRate = map['Sales_Rate'];
    this._SalesProductQty = map['Sales_Quntity'];
    this._SalesProductSubTotal = map['Sales_Product_SubTotal'];
    this._SalesSubTotal = map['Sales_SubTotal'];
    this._SalesDiscount = map['Sales_Discount'];
    this._SalesGST = map['Sales_GST'];
    this._SalesTotal = map['Sales_Total_Amount'];
    this._SalesNarration = map['Sales_Narration'];
    this._SalesPaymentMode = map['Sales_Payment_Mode'];
    this._SalesPaymentCardType = map['Sales_Payment_CardType'];
    this._SalesCardType = map['Sales_CardType'];
    this._SalesNameOnCard = map['Sales_NameOn_Card'];
    this._SalesCardNumber = map['Sales_Card_Number'];
    this._SalesBankName = map['Sales_Bank_Name'];
    this._SalesUpiTransationId = map['Sales_Upi_TransationId'];
  }

  String get SalesPaymentMode => _SalesPaymentMode;

  set SalesPaymentMode(String value) {
    _SalesPaymentMode = value;
  }

  String get SalesNarration => _SalesNarration;

  set SalesNarration(String value) {
    _SalesNarration = value;
  }

  String get SalesTotal => _SalesTotal;

  set SalesTotal(String value) {
    _SalesTotal = value;
  }

  String get SalesGST => _SalesGST;

  set SalesGST(String value) {
    _SalesGST = value;
  }

  String get SalesDiscount => _SalesDiscount;

  set SalesDiscount(String value) {
    _SalesDiscount = value;
  }

  String get SalesSubTotal => _SalesSubTotal;

  set SalesSubTotal(String value) {
    _SalesSubTotal = value;
  }

  String get SalesProductSubTotal => _SalesProductSubTotal;

  set SalesProductSubTotal(String value) {
    _SalesProductSubTotal = value;
  }

  String get SalesProductQty => _SalesProductQty;

  set SalesProductQty(String value) {
    _SalesProductQty = value;
  }

  String get SalesProductRate => _SalesProductRate;

  set SalesProductRate(String value) {
    _SalesProductRate = value;
  }

  String get SalesProductName => _SalesProductName;

  set SalesProductName(String value) {
    _SalesProductName = value;
  }

  String get SalesDate => _SalesDate;

  set SalesDate(String value) {
    _SalesDate = value;
  }

  String get SalesCustomername => _SalesCustomername;

  set SalesCustomername(String value) {
    _SalesCustomername = value;
  }

  int get Salesid => _Salesid;

  set Salesid(int value) {
    _Salesid = value;
  }

  String get SalesIDs => _SalesIDs;

  set SalesIDs(String value) {
    _SalesIDs = value;
  }

  String get SalesUpiTransationId => _SalesUpiTransationId;

  set SalesUpiTransationId(String value) {
    _SalesUpiTransationId = value;
  }

  String get SalesBankName => _SalesBankName;

  set SalesBankName(String value) {
    _SalesBankName = value;
  }

  String get SalesCardName => _SalesCardNumber;

  set SalesCardName(String value) {
    _SalesCardNumber = value;
  }

  String get SalesNameOnCard => _SalesNameOnCard;

  set SalesNameOnCard(String value) {
    _SalesNameOnCard = value;
  }

  String get SalesCardType => _SalesCardType;

  set SalesCardType(String value) {
    _SalesCardType = value;
  }

  String get SalesPaymentCardType => _SalesPaymentCardType;

  set SalesPaymentCardType(String value) {
    _SalesPaymentCardType = value;
  }

  String get SalesCardNumber => _SalesCardNumber;

  set SalesCardNumber(String value) {
    _SalesCardNumber = value;
  }

  String get SalesProductId => _SalesProductId;

  set SalesProductId(String value) {
    _SalesProductId = value;
  }

  String get SalesCustomerId => _SalesCustomerId;

  set SalesCustomerId(String value) {
    _SalesCustomerId = value;
  }

  String get SalesCustomerMobileNo => _SalesCustomerMobileNo;

  set SalesCustomerMobileNo(String value) {
    _SalesCustomerMobileNo = value;
  }
}
