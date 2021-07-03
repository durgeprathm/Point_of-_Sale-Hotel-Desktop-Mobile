import 'package:flutter/material.dart';
import 'package:retailerp/Adpater/fetch_empdetails.dart';
import 'package:retailerp/models/EmployeeModel.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';


class ManageEmp extends StatefulWidget {
  @override
  _ManageEmpState createState() => _ManageEmpState();
}

class _ManageEmpState extends State<ManageEmp> {
  TextEditingController searchController = TextEditingController();
  List<Emp> searchEmpList = [];
  List<Emp> empList = [];


  FetchEmpDetails fetchEmpDetails = new FetchEmpDetails();
  bool showSpinner = false;


  @override
  void initState() {
    getEmpDetails();
  }

  Future<void> getEmpDetails() async {
    setState(() {
      showSpinner = true;
    });


    var response = await fetchEmpDetails.getempdetails();
    List<Emp> tempEmp = [];
    var empsd = response["Emplist"];

    for (var n in empsd) {
      Emp pro = Emp(
          n["empid"],
          n["empname"],
          n["acctype"],
          n["date"],
          n["aadharno"],
          n["empsal"]);
      tempEmp.add(pro);
    }
    setState(() {
      empList = tempEmp;
      searchEmpList = empList;
      showSpinner = false;
    });

    setState(() {
      showSpinner = false;
    });
    searchController.addListener(() {
      setState(() {
        if (empList != null) {
          String s = searchController.text;
          searchEmpList = empList
              .where((element) =>
          element.Empid
              .toString()
              .toLowerCase()
              .contains(s.toLowerCase()) ||
              element.Empname
                  .toLowerCase()
                  .contains(s.toLowerCase()) ||
              element.acctype
                  .toLowerCase()
                  .contains(s.toLowerCase()) ||
              element.Empaddharno
                  .toString()
                  .toLowerCase()
                  .contains(s.toLowerCase()))
              .toList();
        }
      });
    });



  }



  @override
  Widget build(BuildContext context) {
    var tabletWidth = MediaQuery.of(context).size.width * 0.20;
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage EMP"),
        backgroundColor: Color(0xff01579B),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10,),
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
                        child: DataTable(
                            columns: [
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
                                      width: 200,
                                      child: Text('Employee Name',
                                          style: TextStyle(
                                              fontSize: 20, fontWeight: FontWeight.bold)),
                                    ),
                                  )),
                              DataColumn(
                                  label: Expanded(
                                    child: Container(
                                      child: Text('Type',
                                          style: TextStyle(
                                              fontSize: 20, fontWeight: FontWeight.bold)),
                                    ),
                                  )),
                              DataColumn(
                                  label: Expanded(
                                    child: Container(
                                      child: Text('Salary',
                                          style: TextStyle(
                                              fontSize: 20, fontWeight: FontWeight.bold)),
                                    ),
                                  )),
                              DataColumn(
                                  label: Expanded(
                                    child: Container(
                                      child: Text('Aadhar No',
                                          style: TextStyle(
                                              fontSize: 20, fontWeight: FontWeight.bold)),
                                    ),
                                  )),
                              // DataColumn(
                              //     label: Expanded(
                              //       child: Container(
                              //         width: 50,
                              //         child: Text('Action',
                              //             style: TextStyle(
                              //                 fontSize: 20, fontWeight: FontWeight.bold)),
                              //       ),
                              //     )),
                            ],
                            rows: getDataRowList()
                        )),
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
    for (int i = 0; i < searchEmpList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }
  DataRow getRow(int index) {
    int serNo = index+1;
    return DataRow(cells: [
      DataCell(Text(serNo.toString())),
      DataCell(Text(searchEmpList[index].Empname)),
      DataCell(Text(searchEmpList[index].acctype)),
      DataCell(Text(searchEmpList[index].Empsal)),
      DataCell(Text(searchEmpList[index].Empaddharno)),
      // DataCell(
      //   Row(
      //     children: [
      //       // IconButton(
      //       //   icon: Icon(
      //       //     Icons.preview,
      //       //   ),
      //       //   color: Colors.blue,
      //       //   onPressed: () {
      //       //     Navigator.push(
      //       //         context,
      //       //         MaterialPageRoute(
      //       //             builder: (context) =>
      //       //                 PreviewMenu(index, searchMenuList)));
      //       //   },
      //       // ),
      //       IconButton(
      //         icon: Icon(
      //           Icons.edit,
      //         ),
      //         color: Colors.green,
      //         onPressed: () {
      //
      //         },
      //
      //       ),
      //       IconButton(
      //         icon: Icon(
      //           Icons.delete,
      //         ),
      //         color: Colors.red,
      //         onPressed: () {
      //
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    ]);
  }

}
