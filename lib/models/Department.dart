import 'package:retailerp/Repository/database_creator.dart';

class Department {
  int _DepartmentId;
  String _DepartmentName;
  String _DepartmentNarration;

  Department(
      this._DepartmentId, this._DepartmentName, this._DepartmentNarration);

  Department.copyWith(this._DepartmentName, this._DepartmentNarration);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_DepartmentId != null) {
      map['Department_Id'] = _DepartmentId;
    }
    map['Department_Name'] = _DepartmentName;
    map['Department_Narration'] = _DepartmentNarration;
    return map;
  }

  // Extract a Note object from a Map object

  Department.fromMapObject(Map<String, dynamic> map) {
    this._DepartmentId = map['Department_Id'];
    this._DepartmentName = map['Department_Name'];
    this._DepartmentNarration = map['Department_Narration'];
  }

  String get DepartmentNarration => _DepartmentNarration;

  set DepartmentNarration(String value) {
    _DepartmentNarration = value;
  }

  String get DepartmentName => _DepartmentName;

  set DepartmentName(String value) {
    _DepartmentName = value;
  }

  int get DepartmentId => _DepartmentId;

  set DepartmentId(int value) {
    _DepartmentId = value;
  }

  factory Department.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Department(int.parse(json['DepartmentId']), json['DepartmentName'],
        json['DepartmentNarration']);
  }

  static List<Department> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => Department.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.DepartmentId} ${this.DepartmentName}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(Department model) {
    return this?.DepartmentId == model?.DepartmentId;
  }

  @override
  String toString() => DepartmentName;
}
