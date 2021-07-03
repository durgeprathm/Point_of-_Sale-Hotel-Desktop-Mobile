import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/LocalDbModels/MobilePOSModels/productMobOne.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/utils/MobilePOSProviders/billing_productMobile.dart';
import 'package:retailerp/utils/const.dart';
import 'package:sqflite/sqflite.dart';
import 'mobile_pos_billing.dart';

class MobilePOS extends StatefulWidget {
  static const String id = 'pos_mobile_screen';

  @override
  _MobilePOSState createState() => _MobilePOSState();
}

class _MobilePOSState extends State<MobilePOS> {
  bool _checkBoxval = false;
  bool isSwitched = false;

  List<bool> catgeorySelction = [false, false, false];
  List<bool> subCatSelction = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<ProductModel> productCatList;
  int count = 0;


  @override
  void initState() {
    updateListView();
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((value) {
      Future<List<ProductModel>> productListFuture =
          databaseHelper.getProductList();
      productListFuture.then((productCatList) {
        setState(() {

          this.productCatList = productCatList;
          this.count = productCatList.length;

        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("POS Table-1"),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff01579B),
//                image: DecorationImage(
//                    image: AssetImage("Images/snsbluelogo.png"),
//                    fit: BoxFit.contain),
              ),
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.utensils,
                color: Colors.black,
                size: 40.0,
              ),
              title: Text(
                'Table-1',
              ),
              onTap: () {
                Navigator.pop(context);
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) =>
//                            AllVideoPage(widget.USERNAME, widget.StudId)));
              },
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.utensils,
                color: Colors.black,
                size: 40.0,
              ),
              title: Text(
                'Table-2',
              ),
              onTap: () {
//                Navigator.pop(context);
////                Navigator.push(
////                    context,
////                    MaterialPageRoute(
////                        builder: (context) => NotePage(
////                            username: widget.USERNAME,
////                            studentid: widget.StudId)));
              },
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.utensils,
                color: Colors.black,
                size: 40.0,
              ),
              title: Text(
                'Table-3',
              ),
              onTap: () {
////                Navigator.pop(context);
////                Navigator.push(
////                    context,
////                    MaterialPageRoute(
////                        builder: (context) => TimeTable(
////                            widget.USERNAME,
////                            widget.StudId)));
              },
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.utensils,
                color: Colors.black,
                size: 40.0,
              ),
              title: Text(
                'Table-4',
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<ProductDataMobile>(
              builder: (context, productData, child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                      padding: EdgeInsets.all(7),
                      child: Text("Category",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Material(
                    elevation: 2.0,
                    child: Container(
                        height: 70,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Switch(
                                      value: catgeorySelction[index],
                                      onChanged: (value) {
                                        setState(() {
//                                    isSwitched = value;
                                          catgeorySelction[index] = value;
                                          print(value.toString());
                                        });
                                      },
                                      activeTrackColor: Colors.blue,
                                      activeColor: Colors.blueGrey,
                                    ),
                                  ),
                                  Text(
                                    category[0]['category'][index]['catname'],
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  )
                                ],
                              );
                            })),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                      padding: EdgeInsets.all(7),
                      child: Text("Sub Category",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Material(
                    elevation: 2.0,
                    child: Container(
                        height: 70,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 6,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  Checkbox(
                                      value: subCatSelction[index],
                                      onChanged: (bool value) {
                                        setState(() {
                                          subCatSelction[index] = value;
                                        });
                                      }),
                                  Text("Product $index"),
                                  SizedBox(
                                    width: 8.0,
                                  )
                                ],
                              );
                            })),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                      padding: EdgeInsets.all(7),
                      child: Text("Products",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Material(
                    elevation: 5.0,
                    child: Container(
                        height: 320,
                        child: GridView.builder(
                            itemCount: productCatList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    final product = ProductMobOne.copyWith(
                                        productCatList[index].proName,
                                        20,
                                        productCatList[index].proSellingPrice,
                                        1,
                                        "27/10/20",
                                        "28/10/20",
                                        0,
                                        productCatList[index].proSellingPrice,
                                        productCatList[index].proSellingPrice.toDouble(),
                                       );
                                    Provider.of<ProductDataMobile>(context, listen: false).addProduct(product);
//                                    final pro = productData.products;
//                                    List<ProductMobOne> newProductlist = pro;
//                                    if (newProductlist.length == 0) {
//                                      Provider.of<ProductDataMobile>(context, listen: false)
//                                          .addProduct(product);
//                                    } else {
//                                      for (int i = 0; i < newProductlist.length; i++) {
//
//                                        if (newProductlist[i].productname != productCatList[index].proName) {
//                                          print("i value$i");
//                                          print("index value$index");
//                                          print("1///${newProductlist[i].productname}");
//                                          print("2///${productCatList[index].proName}");
//                                          Provider.of<ProductDataMobile>(context, listen: false)
//                                              .addProduct(product);
//                                          i = newProductlist.length + 1;
//                                          print("After initlize$i");
//                                          break;
//                                        } else {
//                                          print("else i value$i");
//                                          print("else index value$index");
//                                          print("else 1///${newProductlist[i].productname}");
//                                          print("else 2///${productCatList[index].proName}");
//                                          Provider.of<ProductDataMobile>(context, listen: false)
//                                              .increaseQuant(product);
//                                          Provider.of<ProductDataMobile>(context, listen: false)
//                                              .updateSTotal(product);
////                                  productData.increaseQuant(product);
////                                  productData.updateSTotal(product);
//                                          print('Already Exists');
//                                          break;
//                                        }
//                                      }
//                                    }
//                            final pro = productData.products;
//                            List<Product> newProductlist = pro;
//                            if (newProductlist.length == 0) {
//                              Provider.of<ProductData>(context, listen: false)
//                                  .addProduct(product);
//                            } else {
//                              for (int i = 0; i < newProductlist.length; i++) {
//                                print(newProductlist[i].productname);
//                                print(productCatList[index].proName);
//
//                                for (int j = 0; j < productCatList.length; j++) {
//                                  if (newProductlist[i].productname ==
//                                      (productCatList[j].proName)) {
//                                    print('Already Exists');
//                                  } else {
//                                    print('else Call');
//                                  }
//                                }
////                              if (newProductlist[i].productname == productCatList[index].proName) {
////                                print('Already Exists');
////                                Provider.of<ProductData>(context, listen: false)
////                                    .addProduct(product);
////                                break;
////                              } else {
////                                print('else Call');
////                                productData.increaseQuant(product);
////                                productData.updateSTotal(product);
////                                print('Already Exists');
////                                break;
///
                                  },
                                  child: Material(
                                    borderRadius: BorderRadius.circular(5.0),
                                    elevation: 5.0,
                                    child: Container(
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: Text(productCatList[index].proName,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  )),
                                              subtitle: Text(
                                                productCatList[index].proSellingPrice.toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Image.file(
                                              File(productCatList[index].proImage.toString()),
                                              width: 30.0,
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              );
                            },
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            )),
                  )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 10),
                    child: Material(
                      color: SALESBG,
                      borderRadius: BorderRadius.circular(30.0),
                      child: MaterialButton(
                        onPressed: () {
                          //Navigator.pop(context);
                          if( productData.productCount == 0){

                            Fluttertoast.showToast(
                                msg: "Please select atleast one Product",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: PrimaryColor,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }else{
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: MobilePOSBill(),
                                    )));
                          }


                        },
                        minWidth: 100.0,
                        height: 35.0,
                        child: Text(
                          '${productData.productCount.toString()} Product Added',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

//DropdownSearch(
//items: [
//"Prathmesh Durge",
//"Rajat Bhatulakar",
//"Praful Sakharkhede",
//"Ajikya Bhonde",
//],
//label: "Category",
//onChanged: print,
//validator: (String item) {
//if (item == null)
//return "Required field";
//else if (item == "Brazil")
//return "Invalid item";
//else
//return null;
//},
//),
//ListView.builder(
//shrinkWrap: true,
//scrollDirection: Axis.vertical,
//itemCount: 4,
//itemBuilder: (BuildContext context, int index) {
//return Container(
//child: Row(
//children: [
//SizedBox(
//width: 2.0,
//),
//Expanded(
//child: Container(
//child: ListTile(
////                                        leading: Image.asset(
////                                          productCatList[index].proImage,
////                                        ),
//title: Text("Mlik"),
////                                        title: Text(productCatList[index].proName),
//subtitle: Text("25"
////                                        subtitle: Text(productCatList[index].proSellingPrice.toString()
//),
//)),
//),
//Expanded(
//child: Container(
//child: Row(
//children: [
//Padding(
//padding: EdgeInsets.all(5.0),
//child: IconButton(
//icon: Icon(
//Icons.add,
//color: Colors.blue,
//),
//onPressed: () {
//final product = ProductMobOne.copyWith(
//"Milk",
//20,
//20,
//1,
//"27/10/20",
//"28/10/20",
//0,
//30,
//30,
//);
//
//Provider.of<ProductDataMobile>(context, listen: false)
//    .addProduct(product);
//},
//),
//),
//],
//)),
//)
//],
//),
//);
//})),