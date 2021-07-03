class ProductCategory {
  int _catid;
  String _pCategoryname;
  int _pParentCategoryId;
  String _pParentCategoryName;

  bool operator ==(o) =>
      o is ProductCategory &&
      o._pCategoryname == _pCategoryname &&
      o._catid == _catid &&
      o._pParentCategoryId == _pParentCategoryId &&
      o._pParentCategoryName == _pParentCategoryName;

  ProductCategory(
      this._pCategoryname, this._pParentCategoryId, this._pParentCategoryName);

  ProductCategory.withIdParent(
      this._catid, this._pCategoryname, this._pParentCategoryId);

  ProductCategory.withId(this._catid, this._pCategoryname,
      this._pParentCategoryId, this._pParentCategoryName);

  int get pParentCategoryId => _pParentCategoryId;

  set pParentCategoryId(int value) {
    _pParentCategoryId = value;
  }

  String get pCategoryname => _pCategoryname;

  set pCategoryname(String value) {
    _pCategoryname = value;
  }

  int get catid => _catid;

  set catid(int value) {
    _catid = value;
  }

  String get pParentCategoryName => _pParentCategoryName;

  set pParentCategoryName(String value) {
    _pParentCategoryName = value;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (catid != null) {
      map['cat_id'] = _catid;
    }
    map['pro_cat_name'] = _pCategoryname;

    if (_pParentCategoryId != null) {
      map['pro_parent_cat_id'] = _pParentCategoryId;
    }
    if (_pParentCategoryName != null) {
      map['pro_parent_cat_name'] = _pParentCategoryName;
    }
    return map;
  }

  // Extract a Note object from a Map object
  ProductCategory.fromMapObject(Map<String, dynamic> map) {
    this._catid = map['cat_id'];
    this._pCategoryname = map['pro_cat_name'];
    this._pParentCategoryId = map['pro_parent_cat_id'];
    this._pParentCategoryName = map['pro_parent_cat_name'];
  }

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ProductCategory.withId(
        int.parse(json['ProductCategoriesId']),
        json['ProductCategoriesName'],
        int.parse(json['productCategioresParentId']),
        json['productCategioresParentName']);
  }

  static List<ProductCategory> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => ProductCategory.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.pParentCategoryId} ${this.pCategoryname}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(ProductCategory model) {
    return this?.pParentCategoryId == model?.pParentCategoryId;
  }

  @override
  String toString() => pCategoryname;
}
