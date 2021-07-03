import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/pos_menucategory_fetch.dart';
import 'package:retailerp/models/Menu_Category.dart';
import 'package:retailerp/utils/const.dart';

import 'Add_Sales.dart';
import 'menu_Category_report_print.dart';

class MenuCatgoryReports extends StatefulWidget {
  @override
  _MenuCatgoryReportsState createState() => _MenuCatgoryReportsState();
}

class _MenuCatgoryReportsState extends State<MenuCatgoryReports> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileMenuCatgoryReports();
    } else {
      content = _buildTabletMenuCatgoryReports();
    }

    return content;
  }




  bool _showCircle = false;
  Widget appBarTitle = Text("Menu Category Reports");
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
  List<MenuCategory> MenuCatgoryList = new List();
  List<MenuCategory> MenuCatgoryListSearch = new List();
  TextEditingController SerachController = new TextEditingController();
  int count;

  @override
  void initState() {
    _getMenuCategoryFetchItems();
  }

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletMenuCatgoryReports() {
    var tabletWidth = MediaQuery.of(context).size.width * 0.30;
    void handleClick(String value) {
      switch (value) {
        case 'Menu Reports':
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
            Text('Menu Category Reports'),
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
          MenuCatgoryList.length != 0
              ? IconButton(
            icon: Icon(Icons.print, color: Colors.white),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) {
                return MenuCatgeoryReportPrint(1, MenuCatgoryList);
              }));
            },
          )
              : Text(''),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Menu Reports',
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
              child: MenuCatgoryList.length == 0
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
                                child: Text('Menu Category Name',
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
  Widget _buildMobileMenuCatgoryReports() {
    void handleClick(String value) {
      switch (value) {
        case 'Menu Reports':
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
              MenuCatgoryList.length != 0
                  ? IconButton(
                icon: Icon(Icons.print, color: Colors.white),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) {
                    return MenuCatgeoryReportPrint(1, MenuCatgoryList);
                  }));
                },
              )
                  : Text(''),
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {'Menu Category Reports'}
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
            child:MenuCatgoryList.length == 0
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
                          child: Text('Menu Category Name',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                      )),
                ], rows: getDataRowList()),
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
      DataCell(Text(MenuCatgoryList[index].MenuCatgoryId.toString())),
      DataCell(Text(MenuCatgoryList[index].MenuCatgoryName)),
    ]);
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();

    for (int i = 0; i < MenuCatgoryList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

//from server fetching All Menu Data
  void _getMenuCategoryFetchItems() async {
    MenuCategoryFetchItems menucategoryfetchitems =
        new MenuCategoryFetchItems();
    var menucategoryfetchitemsData =
        await menucategoryfetchitems.getMenuCategoryFetch("0");
    var resid = menucategoryfetchitemsData["resid"];
    var menucategoryfetchitemssd = menucategoryfetchitemsData["menucategiores"];
    //print(menucategoryfetchitemssd.length);
    List<MenuCategory> tempMenuCategoryList = [];
    for (var n in menucategoryfetchitemssd) {
      MenuCategory pro =
          MenuCategory(n["MenucategioresId"], n["Menucategioresname"]);
      tempMenuCategoryList.add(pro);
    }
    setState(() {
      this.MenuCatgoryList = tempMenuCategoryList;
      this.MenuCatgoryListSearch = tempMenuCategoryList;
    });
    print("//////MenuCatgoryList/////////$MenuCatgoryList.length");




//For Search
    SerachController.addListener(() {
      setState(() {
      if(MenuCatgoryListSearch != null){
      String s = SerachController.text;
      MenuCatgoryList = MenuCatgoryListSearch.where((element) => element.MenuCatgoryName.toLowerCase().contains(s.toLowerCase()) || element.MenuCatgoryId.toLowerCase().contains(s.toLowerCase())).toList();
      }
      });
    });
  }
//-------------------------------------

//from server fetching All Menu Category Related Data

}
