import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/fetch_menuCategoryPoonam.dart';
import 'package:retailerp/Adpater/fetch_menuList.dart';
import 'package:retailerp/Adpater/pos_product_fetch.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/LocalDbModels/POSModels/product.dart';
import 'package:retailerp/LocalDbModels/POSModels/producttrial.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/POSUIONE/billing_productdata_trial.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/utils/POSProviders/billing_productdata.dart';
import 'package:retailerp/utils/const.dart';

class POSProductViewer extends StatefulWidget {
  @override
  _POSProductViewerState createState() => _POSProductViewerState();
}

class _POSProductViewerState extends State<POSProductViewer> {
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.orange,
  );

  //----------------------For fetching menu list from local db--------------------------//

  List<ProductModel> _searchList = List();

   List<ProductModel> productCatList;
  //----------------------For fetching menu list from server--------------------------//
  List<ServerMenuModel> productCatListServer = [];
  List<ServerMenuModel> _searchListServer = [];

  List<ServerMenuCatModel> _menucatListServer = [];
  List<ServerMenuCatModel> _searchmenucatListServer = [];

  MenuList menuList = new MenuList();
  //POSMenuCatList posmenucatlistadp = new POSMenuCatList();

  TextEditingController SerachController = new TextEditingController();

  final TextEditingController _searchQuery = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();
  int count = 0;
  String pMenuCatId, pMenuCatName;
  FocusNode myFocusNode;
  TextEditingController qtytextEC = new TextEditingController();
  TextEditingController subtotaltextEC = new TextEditingController();
  String editQty, editSubtotal;

  List<ProductModel> productList = [];
  List<ProductModel> searchProductList = [];
  ProductModel product;

  @override
  void initState() {
    // _getMenuCat();
    _getMenu("0");
    myFocusNode = FocusNode();
  }

  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    myFocusNode = FocusNode();
    super.dispose();
  }


  void _getMenu(String menuCatId) async {
    print("Inside getmenu");
    var productData = await menuList.getMenuWithID("1", menuCatId);
    var resid = productData["resid"];
    var productsd = productData["menu"];
    int tempChecking = productData["rowcount"];
    print(tempChecking);
    List<ServerMenuModel> products = [];

    if (productsd != null) {
      for (var n in productsd) {
        ServerMenuModel pro = ServerMenuModel(n["MenuId"], n["MenuName"],
            n["Menucategory"], n["MenuRate"], n["MenuGST"]);
        products.add(pro);
      }
    }

    setState(() {
      this.productCatListServer = products;
      this._searchListServer = productCatListServer;
      this.count = productCatListServer.length;
    });

    SerachController.addListener(() {
      setState(() {
        if (productCatListServer != null) {
          String s = SerachController.text;
          _searchListServer = productCatListServer
              .where((element) =>
                  element.pname.toLowerCase().contains(s.toLowerCase()) ||
                  element.pid.contains(s.toLowerCase()))
              .toList();
        }
      });
    });
  }

  void _getProducts() async {
    // setState(() {
    //   _showCircle = true;
    // });
    ProductFetch Productfetch = new ProductFetch();
    var productData = await Productfetch.getposproduct("1");
    var resid = productData["resid"];
    if (resid == 200) {
      var rowcount = productData["rowcount"];
      if (rowcount > 0) {
        var productsd = productData["product"];
        print(productsd.length);
        List<ProductModel> products = [];
        for (var n in productsd) {
          ProductModel pro = ProductModel.withId(
              int.parse(n['ProductId']),
              n['ProductType'],
              int.parse(n['ProductCode']),
              n['ProductName'],
              n['ProductCompanyName'],
              n['ProductCategories'],
              int.parse(n['ProductCategoriesID']),
              0,
              double.parse(n['ProductSellingPrice']),
              n['HSNCode'],
              n['Tax'],
              '',
              n['Unit'],
              int.parse(n['ProductOpeningBalance']),
              n['ProductBillingMethod'],
              n['IntegratedTax'],
              '');
          products.add(pro);
        }

        setState(() {
          productList = products;
          // _showCircle = false;
          searchProductList = productList;
          // showspinnerlog = false;
        });

        SerachController.addListener(() {
          setState(() {
            if (productList != null) {
              String s = SerachController.text;
              searchProductList = productList
                  .where((element) =>
              element.proId
                  .toString()
                  .toLowerCase()
                  .contains(s.toLowerCase()) ||
                  element.proCode
                      .toString()
                      .toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.proName.toLowerCase().contains(s.toLowerCase()) ||
                  element.proComName
                      .toLowerCase()
                      .contains(s.toLowerCase()) ||
                  element.proCategory
                      .toString()
                      .toLowerCase()
                      .contains(s.toLowerCase()))
                  .toList();
            }
          });
        });
      } else {

        // setState(() {
        //   _showCircle = false;
        // });

        String msg = productData["message"];
        Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: PrimaryColor,
          textColor: Color(0xffffffff),
          gravity: ToastGravity.BOTTOM,
        );
      }
    } else {
      // setState(() {
      //   _showCircle = false;
      // });
      String msg = productData["message"];
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: PrimaryColor,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  Widget build(BuildContext context) {
    return Expanded(
        child: Consumer<ProductDataTrial>(builder: (context, productData, child) {
      return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.all(3),
                  child: Text(
                    "Category",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: PrimaryColor),
                  )),
              SizedBox(
                width: 45.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownSearch<ServerMenuCatModel>(
                    items: _menucatListServer,
                    showClearButton: true,
                    showSearchBox: true,
                    label: 'Category *',
                    hint: "Select a Category",
                    onChanged: (ServerMenuCatModel data) {
                      if (data != null) {
                        print(data);
                        pMenuCatId = data.mcid;
                        pMenuCatName = data.mcname.toString();
                        _getMenu(pMenuCatId);
                      } else {
                        _getMenu("0");
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.all(3),
                  child: Text(
                    "Products",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: PrimaryColor),
                  )),
              SizedBox(
                width: 45.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Container(
                    child: TextField(
                      controller: SerachController,
                      autofocus: true,
                      focusNode: myFocusNode,
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                      onSubmitted: (value) {

                        String productid = _searchListServer[0].pid;
                        String productName = _searchListServer[0].pname;
                        String productrate = _searchListServer[0].productrate.toString();
                        String productGST = _searchListServer[0].GSTPer;

                        showDialog<void>(
                          context: context,
                          barrierDismissible: true,
                          // user must tap button!
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: AlertDialog(
                                title: Container(
                                  height: 30,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(productName),
                                    subtitle:
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text("Product Rate: ${productrate}"),
                                          ),
                                          // GestureDetector(
                                          //   onTap: () {
                                          //     subtotaltextEC.text = "";
                                          //     qtytextEC.text = "";
                                          //     Navigator.of(context).pop();
                                          //   },
                                          //   child: IconButton(icon: FaIcon(
                                          //     FontAwesomeIcons.windowClose,
                                          //     color: Colors.blueGrey,
                                          //   ), onPressed: () {
                                          //
                                          //   }),
                                          // )
                                        ],
                                      ),
                                    )
                                  ),
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      TextField(
                                        autofocus: true,
                                        textAlign: TextAlign.left,
                                        controller: qtytextEC,
                                        keyboardType: TextInputType.number,
                                        decoration:
                                            InputDecoration(labelText: "Qty"),
                                        onChanged: (newText) {
                                            editQty = (newText);
                                          if (productrate.isNotEmpty) {
                                            subTotalCal(
                                                double.tryParse(productrate) ??
                                                    0.00,
                                                double.tryParse(editQty) ??
                                                    0.00);
                                          }

                                          // qtytextEC.text =  (double.parse(subtotaltextEC.text) / double.parse(productrate)).toString();
                                          // subtotaltextEC.text = (int.parse(qtytextEC.text) * double.parse(productrate)).toString();
                                        },
                                      ),
                                      TextField(
                                        autofocus: true,
                                        textAlign: TextAlign.left,
                                        controller: subtotaltextEC,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            labelText: "Subtotal"),
                                        onChanged: (newText) {
                                          setState(() {
                                            editSubtotal = (newText);
                                            if (productrate.isNotEmpty) {
                                              qtyCal(
                                                  double.tryParse(productrate)??0.00,
                                                  double.tryParse(
                                                          editSubtotal) ??
                                                      0.00);
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Add'),
                                    onPressed: () {
                                      print(value);
                                      final product = ProductTrial.copyWith(
                                          int.parse(productid),
                                          productName,
                                          double.parse(productrate),
                                          double.parse(editQty),
                                          0,
                                          double.parse(editSubtotal),
                                          double.parse(productrate),
                                          double.parse(productGST));
                                      Provider.of<ProductDataTrial>(context,
                                              listen: false)
                                          .addProduct(product);
                                      Navigator.of(context).pop();
                                      subtotaltextEC.text = "";
                                      qtytextEC.text = "";
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Close'),
                                    onPressed: () {
                                      subtotaltextEC.text = "";
                                      qtytextEC.text = "";
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                        SerachController.text = "";
                        myFocusNode.requestFocus();
                      },
                      decoration: InputDecoration(
                          hintText: "Start typing menu here..",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            color: PrimaryColor,
                            onPressed: () {

                            },
                          )),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child:
                Consumer<ProductDataTrial>(builder: (context, productData, child) {
              return Container(
                child: _searchListServer.length == 0
                    ? Center(child: CircularProgressIndicator())
                    : GridView.builder(
                        itemCount: _searchListServer.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: true,
                                  // user must tap button!
                                  builder: (BuildContext context) {
                                    return SingleChildScrollView(
                                      child: AlertDialog(
                                        title: Container(
                                          height: 30,
                                          child: ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            title: Text( _searchListServer[index].pname),
                                            subtitle:Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text("Product Rate: ${_searchListServer[index].productrate}"),
                                                  ),
                                                  // IconButton(icon: FaIcon(
                                                  //   FontAwesomeIcons.windowClose,
                                                  //   color: Colors.blueGrey,
                                                  // ), onPressed: () {
                                                  //   Navigator.of(context).pop();
                                                  // })
                                                ],
                                              ),
                                            )
                                          ),
                                        ),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              TextField(
                                                autofocus: true,
                                                textAlign: TextAlign.left,
                                                controller: qtytextEC,
                                                keyboardType: TextInputType.number,
                                                decoration:
                                                InputDecoration(labelText: "Qty"),
                                                onChanged: (newText) {
                                                  editQty = (newText);
                                                  if (_searchListServer[index].productrate.isNotEmpty) {
                                                    subTotalCal(
                                                        double.tryParse(_searchListServer[index].productrate) ??
                                                            0.00,
                                                        double.tryParse(editQty) ??
                                                            0.00);
                                                  }

                                                },
                                              ),
                                              TextField(
                                                autofocus: true,
                                                textAlign: TextAlign.left,
                                                controller: subtotaltextEC,
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                    labelText: "Subtotal"),
                                                onChanged: (newText) {
                                                  setState(() {
                                                    editSubtotal = (newText);
                                                    if (_searchListServer[index].productrate.isNotEmpty) {
                                                      qtyCal(
                                                          double.tryParse(_searchListServer[index].productrate)??0.00,
                                                          double.tryParse(
                                                              editSubtotal) ??
                                                              0.00);
                                                    }
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Add'),
                                            onPressed: () {
                                              final product = ProductTrial.copyWith(
                                                  int.parse(_searchListServer[index].pid),
                                                  _searchListServer[index].pname,
                                                  double.parse(
                                                  _searchListServer[index].productrate),
                                                  double.parse(editQty),
                                                  0,
                                                  double.parse(editSubtotal),
                                                  double.parse(_searchListServer[index].productrate),
                                                  double.parse(_searchListServer[index].GSTPer));
                                              Provider.of<ProductDataTrial>(context,
                                                  listen: false)
                                                  .addProduct(product);
                                              Navigator.of(context).pop();
                                              subtotaltextEC.text = "";
                                              qtytextEC.text = "";
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Close'),
                                            onPressed: () {
                                              subtotaltextEC.text = "";
                                              qtytextEC.text = "";
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Material(
                                borderRadius: BorderRadius.circular(5.0),
                                elevation: 5.0,
                                child: Container(
                                    child: Column(
                                  children: [
                                    ListTile(
                                      title: Container(
                                          child: Row(children: [
                                        Expanded(
                                          child: Text(
                                              _searchListServer[index].pname,
                                              style: TextStyle(
                                                color: Colors.black,
                                              )),
                                        ),
                                        RaisedButton(
                                          color: PrimaryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          onPressed: () {},
                                          child: Text(
                                              "ID : ${_searchListServer[index].pid}",
                                              style: TextStyle(
                                                color: Colors.white,
                                              )),
                                        ),
                                      ])),
                                      subtitle: Text(
                                        "$Rupees${_searchListServer[index].productrate.toString()}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 2.0,
                        )),
              );
            }),
          )
        ]),
      );
    }));
  }

  subTotalCal(double rate, double qty) {
    setState(() {
      subtotaltextEC.text = (rate * qty).toStringAsFixed(2);
      editSubtotal=(rate * qty).toStringAsFixed(2);
    });
  }

  qtyCal(double rate, double subtotal) {
    setState(() {
      qtytextEC.text = (subtotal / rate).toStringAsFixed(1);
      editQty = (subtotal / rate).toStringAsFixed(1);
    });
  }
}

class ProductCatView extends StatefulWidget {
  @override
  _ProductCatViewState createState() => _ProductCatViewState();
}

class _ProductCatViewState extends State<ProductCatView> {
  List<bool> catgeorySelction = [false, false, false];

  List<bool> subCatSelction = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(bottom: 3),
            child: Text(
              "Category",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: PrimaryColor),
            )),
        Material(
          child: Container(
              height: 30,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) => Row(
                  children: [
                    ListTile(
                      title: Text("Product $index"),
                    ),
                    SizedBox(
                      width: 8.0,
                    )
                  ],
                ),
              )),
        ),
      ],
    );
  }
}

class ServerProductModel {
  String pid;
  String pname;
  String productcatid;
  String productrate;
  String productqty;
  String productimg;

  ServerProductModel(this.pid, this.pname, this.productcatid, this.productrate,
      this.productqty, this.productimg);
}

class ServerMenuModel {
  String pid;
  String pname;
  String productcatid;
  String productrate;
  String GSTPer;

  ServerMenuModel(
      this.pid, this.pname, this.productcatid, this.productrate, this.GSTPer);
}

class ServerMenuCatModel {
  String _mcid;
  String _mcname;

  ServerMenuCatModel(this._mcid, this._mcname);

  String get mcname => _mcname;

  set mcname(String value) {
    _mcname = value;
  }

  String get mcid => _mcid;

  set mcid(String value) {
    _mcid = value;
  }

  factory ServerMenuCatModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ServerMenuCatModel((json['MenuCatId']), json['MenuCatName']);
  }

  static List<ServerMenuCatModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => ServerMenuCatModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.mcid} ${this.mcname}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(ServerMenuCatModel model) {
    return this?.mcid == model?.mcid;
  }

  @override
  String toString() => mcname;
}
