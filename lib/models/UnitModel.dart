import 'dart:convert';

class UnitModel{

  String _unitid;
  String _unitname;

  UnitModel(this._unitid, this._unitname);

  String get unitname => _unitname;

  set unitname(String value) {
    _unitname = value;
  }

  String get unitid => _unitid;

  set unitid(String value) {
    _unitid = value;
  }


  // factory UnitModel.fromJson(String json) {
  //   var tagsJson = jsonDecode(json)['unitlist'];
  //   if (tagsJson == null) return null;
  //   return UnitModel(
  //     tagsJson["unitid"],
  //     tagsJson["unitname"],
  //   );
  // }
  //
  // static List<UnitModel> fromJsonList(List list) {
  //   if (list == null) return null;
  //   return list.map((item) => UnitModel.fromJson(item)).toList();
  // }
  //
  // //this method will prevent the override of toString
  // String userAsString() {
  //   return '#${this._unitid} ${this._unitname}';
  // }
  //
  // ///custom comparing function to check if two users are equal
  // bool isEqual(UnitModel model) {
  //   return this?.unitid == model?._unitid;
  // }
  //
  // @override
  // String toString() => _unitname;
  //








  factory UnitModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return UnitModel(
        json['unitid'],
        json['unitname']);
  }

  static List<UnitModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => UnitModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.unitid} ${this.unitname}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(UnitModel model) {
    return this?.unitid == model?.unitid;
  }


  @override
  String toString() => unitname;






}