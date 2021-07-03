import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:retailerp/LocalDbModels/MobilePOSModels/productMobOne.dart';

class ProductDataMobile extends ChangeNotifier {
  List<ProductMobOne> _product = [
//  Product.copyWith("Rice Bowl",20,250,2,"27/10/20","28/10/20",0),
//  Product.copyWith("Chicken",20,250,2,"27/10/20","28/10/20",0),
//  Product.copyWith("Wheat",20,250,2,"27/10/20","28/10/20",0),
  ];

  var finalSub=0.00;
  var tempValue=0.00;

  UnmodifiableListView<ProductMobOne> get products {
    return UnmodifiableListView(_product);
  }

  double get totalAmount1 {
    var total = 0.0;
    _product.forEach((products) {
      total += products.subTotal;
    });
    return total;
  }


  int get productCount {
    return _product.length;
  }

  int fungetFinalSubtotalminus(ProductMobOne product){
    product.getFinalSubtotalminus();
    notifyListeners();
  }

//  double funfinalSubtotal(Product product){
//    notifyListeners();
//    print("printingzfinalsub////${product.getFinalSubtotal()}");
//    return product.getFinalSubtotal();
//  }

  void getAddSubTotal(){
    var subtot;
    _product.forEach((element) {
      subtot = element.subTotal.toDouble();
      print('Inner////: ${element.subTotal}');
    });
    print('temp Vaules: $tempValue');
    finalSub =subtot+tempValue;
    print('Final Vaules: $finalSub');
//    tempValue=0.0;
    notifyListeners();
  }

  void getSubtrSubTotal(){
    var subtot;
    _product.forEach((element) {
      subtot = element.subTotal.toDouble();
      print('Inner substrct////: ${element.subTotal}');
    });
    print('temp Vaules substrct: $tempValue');
    finalSub =subtot-tempValue;
    print('Final Vaules substrct: $finalSub');
    notifyListeners();
  }

  void addProduct(ProductMobOne product) {
    tempValue = finalSub;
    _product.add(product);
    getAddSubTotal();
    notifyListeners();
  }

//  void updateFinalSubTotal(Product product){
//    for(int i=0; i< _product.length;i++){
//      product.finalsubtotal =
//      _subTotal = _subTotal - _productprice;
//    }
//
//  }


  void increaseQuant(ProductMobOne product) {
    product.increaseQuanity();
    print('Here I am Inside inc');
//    getAddSubTotal();
    notifyListeners();
  }

  void decreaseQuant(ProductMobOne product) {
    product.decreaseQuanity();
//    getSubtrSubTotal();
    notifyListeners();
  }

  void updateSTotal(ProductMobOne product){
    product.updateSubTotal();
    getAddSubTotal();
    notifyListeners();
  }


  void decupdateSTotal(ProductMobOne product){
    product.deupdateSubTotal();
    getSubtrSubTotal();
//    getSubtrSubTotal();
    notifyListeners();
  }

//  void decupdateSTotal(Product product){
//    product.deupdateSubTotal();
//    notifyListeners();
//  }

  void deleteTask(ProductMobOne product) {
    _product.remove(product);
    notifyListeners();
  }
}