import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/EhotelModel/EhotelSales.dart';
import 'package:retailerp/editPOSUI/EditbillProviders/edit_billprovider.dart';
import 'package:retailerp/utils/const.dart';

class TablePosEditProductView extends StatefulWidget {
  TablePosEditProductView(this.index,this.SalesListFetch);
  int index;
  List<EhotelSales> SalesListFetch = new List();

  @override
  _TablePosEditProductViewState createState() => _TablePosEditProductViewState();
}

class _TablePosEditProductViewState extends State<TablePosEditProductView> {
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.orange,
  );

  List<ServerMenuModel> productCatListServer = [];
  List<ServerMenuModel> _searchListServer = [];

  List<ServerMenuCatModel> _menucatListServer = [];
  List<ServerMenuCatModel> _searchmenucatListServer = [];

 // MenuList menuList = new MenuList();
 // POSMenuCatList posmenucatlistadp = new POSMenuCatList();

  TextEditingController SerachController = new TextEditingController();
  //-------------------For showing Ordered Item From Server---------------------//
  List<EhotelSales> orderedItemList = [];

  int count = 0;
  String pMenuCatId, pMenuCatName;

  //OrderedItem orderedItem = new OrderedItem();


  @override
  void initState() {
    super.initState();
   // _getMenuCat();
   // _getMenu("0");
   // _getOrderedItems();
  }


  //Menu From Server
  // Future<void> _getMenuCat() async {
  //  // var menucat = await posmenucatlistadp.getPosMenuList();
  //   int resid = menucat["resid"];
  //   if (resid == 200) {
  //     int rowcount = menucat["rowcount"];
  //     if (rowcount > 0) {
  //       var menucatsd = await menucat["menucatgo"];
  //       List<ServerMenuCatModel> menuscat = [];
  //       var tempcat = ServerMenuCatModel("0", "All");
  //       menuscat.add(tempcat);
  //       if (menucatsd != null) {
  //         for (var n in menucatsd) {
  //           ServerMenuCatModel menucat =
  //           ServerMenuCatModel(n["MenuCatId"], n["MenuCatName"]);
  //           menuscat.add(menucat);
  //         }
  //       }
  //       setState(() {
  //         _menucatListServer = menuscat;
  //         _searchmenucatListServer = menuscat;
  //       });
  //     } else {}
  //   } else {}
  // }

  // void _getMenu(String menuCatId) async {
  //
  //   print("Inside getmenu");
  //   //var productData = await menuList.getMenuWithID("1", menuCatId);
  //   var resid = productData["resid"];
  //   var productsd = productData["menu"];
  //   int tempChecking = productData["rowcount"];
  //   print(tempChecking);
  //   List<ServerMenuModel> products = [];
  //
  //   if (productsd != null) {
  //     for (var n in productsd) {
  //       ServerMenuModel pro = ServerMenuModel(n["MenuId"], n["MenuName"],
  //           n["Menucategory"], n["MenuRate"], n["MenuGST"]);
  //       products.add(pro);
  //     }
  //   }
  //
  //   setState(() {
  //     this.productCatListServer = products;
  //     this._searchListServer = productCatListServer;
  //     this.count = productCatListServer.length;
  //   });
  //
  //
  //   SerachController.addListener(() {
  //     setState(() {
  //       if (productCatListServer != null) {
  //         String s = SerachController.text;
  //         _searchListServer = productCatListServer
  //             .where((element) =>
  //             element.pname.toLowerCase().contains(s.toLowerCase()))
  //             .toList();
  //       }
  //     });
  //   });
  // }

  // void _getOrderedItems() async {
  //
  //   setState(() {
  //     this.orderedItemList = widget.SalesListFetch;
  //   });
  //
  //
  //   var splitedItemId = orderedItemList[widget.index].menuid.split("#");
  //   var splitedItemName = orderedItemList[widget.index].menuname.split("#");
  //   var splitedItemQty = orderedItemList[widget.index].menuquntity.split("#");
  //   var splitedItemRate= orderedItemList[widget.index].menurate.split("#");
  //   var splitedItemSubtotal= orderedItemList[widget.index].menusubtotal.split("#");
  //
  //   setState(() {
  //     editDate = orderedItemList[widget.index].medate;
  //     editSalesID = orderedItemList[widget.index].menusalesid;
  //   });
  //
  //   Provider.of<OrderItemProviderEdit>(context, listen: false).ClearTask();
  //   for(int i=0;i<splitedItemName.length;i++){
  //     final orderitem = OrderedItemModel.copyWith(int.parse(splitedItemId[i]),splitedItemName[i],double.parse(splitedItemRate[i]), int.parse(splitedItemQty[i]),0, double.parse(splitedItemSubtotal[i]), double.parse(splitedItemSubtotal[i]),0.0);
  //     Provider.of<OrderItemProviderEdit>(context, listen: false)
  //         .addProduct(orderitem);
  //   }
  //
  // }


  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
                width: 30.0,
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
                      //
                      // if (data != null) {
                      //   print(data);
                      //   pMenuCatId = data.mcid;
                      //   pMenuCatName = data.mcname.toString();
                      //   _getMenu(pMenuCatId);
                      // }else{
                      //   _getMenu("0");
                      // }

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
                    "Menu",
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
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                      decoration: InputDecoration(
                          hintText: "Start typing menu here..",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            color: PrimaryColor,
                            onPressed: () {},
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
            child: Consumer<OrderItemProviderEdit>(builder: (context, productData, child) {
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
                            // final product =OrderedItemModel.copyWith(
                            //     int.parse(_searchListServer[index].pid),
                            //     _searchListServer[index].pname,
                            //     double.parse(
                            //         _searchListServer[index].productrate),
                            //     1,
                            //     0,
                            //     double.parse(
                            //         _searchListServer[index].productrate),
                            //     double.parse(
                            //         _searchListServer[index].productrate),
                            //     double.parse(
                            //         _searchListServer[index].GSTPer));
                            //
                            // Provider.of<OrderItemProviderEdit>(context, listen: false)
                            //     .addProduct(product);

                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(5.0),
                            elevation: 5.0,
                            child: Container(
                                child: Column(
                                  children: [
                                    ListTile(
                                      title:
                                      Text(_searchListServer[index].pname,
                                          style: TextStyle(
                                            color: Colors.black,
                                          )),
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
      ),
    );
  }
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


