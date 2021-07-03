import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/pos_menu_fetch.dart';
import 'package:retailerp/Adpater/pos_sort_menu_catgory_menureport.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/Datatables/Menu_Reports_Source.dart';
import 'package:retailerp/Pagination_notifier/Menu_Reports_datanotifier.dart';
import 'package:retailerp/models/Menu_Category.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/widgets/Custom_paginated_datatables.dart';

import '../models/menu.dart';
import 'Menu_Catgory_Reports.dart';
import 'Preview_sales.dart';
import 'menu_report_print.dart';

class MenuReports extends StatefulWidget {
  @override
  _MenuReportsState createState() => _MenuReportsState();
}

class _MenuReportsState extends State<MenuReports> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileMenuReports();
    } else {
      content = _buildTabletMenuReports();
    }

    return content;
  }

  bool _showCircle = false;
  Widget appBarTitle = Text("Menu Reports");
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
  List<Menu> MenuList = new List();
  List<Menu> MenuListSearch = new List();
  List<MenuCategory> MenuCatgoryList = new List();
  List<String> MenuCatgoryName = new List();
  TextEditingController SerachController = new TextEditingController();
  int count;

  @override
  void initState() {
    Provider.of<MenuReportsDataNotifier>(context, listen: false).clear();
    _getMenulist();
    _getMenuCategorylist();
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletMenuReports() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.18;
    var tabletWidthSearch = MediaQuery.of(context).size.width * 0.25;
    final _provider = context.watch<MenuReportsDataNotifier>();
    final _model = _provider.MenuReportsModel;
    final _dtSource = MenuReportsDataTableSource(MenuReportsData: _model);

    void handleClick(String value) {
      switch (value) {
        case 'Menu Category Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MenuCatgoryReports()));
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
            Text('Menu Reports'),
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
          MenuList.length != 0
              ? IconButton(
                  icon: Icon(Icons.print, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return MenuReportPrint(1, MenuList);
                    }));
                  },
                )
              : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Menu Category Reports',
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
              child: MenuList.length == 0
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
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
                            Container(
                              width: tabletWidth,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: DropdownSearch(
                                  isFilteredOnline: true,
                                  showClearButton: true,
                                  showSearchBox: true,
                                  items: MenuCatgoryName,
                                  label: "Menu Category",
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onChanged: (value) {
                                    String Catname = value;
                                    print(Catname);
                                    if (Catname == "All" || Catname == null) {
                                      _getMenulist();
                                    } else {
                                      _getsortMenucat(Catname);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: DataTable(columns: [
                        //     DataColumn(
                        //         label: Expanded(
                        //       child: Container(
                        //         child: Text('Sr No',
                        //             style: TextStyle(
                        //                 fontSize: 20,
                        //                 fontWeight: FontWeight.bold)),
                        //       ),
                        //     )),
                        //     DataColumn(
                        //         label: Expanded(
                        //       child: Container(
                        //         width: 150,
                        //         child: Text('Menu Name',
                        //             style: TextStyle(
                        //                 fontSize: 20,
                        //                 fontWeight: FontWeight.bold)),
                        //       ),
                        //     )),
                        //     DataColumn(
                        //         label: Expanded(
                        //       child: Container(
                        //         child: Text('Menu Category',
                        //             style: TextStyle(
                        //                 fontSize: 20,
                        //                 fontWeight: FontWeight.bold)),
                        //       ),
                        //     )),
                        //     DataColumn(
                        //         label: Expanded(
                        //       child: Container(
                        //         child: Text('Selling Price',
                        //             style: TextStyle(
                        //                 fontSize: 20,
                        //                 fontWeight: FontWeight.bold)),
                        //       ),
                        //     )),
                        //   ], rows: getDataRowList()),
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
                    )),
        ),
      ),
    );
  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobileMenuReports() {
    void handleClick(String value) {
      switch (value) {
        case 'Menu Category Reports':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MenuCatgoryReports()));
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
                        "Menu Reports",
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
              MenuList.length != 0
                  ? IconButton(
                      icon: Icon(Icons.print, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return MenuReportPrint(1, MenuList);
                        }));
                      },
                    )
                  : Text(''),
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {'Menu Category Reports'}.map((String choice) {
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
        child: ModalProgressHUD(
          inAsyncCall: _showCircle,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 40,
                  child: DropdownSearch(
                    items: MenuCatgoryName,
                    showClearButton: true,
                    showSearchBox: true,
                    label: 'Menu Category',
                    hint: "Menu Category",
                    // selectedItem: 'All',
                    searchBoxDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                      labelText: "Menu Category",
                    ),
                    onChanged: (value) {
                      String Catname = value;
                      print(Catname);
                      if (Catname == "All" || Catname == null) {
                        _getMenulist();
                      } else {
                        _getsortMenucat(Catname);
                      }
                    },
                  ),
                ),
                Divider(),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: MenuList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Menu No:- ${MenuList[index].id.toString()} ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "Rs.${MenuList[index].menuRate}",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Menu Name:",
                                            style: headHintTextStyle),
                                        Text("${MenuList[index].menuName}",
                                            style: tablecolumname),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Text("Menu Category:",
                                            style: headHintTextStyle),
                                        Text(
                                            "${MenuList[index].menucategory.toString()}",
                                            style: tablecolumname),
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
    );
  }

//---------------Mobile Mode End-------------//

  List<DataColumn> _colGen(
    MenuReportsDataNotifier _provider,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text("Sr No", style: tablecolumname),
          numeric: true,
          tooltip: "Sr No",
        ),
        DataColumn(
          label: Text('Menu Name', style: tablecolumname),
          tooltip: 'Menu Name',
        ),
        DataColumn(
          label: Text('Menu Category', style: tablecolumname),
          tooltip: 'Menu Category',
        ),
        DataColumn(
          label: Text('Selling Price', style: tablecolumname),
          tooltip: 'Selling Price',
        ),
      ];

  void _sort<T>(
    Comparable<T> Function(Menu sale) getField,
    int colIndex,
    bool asc,
    MenuReportsDataNotifier _provider,
  ) {
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(MenuList[index].id.toString())),
      DataCell(Text(MenuList[index].menuName)),
      DataCell(Text(MenuList[index].menucategory.toString())),
      DataCell(Text(MenuList[index].menuRate)),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < MenuList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

//from server fetching All Menu Data
  void _getMenulist() async {
    MenuFetchItems menufetch = new MenuFetchItems();
    var menufetchData = await menufetch.getMenuFetch("0");
    var resid = menufetchData["resid"];
    var menufetchsd = menufetchData["menu"];
    print(menufetchsd.length);
    List<Menu> tempMenuList = [];
    for (var n in menufetchsd) {
      Menu pro = Menu.withname(
          n["MenuId"],
          n["MenuName"],
          n["MenuProductId"],
          n["MenuProductName"],
          n["MenuProductQty"],
          n["Menucategory"],
          n["MenuRate"],
          n["MenuGST"],
          n["Menucategioresname"]);
      tempMenuList.add(pro);
      Provider.of<MenuReportsDataNotifier>(context, listen: false)
          .addMenuReportsData(pro);
    }
    setState(() {
      this.MenuList = tempMenuList;
      this.MenuListSearch = tempMenuList;
    });
    print("//////MenuList/////////$MenuList.length");

    //For Search
    SerachController.addListener(() {
      setState(() {
        if (MenuListSearch != null) {
          String s = SerachController.text;
          MenuList = MenuListSearch.where((element) =>
              element.id.toLowerCase().contains(s.toLowerCase()) ||
              element.menuName.toLowerCase().contains(s.toLowerCase()) ||
              element.menucategory.toLowerCase().contains(s.toLowerCase()) ||
              element.menuRate
                  .toLowerCase()
                  .contains(s.toLowerCase())).toList();
        }
      });
    });
  }

//-------------------------------------

//from server fetching All Menu Category NameData
  void _getMenuCategorylist() async {
    MenuFetchItems menucatgoryfetch = new MenuFetchItems();
    var menucatgoryfetchData = await menucatgoryfetch.getMenuFetch("1");
    var resid = menucatgoryfetchData["resid"];
    var menucatgoryfetchsd = menucatgoryfetchData["menu"];
    print(menucatgoryfetchsd.length);
    List<MenuCategory> tempMenuCatgoryList = [];
    for (var n in menucatgoryfetchsd) {
      MenuCategory pro = MenuCategory.OnlyName(n["Menucategioresname"]);
      tempMenuCatgoryList.add(pro);
    }
    setState(() {
      this.MenuCatgoryList = tempMenuCatgoryList;
    });
    List<String> tempmenucatgoryName = [];
    tempmenucatgoryName.add("All");
    for (int i = 0; i < MenuCatgoryList.length; i++) {
      tempmenucatgoryName.add(MenuCatgoryList[i].MenuCatgoryName);
    }
    setState(() {
      this.MenuCatgoryName = tempmenucatgoryName;
    });
    print("//////MenuCatgoryList/////////$MenuCatgoryName.length");
  }

//-------------------------------------

//from server fetching All Menu Category Related Data
  void _getsortMenucat(String MenuCat) async {
    MenuCatFetchItems menucatfetchitems = new MenuCatFetchItems();
    var menucatfetchitemsData =
        await menucatfetchitems.getCatMenuFetch(MenuCat);
    var resid = menucatfetchitemsData["resid"];
    var menucatfetchitemssd = menucatfetchitemsData["menu"];
    print(menucatfetchitemssd.length);
    List<Menu> tempMenuCatList = [];
    for (var n in menucatfetchitemssd) {
      Menu pro = Menu.withname(
          n["MenuId"],
          n["MenuName"],
          n["MenuProductId"],
          n["MenuProductName"],
          n["MenuProductQty"],
          n["Menucategory"],
          n["MenuRate"],
          n["MenuGST"],
          n["Menucategioresname"]);
      tempMenuCatList.add(pro);
    }
    setState(() {
      this.MenuList = tempMenuCatList;
    });
    print("//////MenuList/////////$MenuList.length");
  }
//-------------------------------------

}
