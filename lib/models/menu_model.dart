import 'dart:convert';

class MenuModel {
  final String id;
  final String proName;

  MenuModel({this.id, this.proName});

  //this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.proName}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(MenuModel model) {
    return this?.id == model?.id;
  }

  @override
  String toString() => proName;


}
