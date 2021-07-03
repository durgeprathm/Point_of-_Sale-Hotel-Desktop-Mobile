import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:retailerp/LocalDbModels/POSModels/producttwo.dart';

class ProductDataTwo extends ChangeNotifier {
  List<ProductTwo> _product = [
//  Product.copyWith("Rice Bowl",20,250,2,"27/10/20","28/10/20",0),
//  Product.copyWith("Chicken",20,250,2,"27/10/20","28/10/20",0),
//  Product.copyWith("Wheat",20,250,2,"27/10/20","28/10/20",0),
  ];

  var finalSub=0.00;
  var tempValue=0.00;
  UnmodifiableListView<ProductTwo> get products {
    return UnmodifiableListView(_product);
  }

  int get productCount {
    return _product.length;
  }

  int fungetFinalSubtotalminus(ProductTwo producttwo){
    producttwo.getFinalSubtotalminus();
    notifyListeners();
  }

  void updatePrice(double price,ProductTwo producttwo){
    producttwo.subTotal = price;
    producttwo.productprice = price;
    producttwo.productquntity = 1;
    notifyListeners();
  }

  double get TotalGSTAmount{
    double GSTtotal = 0.0;
    _product.forEach((products) {
      double GSTamount = products.gstperce;
      double sellingPrice = (products.productprice) * products.productquntity;
      double cal = sellingPrice * (GSTamount / (100 + GSTamount));
      GSTtotal += cal;
    });
    return GSTtotal;
  }

  double get TotalBasicAmount{
    double Basictotal = 0.0;
    _product.forEach((products) {
      double GSTamount = products.gstperce;
      double sellingPrice = products.productprice;
      double mainPrice = sellingPrice / (100 + GSTamount) * 100;
      Basictotal += mainPrice;
    });
    return Basictotal;
  }


  double getGSTAmount(ProductTwo producttwo){
    double GSTamount = producttwo.gstperce;
    double sellingPrice = (producttwo.productprice) * (producttwo.productquntity);
    double mainPrice = sellingPrice / (100 + GSTamount) * 100;
    double cal = sellingPrice * (GSTamount / (100 + GSTamount));
    return cal;
  }

  double getBasicAmount(ProductTwo producttwo){
    double GSTamount = producttwo.gstperce;
    double sellingPrice = (producttwo.productprice) * (producttwo.productquntity);
    double mainPrice = sellingPrice / (100 + GSTamount) * 100;
    return mainPrice;
  }

  double get totalAmount1 {
    var total = 0.0;
    _product.forEach((products) {
      total += products.subTotal;
    });
    return total;
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

  void addProduct(ProductTwo producttwo) {

    List<String> tempProList = [];
    products.forEach((element) {
      tempProList.add(element.productname);
    });

    if(products.length != 0){
      print(" ${producttwo.productname}");
      if(tempProList.contains(producttwo.productname)){
        print("Print 1 ${producttwo.productname}");
        increaseQuant(producttwo);
        // updateSTotal(product);
      }else{
        _product.add(producttwo);
        print("Print 2");
      }
    }else{
      print("Print 4");
      _product.add(producttwo);
    }
    // tempValue = finalSub;
    // _product.add(producttwo);
    // getAddSubTotal();
    notifyListeners();
  }

//  void updateFinalSubTotal(Product product){
//    for(int i=0; i< _product.length;i++){
//      product.finalsubtotal =
//      _subTotal = _subTotal - _productprice;
//    }
//
//  }


  void increaseQuant(ProductTwo producttwo) {
    producttwo.increaseQuanity();
    print('Here I am Inside inc');
//    getAddSubTotal();
    notifyListeners();
  }

  void decreaseQuant(ProductTwo producttwo) {
    producttwo.decreaseQuanity();
//    getSubtrSubTotal();
    notifyListeners();
  }

  void updateSTotal(ProductTwo producttwo){

    producttwo.updateSubTotal();
    getAddSubTotal();
    notifyListeners();
  }


  void decupdateSTotal(ProductTwo producttwo){
    producttwo.deupdateSubTotal();
    getSubtrSubTotal();
//    getSubtrSubTotal();
    notifyListeners();
  }

//  void decupdateSTotal(Product product){
//    product.deupdateSubTotal();
//    notifyListeners();
//  }

  void deleteTask(ProductTwo producttwo) {
    _product.remove(producttwo);
    notifyListeners();
  }

  void ClearTask() {
    _product.clear();
    notifyListeners();
  }
}