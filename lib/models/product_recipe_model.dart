import 'dart:convert';

class ProductRecipeModel {
  final String id;
  final String proName;
  final double proPrice;


  ProductRecipeModel({this.id, this.proName,this.proPrice});
  factory ProductRecipeModel.fromJson(String json) {
    var tagsJson = jsonDecode(json)['product'];
    if (tagsJson == null) return null;
    return ProductRecipeModel(
      id: tagsJson["ProductId"],
      proName: tagsJson["ProductName"],
      proPrice: tagsJson["ProductSellingPrice"],
    );
  }

  static List<ProductRecipeModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => ProductRecipeModel.fromJson(item)).toList();
  }

  //this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.proName}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(ProductRecipeModel model) {
    return this?.id == model?.id;
  }

  @override
  String toString() => proName;
}
