import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/pos_product_fetch.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/Datatables/Manage_Product_Category_Source.dart';
import 'package:retailerp/LocalDbModels/product_category.dart';
import 'package:retailerp/Pagination_notifier/Manage_Product_Category_datanotifier.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/popup_menu.dart';
import 'package:retailerp/pages/add_product_category_screen.dart';
import 'package:retailerp/pages/update_product_category_screen.dart';
import 'package:retailerp/providers/popup_menu_item.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/widgets/Custom_paginated_datatables.dart';

class ManageProductCategory extends StatefulWidget {
  @override
  _ManageProductCategoryState createState() => _ManageProductCategoryState();
}

class _ManageProductCategoryState extends State<ManageProductCategory> {
  PopupMenu _selectedMenu = productCategoryPopupMenu2[0];
  DatabaseHelper databaseHelper = DatabaseHelper();
  int rowcountdata;
  String stringConvertIdValue;
  List<ProductCategory> productCatList = [];
  List<ProductCategory> searchProductCatList = [];
  ProductCategory productCategory;
  static const int kTabletBreakpoint = 552;
  bool _showCircle = false;
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget appBarTitle = Text("Manage Product Category");

  // List<ProductCategory> selectedProCat;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    Provider.of<ManageProductCategoryDataNotifier>(context, listen: false)
        .clear();
    super.initState();
    // updateListView();
    _getProductsCategory();
    // selectedProCat = [];
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileManageProductCat();
    } else {
      content = _buildTabletManageSales();
    }

    return content;
  }

  Widget _buildTabletManageSales() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.18;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.25;
    final _provider = context.watch<ManageProductCategoryDataNotifier>();
    final _model = _provider.ManageProductCategoryModel;
    final _dtSource = ManageProductCategoryDataTableSource(
        ManageProductCategoryData: _model, context: context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Product Category"),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
          new PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              size: 28,
              color: Colors.white,
            ),
            itemBuilder: (BuildContext context) {
              return productCategoryPopupMenu2.map((PopupMenu popupMenu) {
                return new PopupMenuItem(
                    value: popupMenu,
                    child: new ListTile(
                      dense: true,
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                      leading: popupMenu.icon,
                      title: new Text(popupMenu.title),
                    ));
              }).toList();
            },
            onSelected: _selectedPopMenu,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: _showCircle
                ? Center(child: CircularProgressIndicator())
                : rowcountdata == 0
                    ? Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Material(
                          shape: Border.all(color: Colors.blueGrey, width: 5),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: Text(
                                "No Product Category Available!",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.0,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 6,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: tabletWidth,
                                  height: 40,
                                  child: TextField(
                                    controller: searchController,
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "Start typing here..",
                                        suffixIcon: IconButton(
                                          icon: Icon(Icons.search),
                                          color: PrimaryColor,
                                          onPressed: () {},
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Expanded(
                          //   child: SingleChildScrollView(
                          //     child: Container(
                          //       child: Center(
                          //           child: DataTable(columns: [
                          //         DataColumn(
                          //             label: Container(
                          //           child: Center(
                          //             child: Text('Sr No', style: tableColmTextStyle),
                          //           ),
                          //         )),
                          //         DataColumn(
                          //             label: Container(
                          //           child: Center(
                          //             child: Text('Name', style: tableColmTextStyle),
                          //           ),
                          //         )),
                          //         DataColumn(
                          //             label: Container(
                          //           child: Center(
                          //             child: Text('Code', style: tableColmTextStyle),
                          //           ),
                          //         )),
                          //         DataColumn(
                          //             label: Container(
                          //           child: Center(
                          //             child: Text('Action', style: tableColmTextStyle),
                          //           ),
                          //         )),
                          //       ], rows: getDataRowList())),
                          //     ),
                          //   ),
                          // ),
                          CustomPaginatedTable(
                            dataColumns: _colGen(_provider),
                            // header: const Text("Sales Day Wise Report"),
                            onRowChanged: (index) =>
                                _provider.rowsPerPage = index,
                            rowsPerPage: _provider.rowsPerPage,
                            source: _dtSource,
                            showActions: true,
                            sortColumnIndex: _provider.sortColumnIndex,
                            sortColumnAsc: _provider.sortAscending,
                          ),
                        ],
                      ),
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 25),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                heroTag: "btn1",
                backgroundColor: PrimaryColor,
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => AddProductCategoryScreen()))
                      .then((value) => _reload(value));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DataColumn> _colGen(
    ManageProductCategoryDataNotifier _provider,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text(
            "Sr No",
            style: tablecolumname,
          ),
          numeric: true,
          tooltip: "Sr No",
        ),
        DataColumn(
          label: Text(
            'Product Catgeory Name',
            style: tablecolumname,
          ),
          tooltip: 'Name',
        ),
        DataColumn(
          label: Text(
            'Product Catgeory Code',
            style: tablecolumname,
          ),
          tooltip: 'Code',
        ),
        DataColumn(
          label: Text('Action', style: tablecolumname),
          tooltip: 'Action',
        ),
      ];

  void _sort<T>(
    Comparable<T> Function(ProductCategory sale) getField,
    int colIndex,
    bool asc,
    ManageProductCategoryDataNotifier _provider,
  ) {
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < searchProductCatList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

  DataRow getRow(int index) {
    var serNo = index + 1;
    return DataRow(cells: [
      DataCell(Center(child: Text(serNo.toString()))),
      DataCell(Center(child: Text(searchProductCatList[index].pCategoryname))),
      DataCell(Text(searchProductCatList[index].pParentCategoryName)),
      DataCell(
        Center(
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.edit,
                ),
                color: Colors.green,
                onPressed: () {
                  navigateToUpdate(index, searchProductCatList);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                color: Colors.red,
                onPressed: () {
                  _showMyDialog(searchProductCatList[index].catid);
                },
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  // Future<String> getStringText() async {
  //   stringConvertIdValue = await databaseHelper.getParentProductName(1);
  //   print('Values: $stringConvertIdValue');
  // }

  Widget _buildMobileManageProductCat() {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        actions: [
          Row(
            children: [
              IconButton(
                icon: actionIcon,
                onPressed: () {
                  setState(() {
                    if (actionIcon.icon == Icons.search) {
                      actionIcon = new Icon(
                        Icons.close,
                        color: Colors.white,
                      );
                      appBarTitle = TextField(
                        controller: searchController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                            prefixIcon:
                                new Icon(Icons.search, color: Colors.white),
                            hintText: "Search...",
                            hintStyle: TextStyle(color: Colors.white)),
                      );
                    } else {
                      actionIcon = new Icon(
                        Icons.search,
                        color: Colors.white,
                      );
                      appBarTitle = new Text(
                        "Manage Product Category",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      );
                      searchController.clear();
                    }
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName(Navigator.defaultRouteName));
                },
              ),
            ],
          ),
          new PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              size: 28,
              color: Colors.white,
            ),
            itemBuilder: (BuildContext context) {
              return productCategoryPopupMenu2.map((PopupMenu popupMenu) {
                return new PopupMenuItem(
                    value: popupMenu,
                    child: new ListTile(
                      dense: true,
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                      leading: popupMenu.icon,
                      title: new Text(popupMenu.title),
                    ));
              }).toList();
            },
            onSelected: _selectedPopMenu,
          )
        ],
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _showCircle,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: GestureDetector(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: searchProductCatList.length,
                        itemBuilder: (context, index) {
                          print("//in index////$index");
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Category Name: ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18.0,
                                        )),
                                    Text(
                                        "${searchProductCatList[index].pCategoryname}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Code: ",
                                            style: headHintTextStyle),
                                        Text(
                                            "${searchProductCatList[index].pParentCategoryName}",
                                            style: tablecolumname),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            // navigateToUpdate(
                                            //     productCatList[index].catid,
                                            //     productCatList[index]
                                            //         .pParentCategoryId,
                                            //     productCatList[index].pCategoryname);
                                            navigateToUpdate(
                                                index, searchProductCatList);
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.green,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            _showMyDialog(
                                                searchProductCatList[index]
                                                    .catid);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider()
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectedPopMenu(PopupMenu popupMenu) {
    setState(() {
      _selectedMenu = popupMenu;
      print(_selectedMenu.title);
    });
  }

  void _getProductsCategory() async {
    try {
      setState(() {
        _showCircle = true;
      });
      ProductFetch Productfetch = new ProductFetch();
      var productData = await Productfetch.getProductCategory("1");
      int resid = productData["resid"];
      String msg = productData["message"];
      if (resid == 200) {
        var rowcount = productData["rowcount"];
        rowcountdata = rowcount;
        if (rowcount < 0) {
          setState(() {
            _showCircle = false;
          });
          _showUploadDialog(msg, Colors.red);
        } else {
          productCatList.clear();
          var productsd = productData["productcategories"];
          print(productsd.length);
          List<ProductCategory> productCat = [];
          for (var n in productsd) {
            ProductCategory pro = ProductCategory.withId(
                int.parse(n['ProductCategoriesId']),
                n['ProductCategoriesName'],
                int.parse(n['productCategioresParentId']),
                n['productCategioresParentName']);
            productCat.add(pro);
            Provider.of<ManageProductCategoryDataNotifier>(context,
                    listen: false)
                .addManageProductCategoryData(pro);
          }

          setState(() {
            productCatList = productCat;
            searchProductCatList = productCatList;
            _showCircle = false;
          });

          searchController.addListener(() {
            setState(() {
              if (productCatList != null) {
                String s = searchController.text;

                searchProductCatList = productCatList
                    .where((element) =>
                        element.catid
                            .toString()
                            .toLowerCase()
                            .contains(s.toLowerCase()) ||
                        element.pParentCategoryName
                            .toLowerCase()
                            .contains(s.toLowerCase()) ||
                        element.pCategoryname
                            .toLowerCase()
                            .contains(s.toLowerCase()))
                    .toList();
              }
            });
          });
        }
      } else {
        setState(() {
          _showCircle = false;
        });
        _showUploadDialog(msg, Colors.red);
      }
    } catch (e) {
      setState(() {
        _showCircle = false;
      });
      print(e.toString());
    }
  }

  Future<void> _showMyDialog(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              "Want To Delete!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Delete'),
                onPressed: () async {
                  ProductFetch salesdelete = new ProductFetch();
                  var result =
                      await salesdelete.productCategoryDelete(id.toString());
                  print("///delete id///$id");
                  Navigator.of(context).pop();
                  _getProductsCategory();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // void navigateToUpdate(int rowID, int cType, String cName) async {
  //   stringConvertIdValue = await databaseHelper.getParentProductName(cType);
  //   // bool result =
  //   //     await Navigator.push(context, MaterialPageRoute(builder: (context) {
  //   //   return UpdateProductCategoryScreen(productCategory, rowID, cType, cName);
  //   // }));
  //
  //   // Navigator.of(context)
  //   //     .push(MaterialPageRoute(
  //   //         builder: (context) => UpdateProductCategoryScreen(
  //   //             productCategory, rowID, cType, cName)))
  //   //     .then((value) => _reload(value));
  //
  //   // if (result == true) {
  //   //   updateListView();
  //   // }
  // }

  void navigateToUpdate(index, productCategory) async {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) =>
                UpdateProductCategoryScreen(index, productCategory)))
        .then((value) => _reload(value));
  }

  // void updateListView() {
  //   final Future<Database> dbFuture = databaseHelper.initializeDatabase();
  //   dbFuture.then((value) {
  //     Future<List<ProductCategory>> todoListFuture =
  //         databaseHelper.getProductCatList();
  //     todoListFuture.then((productCatList) {
  //       setState(() {
  //         this.productCatList = productCatList;
  //         this.count = productCatList.length;
  //       });
  //     });
  //   });
  // }

  _reload(value) {
    _getProductsCategory();
    // updateListView();
  }

  Future<void> _showUploadDialog(String msg, Color col) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              msg,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: col,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => super.widget));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
