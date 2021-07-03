import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/Adpater/fetch_dashboard_Summary.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/utils/const.dart';


class OverallSummaryDashBoard extends StatefulWidget {
  @override
  _OverallSummaryDashBoardState createState() => _OverallSummaryDashBoardState();
}

class _OverallSummaryDashBoardState extends State<OverallSummaryDashBoard> {

  List<String> sampleList = ["Product 1","Product 2","Product 3","Product 4"];
  FetchDashboardSummary fetchDashboardSummary = new FetchDashboardSummary();
  String actualsale,actualqty,actualcount;
  String consale,conqty,concount;
  bool checkdataflag = false;

  _getDashboardSummaryReport() async {
    setState(() {
      checkdataflag = false;
    });

    var response = await fetchDashboardSummary.getdashboardSummary();
    var resid = response["resid"];

    setState(() {
      actualsale = response["actualtotalsale"].toString();
      actualqty = response["actualsaleqty"].toString();
      actualcount = response["actualsalecount"].toString();
      consale = response["conactualtotalsale"].toString();
      conqty = response["conactualsaleqty"].toString();
      concount = response["conactualsalecount"].toString();
    });

    setState(() {
      checkdataflag = true;
    });

  }


  @override
  void initState() {
    super.initState();
    _getDashboardSummaryReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Sales Dashboard"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: Column(
                children: [
                  SizedBox(height: 10.0),
                  Center(
                    child: Image(
                      image: AssetImage("Images/aruntelgirni.jpg"),
                      width: 150,
                    ),
                  ),
                  checkdataflag ? Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Text("Actual Sale",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),),
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color: primary,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Material(
                                        elevation: 2,
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text("Oil Sold In Ruppes",style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,

                                                    fontSize: 18
                                                ),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: FaIcon(
                                                  FontAwesomeIcons.rupeeSign,
                                                  color: Colors.amber,
                                                  size: 35,
                                                )
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text("$Rupees ${actualsale.toString()}",style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 22
                                                ),),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Material(
                                        elevation: 2,
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text("Oil Sold In Liters",style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 18
                                                ),),
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.oilCan,
                                                    color: Colors.blue,
                                                    size: 35,
                                                  )
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text("${actualqty.toString()} Lit",style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 22
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Material(
                                        elevation: 2,
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text("Oil Sold In Units",style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 18
                                                ),),
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.wineBottle,
                                                    color: Colors.redAccent,
                                                    size: 35,
                                                  )
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text("${actualcount.toString()} Units",style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 22
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Text("Stocks",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),),
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color: primary,
                                ),
                                Container(
                                  child: DropdownSearch<String>(
                                    items: sampleList,
                                    showClearButton: true,
                                    showSearchBox: true,
                                    label: 'Select Product',
                                    hint: "Select a Product Category",
                                    autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                    onChanged: (String data) {
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Material(
                                        elevation: 2,
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.cubes,
                                                    color: Colors.amber,
                                                    size: 45,
                                                  )
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(1.0),
                                                    child: Text("Sold",style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontStyle: FontStyle.italic,
                                                        fontSize: 18
                                                    ),),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(1.0),
                                                    child: Text("${2.toString()} Lit",style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.blueGrey,
                                                        fontSize: 22
                                                    )),
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Material(
                                        elevation: 2,
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.cubes,
                                                    color: Colors.blue,
                                                    size: 45,
                                                  )
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(1.0),
                                                    child: Text("InStock",style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontStyle: FontStyle.italic,
                                                        fontSize: 18
                                                    ),),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(1.0),
                                                    child: Text("${2.toString()} Lit",style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.blueGrey,
                                                        fontSize: 22
                                                    )),
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Material(
                                        elevation: 2,
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.layerGroup,
                                                    color: Colors.redAccent,
                                                    size: 45,
                                                  )
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(1.0),
                                                    child: Text("Opening Stock",style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontStyle: FontStyle.italic,
                                                        fontSize: 18
                                                    ),),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(1.0),
                                                    child: Text("${2.toString()} Lit",style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.blueGrey,
                                                        fontSize: 22
                                                    )),
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 45,
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Text("Conversion Sale",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),),
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color: primary,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Material(
                                        elevation: 2,
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text("Oil Converted In",style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,

                                                    fontSize: 18
                                                ),),
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.rupeeSign,
                                                    color: Colors.amber,
                                                    size: 35,
                                                  )
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text("$Rupees ${consale.toString()}",style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 22
                                                ),),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Material(
                                        elevation: 2,
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text("Oil Converted In",style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 18
                                                ),),
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.oilCan,
                                                    color: Colors.blue,
                                                    size: 35,
                                                  )
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text("${conqty.toString()} Lit",style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 22
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Material(
                                        elevation: 2,
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text("Oil Converted In",style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 18
                                                ),),
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.wineBottle,
                                                    color: Colors.redAccent,
                                                    size: 35,
                                                  )
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text("${concount.toString()} Units",style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 22
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Text("Stocks",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),),
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color: primary,
                                ),
                                Container(
                                  child: DropdownSearch<String>(
                                    showClearButton: true,
                                    items: sampleList,
                                    showSearchBox: true,
                                    label: 'Select Product',
                                    hint: "Select a Product",
                                    autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                    onChanged: (String data) {
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Material(
                                        elevation: 2,
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.cubes,
                                                    color: Colors.amber,
                                                    size: 45,
                                                  )
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(1.0),
                                                    child: Text("Sold",style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontStyle: FontStyle.italic,
                                                        fontSize: 18
                                                    ),),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(1.0),
                                                    child: Text("${2.toString()} Lit",style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.blueGrey,
                                                        fontSize: 22
                                                    )),
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Material(
                                        elevation: 2,
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.cubes,
                                                    color: Colors.blue,
                                                    size: 45,
                                                  )
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(1.0),
                                                    child: Text("InStock",style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontStyle: FontStyle.italic,
                                                        fontSize: 18
                                                    ),),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(1.0),
                                                    child: Text("${2.toString()} Lit",style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.blueGrey,
                                                        fontSize: 22
                                                    )),
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Material(
                                        elevation: 2,
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.layerGroup,
                                                    color: Colors.redAccent,
                                                    size: 45,
                                                  )
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(1.0),
                                                    child: Text("Opening Stock",style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontStyle: FontStyle.italic,
                                                        fontSize: 18
                                                    ),),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(1.0),
                                                    child: Text("${2.toString()} Lit",style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.blueGrey,
                                                        fontSize: 22
                                                    )),
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ) : Center(child: Container(child: CircularProgressIndicator())),
                ],
              ),
          ),
        ),
      ),
    );
  }
}
