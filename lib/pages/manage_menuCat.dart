import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/Adpater/EhotelAdapter/delete_menuCat.dart';
import 'package:retailerp/Adpater/EhotelAdapter/updated_menucatgeoryUpdate.dart';
import 'package:retailerp/Adpater/fetch_menuCategoryPoonam.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';

class ManageMenuCat extends StatefulWidget {
  @override
  _ManageMenuCatState createState() => _ManageMenuCatState();
}

class _ManageMenuCatState extends State<ManageMenuCat> {
  POSMenuCatList posmenucatlistadp = new POSMenuCatList();
  List<MenuCatgeoryDetails> menuCatSearchList = [];
  List<MenuCatgeoryDetails> menuCatList = [];

  TextEditingController searchController = TextEditingController();
  TextEditingController menucatNameController  = TextEditingController();
  bool _showCircle = false;
  String updatedNameCat;

  @override
  void initState() {
    _getMenuCat();
  }

  @override
  Widget build(BuildContext context) {
    var tabletWidth = MediaQuery.of(context).size.width * 0.20;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.shoppingBag),
            SizedBox(
              width: 20.0,
            ),
            Text('Manage Menu Category'),
          ],
        ),
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _showCircle,
          child: Column(
            children: [
              SizedBox(
                height: 10,
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
                    SizedBox(
                      width: 10,
                    ),
                    // Container(
                    //   height: 40,
                    //   width: tabletWidth,
                    //   child: DateTimeField(
                    //     controller: _fromDatetext,
                    //     format: dateFormat,
                    //     keyboardType: TextInputType.number,
                    //     onShowPicker: (context, currentValue) {
                    //       return showDatePicker(
                    //           context: context,
                    //           firstDate: DateTime(1900),
                    //           initialDate: currentValue ?? DateTime.now(),
                    //           lastDate: DateTime(2100));
                    //     },
                    //     autovalidate: autoValidate,
                    //     validator: (date) =>
                    //         date == null ? 'Invalid date' : null,
                    //     onChanged: (date) => setState(() {
                    //       fromValue = date;
                    //       print('Selected Date: ${date}');
                    //     }),
                    //     onSaved: (date) => setState(() {
                    //       fromValue = date;
                    //       print('Selected value Date: $fromValue');
                    //       savedCount++;
                    //     }),
                    //     resetIcon: showResetIcon ? Icon(Icons.delete) : null,
                    //     readOnly: readOnly,
                    //     decoration: InputDecoration(
                    //       border: OutlineInputBorder(),
                    //       labelText: 'From Date',
                    //       errorText:
                    //           _fromDatevalidate ? 'Enter From Date' : null,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    // Container(
                    //   height: 40,
                    //   width: tabletWidth,
                    //   child: DateTimeField(
                    //     controller: _toDatetext,
                    //     format: dateFormat,
                    //     keyboardType: TextInputType.number,
                    //     onShowPicker: (context, currentValue) {
                    //       return showDatePicker(
                    //           context: context,
                    //           firstDate: DateTime(1900),
                    //           initialDate: currentValue ?? DateTime.now(),
                    //           lastDate: DateTime(2100));
                    //     },
                    //     autovalidate: autoValidate,
                    //     validator: (date) =>
                    //         date == null ? 'Invalid date' : null,
                    //     onChanged: (date) => setState(() {
                    //       toValue = date;
                    //       print('Selected Date: ${toValue}');
                    //     }),
                    //     onSaved: (date) => setState(() {
                    //       toValue = date;
                    //       print('Selected value Date: $_toDatetext');
                    //       savedCount++;
                    //     }),
                    //     resetIcon: showResetIcon ? Icon(Icons.delete) : null,
                    //     readOnly: readOnly,
                    //     decoration: InputDecoration(
                    //       border: OutlineInputBorder(),
                    //       labelText: 'To Date',
                    //       errorText: _toDatevalidate ? 'Enter Menu Date' : null,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Center(
                        child: DataTable(columns: [
                      DataColumn(
                          label: Expanded(
                        child: Container(
                          child: Text('Sr No',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Container(
                          child: Text('ID',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Container(
                          width: 200,
                          child: Text('Menu Name',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      )),
                      DataColumn(
                          label: Expanded(
                        child: Container(
                          width: 50,
                          child: Text('Action',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      )),
                    ], rows: getDataRowList())),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DataRow> getDataRowList() {
    List<DataRow> myTempDataRow = List();
    for (int i = 0; i < menuCatSearchList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

  DataRow getRow(int index) {
    int serNo = index + 1;
    return DataRow(cells: [
      DataCell(Text(serNo.toString())),
      DataCell(Text(menuCatSearchList[index].MenuCatId)),
      DataCell(Text(menuCatSearchList[index].MenuCatName)),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
              ),
              color: Colors.green,
              onPressed: () {
                _showMyDialogEdit(menuCatSearchList[index].MenuCatId,
                    menuCatSearchList[index].MenuCatName);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
              ),
              color: Colors.red,
              onPressed: () {
                _showMyDialog(menuCatSearchList[index]._MenuCatId);
              },
            ),
          ],
        ),
      ),
    ]);
  }

  Future<void> _showMyDialogEdit(String id, String MenuCatName) async {
    setState(() {
      menucatNameController.text = MenuCatName;
    });
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              "Edit",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                    controller:menucatNameController,
                    onChanged: (value) {
                      updatedNameCat = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Menu Category Name',
                      // errorText: _SproSubTotalvalidate ? 'Enter Product Subtotal' : null,
                    ),
                  ),

                ],
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
                child: Text('Update'),
                onPressed: () async {
                  UpdateMenuCategoryName updateName = new UpdateMenuCategoryName();
                  var result = await updateName.updateCategoryName(id.toString(),updatedNameCat.toString());
                  var resId  = result["resid"];
                  if(resId == 200){

                  }
                  print("///delete id///$id");
                  Navigator.of(context).pop();
                  _getMenuCat();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showMyDialog(String id) async {
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
                  DeleteMenuCat purchasedelete = new DeleteMenuCat();
                  var result =
                      await purchasedelete.getDeleteMenuCat(id.toString());
                  print("///delete id///$id");
                  Navigator.of(context).pop();
                  _getMenuCat();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getMenuCat() async {
    setState(() {
      _showCircle = true;
    });

    var menucat = await posmenucatlistadp.getPosMenuList();
    int resid = menucat["resid"];

    if (resid == 200) {
      int rowcount = menucat["rowcount"];
      if (rowcount > 0) {
        var menucatsd = await menucat["menucatgo"];
        List<MenuCatgeoryDetails> menuscat = [];
        var tempcat = MenuCatgeoryDetails("0", "All");
        menuscat.add(tempcat);
        if (menucatsd != null) {
          for (var n in menucatsd) {
            MenuCatgeoryDetails menucat =
                MenuCatgeoryDetails(n["MenuCatId"], n["MenuCatName"]);
            menuscat.add(menucat);
          }
        }
        setState(() {
          menuCatList = menuscat;
          menuCatSearchList = menuscat;
          _showCircle = false;
        });
        searchController.addListener(() {
          setState(() {
            if (menuCatList != null) {
              String s = searchController.text;
              menuCatSearchList = menuCatList
                  .where((element) =>
                      element._MenuCatId.toString()
                          .toLowerCase()
                          .contains(s.toLowerCase()) ||
                      element._MenuCatName.toLowerCase()
                          .contains(s.toLowerCase()))
                  .toList();
            }
          });
        });
      } else {
        setState(() {
          _showCircle = false;
        });
      }
    } else {
      setState(() {
        _showCircle = false;
      });
    }
  }
}

class MenuCatgeoryDetails {
  String _MenuCatId;
  String _MenuCatName;

  String get MenuCatId => _MenuCatId;

  set MenuCatId(String value) {
    _MenuCatId = value;
  }

  String get MenuCatName => _MenuCatName;

  set MenuCatName(String value) {
    _MenuCatName = value;
  }

  MenuCatgeoryDetails(this._MenuCatId, this._MenuCatName);

  factory MenuCatgeoryDetails.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return MenuCatgeoryDetails((json['MenuCatId']), json['MenuCatName']);
  }

  static List<MenuCatgeoryDetails> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => MenuCatgeoryDetails.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this._MenuCatId} ${this._MenuCatName}';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(MenuCatgeoryDetails model) {
    return this?._MenuCatId == model?._MenuCatId;
  }

  @override
  String toString() => _MenuCatName;
}
