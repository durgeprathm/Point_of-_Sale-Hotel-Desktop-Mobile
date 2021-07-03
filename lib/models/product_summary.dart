class ProductSummary {
  String _sesalesid;
  String _sedate;
  String _seproductrate;
  String _productname;
  String _customername;
  String _peproductrate;
  String _peproductMRP;

  ProductSummary(
      this._sesalesid,
      this._sedate,
      this._seproductrate,
      this._productname,
      this._customername,
      this._peproductrate,
      this._peproductMRP);

  String get peproductMRP => _peproductMRP;

  set peproductMRP(String value) {
    _peproductMRP = value;
  }

  String get peproductrate => _peproductrate;

  set peproductrate(String value) {
    _peproductrate = value;
  }

  String get customername => _customername;

  set customername(String value) {
    _customername = value;
  }

  String get productname => _productname;

  set productname(String value) {
    _productname = value;
  }

  String get seproductrate => _seproductrate;

  set seproductrate(String value) {
    _seproductrate = value;
  }

  String get sedate => _sedate;

  set sedate(String value) {
    _sedate = value;
  }

  String get sesalesid => _sesalesid;

  set sesalesid(String value) {
    _sesalesid = value;
  }
}
