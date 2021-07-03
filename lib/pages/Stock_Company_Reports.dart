import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/pos_StockReport_Categorywise_fetch.dart';
import 'package:retailerp/Adpater/pos_StockReport_companywise_fetch.dart';
import 'package:retailerp/Adpater/pos_product_CompanyforStockReports_fetch.dart';
import 'package:retailerp/Adpater/pos_product_category_fetch.dart';
import 'package:retailerp/Adpater/pos_product_fetch.dart';
import 'package:retailerp/Adpater/pos_sales_delete.dart';
import 'package:retailerp/LocalDbModels/product_category.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/pages/Manage_Sales.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';

import 'Add_Sales.dart';
import 'Import_sales.dart';
import 'Stock_report_print.dart';

class StockCompanyReports extends StatefulWidget {
  @override
  _StockCompanyReportsState createState() => _StockCompanyReportsState();
}

class _StockCompanyReportsState extends State<StockCompanyReports> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileStockCompanyReports();
    } else {
      content = _buildTabletStockCompanyReports();
    }

    return content;
  }

  bool _showCircle = false;
  Widget appBarTitle = Text("Company Reports");
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
//-------------------------------------------
  final _fromDatetext = TextEditingController();
  final _toDatetext = TextEditingController();
  DateTime fromValue = DateTime.now();
  DateTime toValue = DateTime.now();
  bool _fromDatevalidate = false;
  bool _toDatevalidate = false;
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  bool autoValidate = false;
  bool showResetIcon = false;
  bool readOnly = false;
  final dateFormat = DateFormat("yyyy-MM-dd");
  final initialValue = DateTime.now();
  String Sendingprocat;

  //DatabaseHelper databaseHelper = DatabaseHelper();
  List<ProductModel> CompanyList = new List();
  List<ProductModel> ProductCompanyList = new List();
  List<ProductModel> CompanyListSearch = new List();
  List<Sales> CashBillDateWiseList = new List();
  List<ProductCategory> ProductCategoryList = new List();
  List<String> ProductCategoryName = new List();
  List<String> ProductCompanyName = new List();
  TextEditingController SerachController = new TextEditingController();
  int count;

  @override
  void initState() {
    _getProductList();
    _getProductCategory();
    _getProductCompany();
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletStockCompanyReports() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.20;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.30;
    void handleClick(String value) {
      switch (value) {
        case 'Stock Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSales()));
          break;
        case 'Stock Category':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSales()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.building),
            SizedBox(
              width: 20.0,
            ),
            Text('Stock Company Wise Reports'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
          CompanyList.length != 0
              ? IconButton(
            icon: Icon(Icons.print, color: Colors.white),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) {
                return StockReportPrint(1, CompanyList);
              }));
            },
          )
              : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Stock Reports'
                    'Stock Category',
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
              child: CompanyList.length == 0
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: tabletWidthSearch,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: TextField(
                                  controller: SerachController,
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
                            ),
                            Container(
                              width: tabletWidth,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: DropdownSearch<ProductCategory>(
                                  isFilteredOnline: true,
                                  showClearButton: true,
                                  showSearchBox: true,
                                  items: ProductCategoryList,
                                  label: "Category",
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onChanged: (value) {
                                    int procatId = value.catid;
                                    print(procatId);
                                    if (procatId == "All" || procatId == null) {
                                      _getProductList();
                                    } else {
                                      _getsortproductcat(procatId.toString());
                                    }
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: tabletWidth,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: DropdownSearch(
                                  isFilteredOnline: true,
                                  showClearButton: true,
                                  showSearchBox: true,
                                  items: ProductCompanyName,
                                  label: "Company",
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onChanged: (value) {
                                    if (value == "All" || value == null) {
                                      _getProductList();
                                    } else {
                                      _getsortproductCompany(value);
                                    }

                                    print(value);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DataTable(columns: [
                            DataColumn(
                                label: Expanded(
                              child: Container(
                                child: Text('Sr NO',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Container(
                                width: 150,
                                child: Text('Company Name',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Container(
                                child: Text('Product Name',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Container(
                                child: Text('Category',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Container(
                                child: Text('Quntity',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Container(
                                child: Text('Selling Price',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )),
                          ], rows: getDataRowList()),
                        ),
                      ],
                    )),
        ),
      ),
    );
  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobileStockCompanyReports() {
    void handleClick(String value) {
      switch (value) {
        case 'Stock Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSales()));
          break;
        case 'Stock Category':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSales()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
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
                        controller: SerachController,
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
                        "Company Reports",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      );
                      SerachController.clear();
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
              CompanyList.length != 0
                  ? IconButton(
                      icon: Icon(Icons.print, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return StockReportPrint(1, CompanyList);
                        }));
                      },
                    )
                  : Text(''),
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {
                    'Stock Reports',
                    'Stock Category',
                  }.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: CompanyList.length == 0
              ? Center(child: CircularProgressIndicator())
              : ModalProgressHUD(
                  inAsyncCall: _showCircle,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          child: DropdownSearch(
                            items: ProductCategoryList,
                            showClearButton: true,
                            showSearchBox: true,
                            label: 'Product Category',
                            hint: "Product Category",
                            // selectedItem: 'All',
                            searchBoxDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                              labelText: "Category",
                            ),
                            onChanged: (value) {
                              int procatId = value.catid;
                              print(procatId);
                              if (procatId == "All" || procatId == null) {
                                _getProductList();
                              } else {
                                _getsortproductcat(procatId.toString());
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 40,
                          child: DropdownSearch(
                            items: ProductCompanyName,
                            showClearButton: true,
                            showSearchBox: true,
                            label: 'Menu Company',
                            hint: "Menu Company",
                            // selectedItem: 'All',
                            searchBoxDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                              labelText: "Company",
                            ),
                            onChanged: (value) {
                              if (value == "All" || value == null) {
                                _getProductList();
                              } else {
                                _getsortproductCompany(value);
                              }

                              print(value);
                            },
                          ),
                        ),
                        Divider(),
                        Expanded(
                          child: Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: CompanyList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Product No:- ${CompanyList[index].proId.toString()} ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                "Rs.${CompanyList[index].proSellingPrice}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text("Product Company:",
                                                    style: headHintTextStyle),
                                                Text(
                                                    "${CompanyList[index].proComName.toString()}",
                                                    style: headsubTextStyle),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Row(
                                              children: [
                                                Text("Product Name:",
                                                    style: headHintTextStyle),
                                                Text(
                                                    "${CompanyList[index].proName}",
                                                    style: headsubTextStyle),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Row(
                                              children: [
                                                Text("Product Category:",
                                                    style: headHintTextStyle),
                                                Text(
                                                    "${CompanyList[index].proCategory.toString()}",
                                                    style: headsubTextStyle),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Row(
                                              children: [
                                                Text("Product Quntity:",
                                                    style: headHintTextStyle),
                                                Text(
                                                    "${CompanyList[index].proOpeningBal.toString()}",
                                                    style: headsubTextStyle),
                                              ],
                                            ),
                                            Divider(),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

//---------------Mobile Mode End-------------//

  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(CompanyList[index].proId.toString())),
      DataCell(Text(CompanyList[index].proComName)),
      DataCell(Text(CompanyList[index].proName)),
      DataCell(Text(CompanyList[index].proCategory)),
      DataCell(Text(CompanyList[index].proOpeningBal.toString())),
      DataCell(Text(CompanyList[index].proSellingPrice.toString())),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < CompanyList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

  //-------------------------------------
//from server fetching All Company Data
  void _getProductList() async {
    ProductFetch productfetch = new ProductFetch();
    var ProductData = await productfetch.getposproduct("1");
    var resid = ProductData["resid"];
    var productsd = ProductData["product"];
    print(productsd.length);
    List<ProductModel> tempProductList = [];
    for (var n in productsd) {
      ProductModel pro = ProductModel.withId(
          int.parse(n["ProductId"]),
          n["ProductType"],
          int.parse(n["ProductCode"]),
          n["ProductName"],
          n["ProductCompanyName"],
          n["ProductCategories"],
          int.parse(n["ProductCategoriesID"]),
          0,
          double.parse(n["ProductSellingPrice"]),
          n["HSNCode"],
          n["Tax"],
          n["ProductImg"],
          n["Unit"],
          int.parse(n["ProductOpeningBalance"]),
          n["ProductBillingMethod"],
          n["Including Tax"],
          '');
      tempProductList.add(pro);
    }
    setState(() {
      this.CompanyList = tempProductList;
      this.CompanyListSearch = tempProductList;
    });
    print("//////CompanyList/////////$CompanyList.length");

    SerachController.addListener(() {
      setState(() {
        if (CompanyListSearch != null) {
          String s = SerachController.text;
          CompanyList = CompanyListSearch.where((element) =>
              element.proId
                  .toString()
                  .toLowerCase()
                  .contains(s.toLowerCase()) ||
              element.proName.toLowerCase().contains(s.toLowerCase()) ||
              element.proCategory.toLowerCase().contains(s.toLowerCase()) ||
              element.proComName.toLowerCase().contains(s.toLowerCase()) ||
              element.proOpeningBal
                  .toString()
                  .toLowerCase()
                  .contains(s.toLowerCase()) ||
              element.proSellingPrice
                  .toString()
                  .toLowerCase()
                  .contains(s.toLowerCase())).toList();
        }
      });
    });
  }

//from server Category From data base
//from server fetching All Product category Data
  void _getProductCategory() async {
    ProductCategoryFetch productcategoryfetch = new ProductCategoryFetch();
    var productcategoryfetchData =
        await productcategoryfetch.getProductCategoryFetch("1");
    var resid = productcategoryfetchData["resid"];
    var productcategoryfetchsd = productcategoryfetchData["productcategories"];
    //print(productcategoryfetchsd.length);
    List<ProductCategory> tempCustomer = [];
    for (var n in productcategoryfetchsd) {
      ProductCategory pro = ProductCategory.withId(
        int.parse(n["ProductCategoriesId"]),
        n["ProductCategoriesName"],
        int.parse(n["productCategioresParentId"]),
        n["productCategioresParentName"],
      );
      tempCustomer.add(pro);
    }
    setState(() {
      this.ProductCategoryList = tempCustomer;
    });
    print("//////ProductCategoryList/////////$ProductCategoryList.length");
  }

  //from server fetching All Product Company Data
  void _getProductCompany() async {
    ProductCompanyFetch productcompanyfetch = new ProductCompanyFetch();
    var getProductCompanyFetchData =
        await productcompanyfetch.getProductCompanyFetch("1");
    var resid = getProductCompanyFetchData["resid"];
    var getProductCompanyFetchsd = getProductCompanyFetchData["product"];
    //print(productcategoryfetchsd.length);
    List<ProductModel> tempgetProductCompanyFetchData = [];
    for (var n in getProductCompanyFetchsd) {
      ProductModel pro = ProductModel.withProductCompanyName(
        n["ProductCompanyName"],
      );
      tempgetProductCompanyFetchData.add(pro);
    }
    setState(() {
      this.ProductCompanyList = tempgetProductCompanyFetchData;
    });
    print("//////ProductCompanyList/////////${ProductCompanyList.length}");

    List<String> tempProductCompanyName = [];
    tempProductCompanyName.add("All");
    for (int i = 0; i < ProductCompanyList.length; i++) {
      tempProductCompanyName.add(ProductCompanyList[i].proComName);
    }
    setState(() {
      this.ProductCompanyName = tempProductCompanyName;
    });
    print(ProductCompanyName);
  }

//-------------------------------------
//from server Sorting Data Category Wise
  void _getsortproductcat(String id) async {
    SortCategoryWiseFetch sortcategorywisefetch = new SortCategoryWiseFetch();
    var sortcategorywisefetchData =
        await sortcategorywisefetch.getSortCategoryWiseFetch(id);
    var resid = sortcategorywisefetchData["resid"];

    if (resid == 200) {
      var sortcategorywisefetchsd = sortcategorywisefetchData["product"];
      List<ProductModel> sortcategorywisefetchfetch = [];
      for (var n in sortcategorywisefetchsd) {
        ProductModel pro = ProductModel.withId(
            int.parse(n["ProductId"]),
            n["ProductType"],
            int.parse(n["ProductCode"]),
            n["ProductName"],
            n["ProductCompanyName"],
            n["ProductcategoriesName"],
            int.parse(n["ProductCategoriesID"]),
            0,
            double.parse(n["ProductSellingPrice"]),
            n["HSNCode"],
            n["Tax"],
            n["ProductImg"],
            n["Unit"],
            int.parse(n["ProductOpeningBalance"]),
            n["ProductBillingMethod"],
            n["Including Tax"],
            '');
        sortcategorywisefetchfetch.add(pro);
      }
      CompanyList.clear();
      setState(() {
        this.CompanyList = sortcategorywisefetchfetch;
      });
      print("//////CompanyList/////////$CompanyList.length");
    } else {
      String message = sortcategorywisefetchData["message"];
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black38,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  //from server Sorting Data Company Wise
  void _getsortproductCompany(String Company) async {
    SortCompanyWiseFetch sortcompanywisefetch = new SortCompanyWiseFetch();
    var SortCompanyWiseFetchData =
        await sortcompanywisefetch.getSortCompanyWiseFetch(Company);
    var resid = SortCompanyWiseFetchData["resid"];

    if (resid == 200) {
      var SortCompanyWiseFetchsd = SortCompanyWiseFetchData["product"];
      List<ProductModel> SortCompanyWiseFetchfetch = [];
      for (var n in SortCompanyWiseFetchsd) {
        ProductModel pro = ProductModel.withId(
            int.parse(n["ProductId"]),
            n["ProductType"],
            int.parse(n["ProductCode"]),
            n["ProductName"],
            n["ProductCompanyName"],
            n["ProductcategoriesName"],
            int.parse(n["ProductCategoriesID"]),
            0,
            double.parse(n["ProductSellingPrice"]),
            n["HSNCode"],
            n["Tax"],
            n["ProductImg"],
            n["Unit"],
            int.parse(n["ProductOpeningBalance"]),
            n["ProductBillingMethod"],
            n["Including Tax"],
            '');
        SortCompanyWiseFetchfetch.add(pro);
      }
      CompanyList.clear();
      setState(() {
        this.CompanyList = SortCompanyWiseFetchfetch;
      });
      print("//////CompanyList/////////$CompanyList.length");
    } else {
      String message = SortCompanyWiseFetchData["message"];
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black38,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}
