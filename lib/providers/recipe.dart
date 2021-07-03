import 'dart:collection';

import 'package:flutter/foundation.dart';

class RecipeItems {
  String _id;
  String _title;
  double _quantity;
  double _productprice;


  double get productprice => _productprice;

  set productprice(double value) {
    _productprice = value;
  }

  RecipeItems(this._id, this._title, this._quantity,this._productprice);

  double get quantity => _quantity;

  set quantity(double value) {
    _quantity = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

}

class Recipe with ChangeNotifier {
  List<RecipeItems> _recipe = [];

  // Map<String, RecipeItems> _items = {};

  // Map<String, RecipeItems> get items {
  //   return {..._items};
  // }

  int get itemCount {
    return _recipe.length;
  }



  UnmodifiableListView<RecipeItems> get products {
    return UnmodifiableListView(_recipe);
  }

  void addRecipeItems(RecipeItems recipeItems) {
    _recipe.add(recipeItems);
    notifyListeners();
  }

  double getSubtotal(RecipeItems recipeItems){
    return recipeItems.productprice * recipeItems._quantity;
  }


  void updateRecipeItems(
      int proId, String proname, double qty, RecipeItems item) {
    item.id = proId.toString();
    item.title = proname;
    item.quantity = qty;
    notifyListeners();
  }

  void removeItem(String productId) {
    _recipe.remove(productId);
    notifyListeners();
  }

  void deleteTask(RecipeItems recipeItems) {
    _recipe.remove(recipeItems);
    notifyListeners();
  }

  double get totalAmount1 {
    var total = 0.0;
    _recipe.forEach((products) {
      total += (products._quantity * products.productprice);
    });
    return total;
  }




// void removeSingleItem(String productId) {
//   if (!_recipe.containsKey(productId)) {
//     return;
//   }
//   _recipe.remove(productId);
//   notifyListeners();
// }

  void clear() {
    _recipe.clear();
    notifyListeners();
  }
}
