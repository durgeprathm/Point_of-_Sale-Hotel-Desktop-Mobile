import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/models/Purchase.dart';
import 'package:retailerp/models/menu.dart';
import 'package:retailerp/utils/const.dart';

class PreviewMenu extends StatefulWidget {
  PreviewMenu(this.indexFetch, this.menuListFetch);

  @override
  final int indexFetch;
  List<Menu> menuListFetch = new List();

  _PreviewMenuState createState() => _PreviewMenuState();
}

class _PreviewMenuState extends State<PreviewMenu> {
  @override
  String PreviewBillNo;
  String menuName;
  String PreviewDate;
  String PreviewProductName;
  String PreviewProductRate;
  String PreviewProductQty;
  String PreviewProductSubTotal;

  String PreviewCategory;

  String PreviewSubTotal;
  String PreviewDiscount;
  String PreviewGST;
  String PreviewMiscellaneons;
  String PreviewTotalAmount;
  String PreviewNarration;
  var tempProductSubTotal,
      tempProductName,
      tempProductRate,
      tempProductGst,
      tempProductQTY;

  @override
  void initState() {
    print('Menu PreviewGST :${widget.menuListFetch[widget.indexFetch].menuGst}');
    PreviewBillNo = widget.menuListFetch[widget.indexFetch].id;
    menuName = widget.menuListFetch[widget.indexFetch].menuName;
    // PreviewProductName =
    //     widget.menuListFetch[widget.indexFetch].menuProductName;
    // PreviewProductQty = widget.menuListFetch[widget.indexFetch].menuProductQty;
    PreviewGST = widget.menuListFetch[widget.indexFetch].menuGst.toString();
    PreviewTotalAmount =
        widget.menuListFetch[widget.indexFetch].menuRate.toString();
    PreviewCategory =
        widget.menuListFetch[widget.indexFetch].menucategory.toString();

    // tempProductName = PreviewProductName.split("#");
    // tempProductQTY = PreviewProductQty.split("#");

  }

  //-------------------------------------------
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobilePreviewMenu();
    } else {
      content = _buildTabletPreviewMenu();
    }

    return content;
  }

//-------------------------------------------
//---------------Tablet Mode Start-------------//
  Widget _buildTabletPreviewMenu() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.moneyBillAlt),
            SizedBox(
              width: 20.0,
            ),
            Text('Invoice No:-  $PreviewBillNo'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            shape: Border.all(color: PrimaryColor, width: 2),
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        //color: Colors.lightBlueAccent,
                        child: Column(
                          children: [
                            Text(
                              "$menuName",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        //color: Colors.lightBlueAccent,
                        child: Column(
                          children: [
                            Text(
                              "$PreviewDate",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                // Divider(
                //   color: PrimaryColor,
                //   thickness: 2,
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: DataTable(
                //     columns: [
                //       DataColumn(
                //           label: Expanded(
                //         child: Container(
                //           // width: 200,
                //           child: Text('Product Name',
                //               style: TextStyle(
                //                   fontSize: 20, fontWeight: FontWeight.bold)),
                //         ),
                //       )),
                //       DataColumn(
                //           label: Expanded(
                //         child: Container(
                //           child: Text('Product Rate',
                //               style: TextStyle(
                //                   fontSize: 20, fontWeight: FontWeight.bold)),
                //         ),
                //       )),
                //       DataColumn(
                //           label: Expanded(
                //         child: Container(
                //           child: Text('Gst',
                //               style: TextStyle(
                //                   fontSize: 20, fontWeight: FontWeight.bold)),
                //         ),
                //       )),
                //       DataColumn(
                //           label: Expanded(
                //         child: Container(
                //           child: Text('Product Quntity',
                //               style: TextStyle(
                //                   fontSize: 20, fontWeight: FontWeight.bold)),
                //         ),
                //       )),
                //       DataColumn(
                //         label: Expanded(
                //           child: Container(
                //             child: Text('Product SubTotal',
                //                 style: TextStyle(
                //                     fontSize: 20, fontWeight: FontWeight.bold)),
                //           ),
                //         ),
                //       ),
                //     ],
                //     rows: getDataRowList(),
                //   ),
                // ),
                Divider(
                  color: PrimaryColor,
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "SubTotal:- $PreviewSubTotal",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 570.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Discount:- $PreviewDiscount",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(
                      //     "GST Amount:- $PreviewGST",
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.normal,
                      //       fontSize: 20.0,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: 450.0,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Miscellaneons Amount:- $PreviewMiscellaneons",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Total Amount:- $PreviewTotalAmount",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Narration:- $PreviewNarration",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//---------------Tablet Mode End-------------//
//---------------Mobile Mode Start-------------//
  Widget _buildMobilePreviewMenu() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Preview Menu"),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName(Navigator.defaultRouteName));
                },
              ),
            ],
          ),
          // PopupMenuButton<String>(
          //   onSelected: handleClick,
          //   itemBuilder: (BuildContext context) {
          //     return {
          //       'Add Menu',
          //       'Import Menu',
          //       'Add Supplier',
          //       'Manage Suppliers',
          //     }.map((String choice) {
          //       return PopupMenuItem<String>(
          //         value: choice,
          //         child: Text(choice),
          //       );
          //     }).toList();
          //   },
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Material(
          shape: Border.all(color: PrimaryColor, width: 2),
          child: Column(
            children: [
              Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      //color: Colors.lightBlueAccent,
                      child: Column(
                        children: [
                          Text(
                            "$menuName",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    //color: Colors.lightBlueAccent,
                    child: Column(
                      children: [
                        Text(
                          "$PreviewCategory",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              // Divider(
              //   color: PrimaryColor,
              //   thickness: 2,
              // ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
              //   child: DataTable(
              //     columnSpacing: 25,
              //     columns: [
              //       DataColumn(
              //           label: Expanded(
              //         child: Container(
              //           child: Text('Name',
              //               style: TextStyle(
              //                   fontSize: 15, fontWeight: FontWeight.bold)),
              //         ),
              //       )),
              //       DataColumn(
              //           label: Expanded(
              //         child: Container(
              //           child: Text('Quntity',
              //               style: TextStyle(
              //                   fontSize: 15, fontWeight: FontWeight.bold)),
              //         ),
              //       )),
              //     ],
              //     rows: getDataRowList(),
              //   ),
              // ),
              Divider(
                color: PrimaryColor,
                thickness: 2,
              ),
              Text(
                "Gst:- $PreviewGST",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
              Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Total Amount:- $PreviewTotalAmount",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

//---------------Mobile Mode End-------------//

  // DataRow getRow(int index) {
  //   return DataRow(cells: [
  //     DataCell(Text(tempProductName[index].toString())),
  //     DataCell(Text(tempProductQTY[index])),
  //   ]);
  // }

  // List<DataRow> getDataRowList() {
  //   List<DataRow> myTempDataRow = List();
  //
  //   for (int i = 0; i < tempProductName.length; i++) {
  //     myTempDataRow.add(getRow(i));
  //   }
  //   return myTempDataRow;
  // }
}
