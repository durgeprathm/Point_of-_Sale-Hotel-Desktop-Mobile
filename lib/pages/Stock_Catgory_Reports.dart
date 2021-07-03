import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/pos-Stockcategory_fetch.dart';
import 'package:retailerp/Datatables/Stock_Category_Reports_Source.dart';
import 'package:retailerp/LocalDbModels/product_category.dart';
import 'package:retailerp/Pagination_notifier/Stock_Category_Reports_datanotifier.dart';
import 'package:retailerp/pages/Stock_Company_Reports.dart';
import 'package:retailerp/pages/Stock_Reports.dart';
import 'package:retailerp/pages/stock_Category_report_print.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/widgets/Custom_paginated_datatables.dart';


class StockCatgoryReports extends StatefulWidget {
  @override
  _StockCatgoryReportsState createState() => _StockCatgoryReportsState();
}

class _StockCatgoryReportsState extends State<StockCatgoryReports> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileStockCatgoryReports();
    } else {
      content = _buildTabletStockCatgoryReports();
    }

    return content;
  }




  bool _showCircle = false;
  Widget appBarTitle = Text("Stock Category Reports");
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
  List<ProductCategory> StockCatgoryList = new List();
  List<ProductCategory> StockCatgoryListSearch = new List();
  TextEditingController SerachController = new TextEditingController();
  int count;

  @override
  void initState() {
    Provider.of<StockCategoryReportsDataNotifier>(context, listen: false).clear();
    _getStockCategoryFetchItems();
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletStockCatgoryReports() {
    var tabletWidth =MediaQuery.of(context).size.width * 0.18;
    var tabletWidthSearch =MediaQuery.of(context).size.width * 0.25;
    final _provider = context.watch<StockCategoryReportsDataNotifier>();
    final _model = _provider.StockCategoryReportsModel;
    final _dtSource = StockCategoryDataTableSource(
      StockCatgeoryData: _model,
    );

    void handleClick(String value) {
      switch (value) {
        case 'Stock Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => StockReports()));
          break;
        case 'Stock Company Wise Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => StockCompanyReports()));
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
            Text('Stock Category Reports'),
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
          StockCatgoryList.length != 0
              ? IconButton(
            icon: Icon(Icons.print, color: Colors.white),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) {
                return StockCatgeoryReportPrint(1, StockCatgoryList);
              }));
            },
          )
              : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Stock Reports','Stock Company Wise Reports',
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
              child: StockCatgoryList.length == 0
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: tabletWidth,
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
                          ],
                        ),
                        CustomPaginatedTable(
                          dataColumns: _colGen(_provider),
                          // header: const Text("Sales Day Wise Report"),
                          onRowChanged: (index) => _provider.rowsPerPage = index,
                          rowsPerPage: _provider.rowsPerPage,
                          source: _dtSource,
                          showActions: true,
                          sortColumnIndex: _provider.sortColumnIndex,
                          sortColumnAsc: _provider.sortAscending,
                        ),
                      ],
                    )),
        ),
      ),
    );
  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobileStockCatgoryReports() {
    void handleClick(String value) {
      switch (value) {
        case 'Stock Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => StockReports()));
          break;
        case 'Stock Company Wise Reports':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => StockCompanyReports()));
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
                        "Stock Category Reports",
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
              StockCatgoryList.length != 0
                  ? IconButton(
                icon: Icon(Icons.print, color: Colors.white),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) {
                    return StockCatgeoryReportPrint(1, StockCatgoryList);
                  }));
                },
              )
                  : Text(''),
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {'Stock Reports','Stock Company Wise Reports'}
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
        ],
      ),
      body: SafeArea(
        child: Center(
            child:StockCatgoryList.length == 0
                ? Center(child: CircularProgressIndicator())
                :
         Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DataTable(columns: [
                  DataColumn(
                      label: Expanded(
                        child: Container(
                          child: Text('Sr No',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                      )),
                  DataColumn(
                      label: Expanded(
                        child: Container(
                          child: Text('Stock Category Name',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                      )),
                ], rows: getRowmmMobile()),
              ),
            ],
          ),
        )),
      ),
    );
  }

//---------------Mobile Mode End-------------//

  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(StockCatgoryList[index].catid.toString())),
      DataCell(Text(StockCatgoryList[index].pCategoryname)),
      DataCell(Text(StockCatgoryList[index].pParentCategoryName)),
    ]);
  }

  DataRow getRowMobile(int index) {
    return DataRow(cells: [
      DataCell(Text(StockCatgoryList[index].catid.toString())),
      DataCell(Text(StockCatgoryList[index].pCategoryname)),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();
    for (int i = 0; i < StockCatgoryList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

  List<DataColumn> _colGen(
      StockCategoryReportsDataNotifier _provider,
      ) =>
      <DataColumn>[
        DataColumn(
          label: Text("Sr No"),
          numeric: true,
          tooltip:"Sr No",
        ),
        DataColumn(
          label: Text('Stock Category Name'),
          tooltip: 'Stock Category Name',
        ),
        DataColumn(
          label: Text('Stock Parent Category Name'),
          tooltip: 'Stock Parent Category Name',
        ),
      ];

  void _sort<T>(
      Comparable<T> Function(ProductCategory sale) getField,
      int colIndex,
      bool asc,
      StockCategoryReportsDataNotifier _provider,
      ) {
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }






  List<DataRow> getRowmmMobile() {
    List<DataRow> myTempDataRow = List();
    for (int i = 0; i < StockCatgoryList.length; i++) {
      myTempDataRow.add(getRowMobile(i));
    }
    return myTempDataRow;
  }

//from server fetching All product category Data
  void _getStockCategoryFetchItems() async {
    StockCategoryFetchItems stockcategoryfetchitems =
        new StockCategoryFetchItems();
    var StockCategoryFetchItemsData =
        await stockcategoryfetchitems.getStockCategoryFetchItems("0");
    var resid = StockCategoryFetchItemsData["resid"];
    var StockCategoryFetchItemssd = StockCategoryFetchItemsData["productcategories"];
    List<ProductCategory> tempStockCategoryList = [];
    for (var n in StockCategoryFetchItemssd) {
      ProductCategory pro =
      ProductCategory.withId(int.parse(n["ProductCategoriesId"]), n["ProductCategoriesName"],int.parse(n["productCategioresParentId"]), n["productCategioresParentName"]);
      tempStockCategoryList.add(pro);
      Provider.of<StockCategoryReportsDataNotifier>(context, listen: false)
          .addStockCategoryData(pro);
    }
    setState(() {
      this.StockCatgoryList = tempStockCategoryList;
      this.StockCatgoryListSearch = tempStockCategoryList;
    });
    print("//////StockCatgoryList/////////$StockCatgoryList.length");




//For Search
    SerachController.addListener(() {
      setState(() {
      if(StockCatgoryListSearch != null){
      String s = SerachController.text;
      StockCatgoryList = StockCatgoryListSearch.where((element) => element.catid.toString().toLowerCase().contains(s.toLowerCase()) || element.pCategoryname.toLowerCase().contains(s.toLowerCase())).toList();
      }
      });
    });
  }


}
