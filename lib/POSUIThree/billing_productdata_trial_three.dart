import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:retailerp/LocalDbModels/POSModels/producttrial.dart';

class ProductDataTrialThree extends ChangeNotifier {
  List<ProductTrial> _product = [
//  Product.copyWith("Rice Bowl",20,250,2,"27/10/20","28/10/20",0),
//  Product.copyWith("Chicken",20,250,2,"27/10/20","28/10/20",0),
//  Product.copyWith("Wheat",20,250,2,"27/10/20","28/10/20",0),
  ];


  UnmodifiableListView<ProductTrial> get products {
    return UnmodifiableListView(_product);
  }

  double get totalAmount1 {
    var total = 0.0;
    _product.forEach((products) {
      total += products.subTotal;
    });
    return total;
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


  double getGSTAmount(ProductTrial product){
    double GSTamount = product.gstperce;
    double sellingPrice = (product.productprice) * (product.productquntity);
    double mainPrice = sellingPrice / (100 + GSTamount) * 100;
    double cal = sellingPrice * (GSTamount / (100 + GSTamount));
    return cal;
  }

  double getBasicAmount(ProductTrial product){
    double GSTamount = product.gstperce;
    double sellingPrice = (product.productprice) * (product.productquntity);
    double mainPrice = sellingPrice / (100 + GSTamount) * 100;
    return mainPrice;
  }

  int get productCount {
    return _product.length;
  }

  int fungetFinalSubtotalminus(ProductTrial product){
    product.getFinalSubtotalminus();
    notifyListeners();
  }

  void updatePrice(double price,ProductTrial product){
    product.subTotal = price;
    // product.productprice = price;
    // product.productquntity = 1;
    notifyListeners();
  }
  void updateQty(double qty,ProductTrial product){
    product.productquntity = qty;
    notifyListeners();
  }

//   void getAddSubTotal(){
//     var subtot;
//     _product.forEach((element) {
//       subtot = element.subTotal.toDouble();
//       print('Inner////: ${element.subTotal}');
//     });
//     print('temp Vaules: $tempValue');
//     finalSub =subtot+tempValue;
//     print('Final Vaules: $finalSub');
// //    tempValue=0.0;
//     notifyListeners();
//   }
  // void getSubtrSubTotal(){
  // var subtot;
  //   _product.forEach((element) {
  //     subtot = element.subTotal.toDouble();
  //     print('Inner substrct////: ${element.subTotal}');
  //   });
  //   print('temp Vaules substrct: $tempValue');
  //   finalSub =subtot-tempValue;
  //   print('Final Vaules substrct: $finalSub');
  //   notifyListeners();
  // }

  void addProduct(ProductTrial product) {
    List<String> tempProList = [];
    products.forEach((element) {
      tempProList.add(element.productname);
    });
    if(products.length != 0){
      print(" ${product.productname}");
      if(tempProList.contains(product.productname)){

        print("Print 1 ${product.productname}");
        increaseQuant(product);

        // updateSTotal(product);
      }else{
        _product.add(product);
        print("Print 2");
      }
    }else{
      print("Print 4");
      _product.add(product);
    }
    notifyListeners();
  }

//  void updateFinalSubTotal(Product product){
//    for(int i=0; i< _product.length;i++){
//      product.finalsubtotal =
//      _subTotal = _subTotal - _productprice;
//    }
//
//  }

  void increaseQuant(ProductTrial product) {
    product.increaseQuanity();
    print('Here I am Inside inc');
    notifyListeners();
  }

  void decreaseQuant(ProductTrial product) {
    product.decreaseQuanity();
    notifyListeners();
  }

  void updateSTotal(ProductTrial product){
    product.updateSubTotal();
    notifyListeners();
  }

  void decupdateSTotal(ProductTrial product){
    product.deupdateSubTotal();
    notifyListeners();
  }
//  void decupdateSTotal(Product product){
//    product.deupdateSubTotal();
//    notifyListeners();
//  }
  void deleteTask(ProductTrial product) {
    _product.remove(product);
    notifyListeners();
  }

  void ClearTask() {
    _product.clear();
    notifyListeners();
  }
}

// void addItem(
//     String productId,
//     double price,
//     String title,
//     ) {
//   if (_items.containsKey(productId)) {
//     // change quantity...
//     _items.update(
//       productId,
//           (existingCartItem) => CartItem(
//         id: existingCartItem.id,
//         title: existingCartItem.title,
//         price: existingCartItem.price,
//         quantity: existingCartItem.quantity + 1,
//       ),
//     );
//   } else {
//     _items.putIfAbsent(
//       productId,
//           () => CartItem(
//         id: DateTime.now().toString(),
//         title: title,
//         price: price,
//         quantity: 1,
//       ),
//     );
//   }
//   notifyListeners();
// }