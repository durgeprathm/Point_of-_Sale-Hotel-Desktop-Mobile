import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/Fetch_Stock_Report.dart';
import 'package:retailerp/Adpater/pos_StockReport_Categorywise_fetch.dart';
import 'package:retailerp/Adpater/pos_StockReport_companywise_fetch.dart';
import 'package:retailerp/Adpater/pos_product_CompanyforStockReports_fetch.dart';
import 'package:retailerp/Adpater/pos_product_category_fetch.dart';
import 'package:retailerp/Adpater/pos_product_fetch.dart';
import 'package:retailerp/Datatables/Stock_Reports_Source.dart';
import 'package:retailerp/LocalDbModels/product_category.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/Pagination_notifier/Stock_Reports_datanotifier.dart';
import 'package:retailerp/models/Sales.dart';
import 'package:retailerp/pages/Manage_Sales.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/widgets/Custom_paginated_datatables.dart';

import 'Add_Sales.dart';
import 'Import_sales.dart';
import 'Stock_report_print.dart';

class StockReports extends StatefulWidget {
  @override
  _StockReportsState createState() => _StockReportsState();
}

class _StockReportsState extends State<StockReports> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      //content = _buildMobileStockReports();
    } else {
      content = _buildTabletStockReports();
    }

    return content;
  }

  bool _showCircle = false;
  Widget appBarTitle = Text("Stock Reports");
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
//-------------------------------------------
  DateTime fromValue = DateTime.now();
  DateTime toValue = DateTime.now();
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
  List<ProductModel> ProductList = new List();
  List<ProductModel> ProductListSearch = new List();
  List<ProductModel> ProductCompanyList = new List();
  List<Sales> CashBillDateWiseList = new List();
  List<ProductCategory> ProductCategoryList = new List();
  List<String> ProductCategoryName = new List();
  List<String> ProductCompanyName = new List();
  TextEditingController SerachController = new TextEditingController();
  int count;

  @override
  void initState() {
    Provider.of<StockReportsDataNotifier>(context, listen: false).clear();
    // _getProductList();
    // _getProductCategory();
    // _getProductCompany();
    _getStockList();
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletStockReports() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.18;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.25;
    final _provider = context.watch<StockReportsDataNotifier>();
    final _model = _provider.StockReportsModel;
    final _dtSource = StockReportsDataTableSource(
      StockReportsData: _model,
    );
    void handleClick(String value) {
      switch (value) {
        case 'Stock Category Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSales()));
          break;
        case 'Stock Company Wise Reports':
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
            FaIcon(FontAwesomeIcons.moneyBill),
            SizedBox(
              width: 20.0,
            ),
            Text('Stock Reports'),
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
          ProductList.length != 0
              ? IconButton(
                  icon: Icon(Icons.print, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return StockReportPrint(1, ProductList);
                    }));
                  },
                )
              : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Stock Category Reports', 'Stock Company Wise Reports'}
                  .map((String choice) {
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
              child: ProductList.length == 0
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
                            // Container(
                            //   width: tabletWidth,
                            //   child: Padding(
                            //     padding: const EdgeInsets.symmetric(
                            //         vertical: 10.0, horizontal: 20.0),
                            //     child: DropdownSearch<ProductCategory>(
                            //       isFilteredOnline: true,
                            //       showClearButton: true,
                            //       showSearchBox: true,
                            //       items: ProductCategoryList,
                            //       label: "Category",
                            //       autoValidateMode:
                            //           AutovalidateMode.onUserInteraction,
                            //       onChanged: (value) {
                            //         int procatId = value.catid;
                            //         print(procatId);
                            //         if (procatId == "All" || procatId == null) {
                            //           _getProductList();
                            //         } else {
                            //           _getsortproductcat(procatId.toString());
                            //         }
                            //       },
                            //     ),
                            //   ),
                            // ),
                            // Container(
                            //   width: tabletWidth,
                            //   child: Padding(
                            //     padding: const EdgeInsets.symmetric(
                            //         vertical: 10.0, horizontal: 20.0),
                            //     child: DropdownSearch(
                            //       isFilteredOnline: true,
                            //       showClearButton: true,
                            //       showSearchBox: true,
                            //       items: ProductCompanyName,
                            //       label: "Company",
                            //       autoValidateMode:
                            //           AutovalidateMode.onUserInteraction,
                            //       onChanged: (value) {
                            //         if (value == "All" || value == null) {
                            //           _getProductList();
                            //         } else {
                            //           _getsortproductCompany(value);
                            //         }
                            //
                            //         print(value);
                            //       },
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),

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
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: DataTable(columns: [
                        //     DataColumn(
                        //         label: Expanded(
                        //       child: Container(
                        //         child: Text('Sr\nNo',
                        //             style: TextStyle(
                        //                 fontSize: 20,
                        //                 fontWeight: FontWeight.bold)),
                        //       ),
                        //     )),
                        //     DataColumn(
                        //         label: Expanded(
                        //       child: Container(
                        //         width: 150,
                        //         child: Text('Product Name',
                        //             style: TextStyle(
                        //                 fontSize: 20,
                        //                 fontWeight: FontWeight.bold)),
                        //       ),
                        //     )),
                        //     DataColumn(
                        //         label: Expanded(
                        //       child: Container(
                        //         child: Text('Product Company',
                        //             style: TextStyle(
                        //                 fontSize: 20,
                        //                 fontWeight: FontWeight.bold)),
                        //       ),
                        //     )),
                        //     DataColumn(
                        //         label: Expanded(
                        //           child: Container(
                        //             child: Text('Product Catgory',
                        //                 style: TextStyle(
                        //                     fontSize: 20,
                        //                     fontWeight: FontWeight.bold)),
                        //           ),
                        //         )),
                        //     DataColumn(
                        //         label: Expanded(
                        //       child: Container(
                        //         child: Text('Purchse Qty',
                        //             style: TextStyle(
                        //                 fontSize: 20,
                        //                 fontWeight: FontWeight.bold)),
                        //       ),
                        //     )),
                        //     DataColumn(
                        //         label: Expanded(
                        //       child: Container(
                        //         child: Text('Sales Qty',
                        //             style: TextStyle(
                        //                 fontSize: 20,
                        //                 fontWeight: FontWeight.bold)),
                        //       ),
                        //     )),
                        //     DataColumn(
                        //         label: Expanded(
                        //       child: Container(
                        //         child: Text('In Stock',
                        //             style: TextStyle(
                        //                 fontSize: 20,
                        //                 fontWeight: FontWeight.bold)),
                        //       ),
                        //     )),
                        //   ], rows: getDataRowList()),
                        // ),
                      ],
                    )),
        ),
      ),
    );
  }

//---------------Tablet Mode End-------------//



  List<DataColumn> _colGen(
      StockReportsDataNotifier _provider,
      ) =>
      <DataColumn>[
        DataColumn(
          label: Text("Sr NO"),
          numeric: true,
          tooltip: "Sr NO",
        ),
        DataColumn(
          label: Text('Product Name'),
          tooltip: 'Product Name',
        ),
        DataColumn(
          label: Text('Product Company'),
          tooltip: 'Product Company',
        ),
        DataColumn(
          label: Text('Product Catgory'),
          tooltip: 'Product Catgory',
        ),
        DataColumn(
          label: Text('Purchse Qty'),
          tooltip: 'Purchse Qty',
        ),
        DataColumn(
          label: Text('Sales Qty'),
          tooltip: 'Sales Qty',
        ),
        DataColumn(
          label: Text('In Stock'),
          tooltip: 'In Stock',
        ),
      ];

  void _sort<T>(
      Comparable<T> Function(ProductModel sale) getField,
      int colIndex,
      bool asc,
      StockReportsDataNotifier _provider,
      ) {
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }



  DataRow getRow(int index) {
    var srno=index+1;
    return DataRow(cells: [
      DataCell(Text(srno.toString())),
      DataCell(Text(ProductList[index].proName)),
      DataCell(Text(ProductList[index].proComName)),
      DataCell(Text(ProductList[index].proCategory)),
      DataCell(Text(ProductList[index].productpurchse)),
      DataCell(Text(ProductList[index].productsale.toString())),
      DataCell(Text(ProductList[index].productremaing.toString())),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < ProductList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

  //from server fetching All Stock Data
  void _getStockList() async {
    FetchStockReport fetchdtockreport = new FetchStockReport();
    var fetchdtockreportData = await fetchdtockreport.getFetchStockReport();
    var resid = fetchdtockreportData["resid"];
    var fetchdtockreportDatasd = fetchdtockreportData["stocklist"];
    print(fetchdtockreportDatasd.length);
    List<ProductModel> tempProductList = [];
    for (var n in fetchdtockreportDatasd) {
      ProductModel pro = ProductModel.stocklist(
        n["peproductqty"],
        n["sesalesqty"],
        n["Qty"],
        n["ProductId"],
        n["ProductCompanyName"],
        n["ProductName"],
        n["Productcatname"],
      );
      tempProductList.add(pro);
      Provider.of<StockReportsDataNotifier>(context, listen: false)
          .addStockReportsData(pro);
    }
    setState(() {
      this.ProductList = tempProductList;
      this.ProductListSearch = tempProductList;
    });
    print("//////ProductList/////////$ProductList.length");

    SerachController.addListener(() {
      setState(() {
        if (ProductListSearch != null) {
          String s = SerachController.text;
          ProductList = ProductListSearch.where((element) =>
              element.proId
                  .toString()
                  .toLowerCase()
                  .contains(s.toLowerCase()) ||
              element.proName.toLowerCase().contains(s.toLowerCase()) ||
              element.proComName.toLowerCase().contains(s.toLowerCase()) ||
              element.proCategory.toString().toLowerCase().contains(s.toLowerCase()) ||
              element.productpurchse.toLowerCase().contains(s.toLowerCase()) ||
              element.productremaing.toString().toLowerCase().contains(s.toLowerCase()) ||
              element.productsale.toString().toLowerCase().contains(s.toLowerCase())).toList();
        }
      });
    });
  }

// //from server fetching All Product Data
//   void _getProductList() async {
//     ProductFetch productfetch = new ProductFetch();
//     var ProductData = await productfetch.getposproduct("1");
//     var resid = ProductData["resid"];
//     var productsd = ProductData["product"];
//     print(productsd.length);
//     List<ProductModel> tempProductList = [];
//     for (var n in productsd) {
//       ProductModel pro = ProductModel.withId(
//           int.parse(n["ProductId"]),
//           n["ProductType"],
//           int.parse(n["ProductCode"]),
//           n["ProductName"],
//           n["ProductCompanyName"],
//           n["ProductCategories"],
//           int.parse(n["ProductCategoriesID"]),
//           0,
//           double.parse(n["ProductSellingPrice"]),
//           n["HSNCode"],
//           n["Tax"],
//           n["ProductImg"],
//           n["Unit"],
//           int.parse(n["ProductOpeningBalance"]),
//           n["ProductBillingMethod"],
//           n["Including Tax"],
//           '');
//       tempProductList.add(pro);
//     }
//     setState(() {
//       this.ProductList = tempProductList;
//       this.ProductListSearch = tempProductList;
//     });
//     print("//////CashBillList/////////$ProductList.length");
//
//     SerachController.addListener(() {
//       setState(() {
//         if (ProductListSearch != null) {
//           String s = SerachController.text;
//           ProductList = ProductListSearch.where((element) =>
//               element.proId
//                   .toString()
//                   .toLowerCase()
//                   .contains(s.toLowerCase()) ||
//               element.proName.toLowerCase().contains(s.toLowerCase()) ||
//               element.proCategory.toLowerCase().contains(s.toLowerCase()) ||
//               element.proComName.toLowerCase().contains(s.toLowerCase()) ||
//               element.proOpeningBal
//                   .toString()
//                   .toLowerCase()
//                   .contains(s.toLowerCase()) ||
//               element.proSellingPrice
//                   .toString()
//                   .toLowerCase()
//                   .contains(s.toLowerCase())).toList();
//         }
//       });
//     });
//   }
//
//
// //from server fetching All Product category Data
//   void _getProductCategory() async {
//     ProductCategoryFetch productcategoryfetch = new ProductCategoryFetch();
//     var productcategoryfetchData =
//         await productcategoryfetch.getProductCategoryFetch("1");
//     var resid = productcategoryfetchData["resid"];
//     var productcategoryfetchsd = productcategoryfetchData["productcategories"];
//     //print(productcategoryfetchsd.length);
//     List<ProductCategory> tempCustomer = [];
//     for (var n in productcategoryfetchsd) {
//       ProductCategory pro = ProductCategory.withId(
//         int.parse(n["ProductCategoriesId"]),
//         n["ProductCategoriesName"],
//         int.parse(n["productCategioresParentId"]),
//         n["productCategioresParentName"],
//       );
//       tempCustomer.add(pro);
//     }
//     setState(() {
//       this.ProductCategoryList = tempCustomer;
//     });
//     print("//////ProductCategoryList/////////$ProductCategoryList.length");
//   }
//
//   //from server fetching All Product Company Data
//   void _getProductCompany() async {
//     ProductCompanyFetch productcompanyfetch = new ProductCompanyFetch();
//     var getProductCompanyFetchData =
//         await productcompanyfetch.getProductCompanyFetch("1");
//     var resid = getProductCompanyFetchData["resid"];
//     var getProductCompanyFetchsd = getProductCompanyFetchData["product"];
//     //print(productcategoryfetchsd.length);
//     List<ProductModel> tempgetProductCompanyFetchData = [];
//     for (var n in getProductCompanyFetchsd) {
//       ProductModel pro = ProductModel.withProductCompanyName(
//         n["ProductCompanyName"],
//       );
//       tempgetProductCompanyFetchData.add(pro);
//     }
//     setState(() {
//       this.ProductCompanyList = tempgetProductCompanyFetchData;
//     });
//     print("//////ProductCompanyList/////////${ProductCompanyList.length}");
//
//     List<String> tempProductCompanyName = [];
//     tempProductCompanyName.add("All");
//     for (int i = 0; i < ProductCompanyList.length; i++) {
//       tempProductCompanyName.add(ProductCompanyList[i].proComName);
//     }
//     setState(() {
//       this.ProductCompanyName = tempProductCompanyName;
//     });
//     print(ProductCompanyName);
//   }
//
// //-------------------------------------
// //from server Sorting Data Category Wise
//   void _getsortproductcat(String id) async {
//     SortCategoryWiseFetch sortcategorywisefetch = new SortCategoryWiseFetch();
//     var sortcategorywisefetchData =
//         await sortcategorywisefetch.getSortCategoryWiseFetch(id);
//     var resid = sortcategorywisefetchData["resid"];
//
//     if (resid == 200) {
//       var sortcategorywisefetchsd = sortcategorywisefetchData["product"];
//       List<ProductModel> sortcategorywisefetchfetch = [];
//       for (var n in sortcategorywisefetchsd) {
//         ProductModel pro = ProductModel.withId(
//             int.parse(n["ProductId"]),
//             n["ProductType"],
//             int.parse(n["ProductCode"]),
//             n["ProductName"],
//             n["ProductCompanyName"],
//             n["ProductcategoriesName"],
//             int.parse(n["ProductCategoriesID"]),
//             0,
//             double.parse(n["ProductSellingPrice"]),
//             n["HSNCode"],
//             n["Tax"],
//             n["ProductImg"],
//             n["Unit"],
//             int.parse(n["ProductOpeningBalance"]),
//             n["ProductBillingMethod"],
//             n["Including Tax"],
//             '');
//         sortcategorywisefetchfetch.add(pro);
//       }
//       ProductList.clear();
//       setState(() {
//         this.ProductList = sortcategorywisefetchfetch;
//       });
//       print("//////ProductList/////////$ProductList.length");
//     } else {
//       String message = sortcategorywisefetchData["message"];
//       Fluttertoast.showToast(
//         msg: message,
//         toastLength: Toast.LENGTH_SHORT,
//         backgroundColor: Colors.black38,
//         textColor: Color(0xffffffff),
//         gravity: ToastGravity.BOTTOM,
//       );
//     }
//   }
//
//   //from server Sorting Data Company Wise
//   void _getsortproductCompany(String Company) async {
//     SortCompanyWiseFetch sortcompanywisefetch = new SortCompanyWiseFetch();
//     var SortCompanyWiseFetchData =
//         await sortcompanywisefetch.getSortCompanyWiseFetch(Company);
//     var resid = SortCompanyWiseFetchData["resid"];
//
//     if (resid == 200) {
//       var SortCompanyWiseFetchsd = SortCompanyWiseFetchData["product"];
//       List<ProductModel> SortCompanyWiseFetchfetch = [];
//       for (var n in SortCompanyWiseFetchsd) {
//         ProductModel pro = ProductModel.withId(
//             int.parse(n["ProductId"]),
//             n["ProductType"],
//             int.parse(n["ProductCode"]),
//             n["ProductName"],
//             n["ProductCompanyName"],
//             n["ProductcategoriesName"],
//             int.parse(n["ProductCategoriesID"]),
//             0,
//             double.parse(n["ProductSellingPrice"]),
//             n["HSNCode"],
//             n["Tax"],
//             n["ProductImg"],
//             n["Unit"],
//             int.parse(n["ProductOpeningBalance"]),
//             n["ProductBillingMethod"],
//             n["Including Tax"],
//             '');
//         SortCompanyWiseFetchfetch.add(pro);
//       }
//       ProductList.clear();
//       setState(() {
//         this.ProductList = SortCompanyWiseFetchfetch;
//       });
//       print("//////ProductList/////////$ProductList.length");
//     } else {
//       String message = SortCompanyWiseFetchData["message"];
//       Fluttertoast.showToast(
//         msg: message,
//         toastLength: Toast.LENGTH_SHORT,
//         backgroundColor: Colors.black38,
//         textColor: Color(0xffffffff),
//         gravity: ToastGravity.BOTTOM,
//       );
//     }
//   }
}
