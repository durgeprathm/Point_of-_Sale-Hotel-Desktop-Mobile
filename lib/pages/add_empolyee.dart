import 'dart:io';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/EhotelAdapter/Pos_Create_New_user_Insert.dart';
import 'package:retailerp/Adpater/EhotelAdapter/create_new_emp.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/EmployeeModel.dart';
import 'package:retailerp/utils/const.dart';


class AddEmpolyeePage extends StatefulWidget {
  @override
  _AddEmpolyeePageState createState() => _AddEmpolyeePageState();
}

class _AddEmpolyeePageState extends State<AddEmpolyeePage> {
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;
  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      // content = _buildMobileCreateUser();
    } else {
      content = _buildTabletAddEmpolyeePage();
    }

    return content;
  }
  //-------------------------------------------
  // PhramaCreateNewUserInsert user = PhramaCreateNewUserInsert();
  CreateNewEmp createNewEmp = new CreateNewEmp();

  DatabaseHelper databaseHelper = new DatabaseHelper();
  @override
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;
  final format = DateFormat("yyyy-MM-dd");
  bool autoValidate = false;
  String Deactivateat;
  bool showResetIcon = false;
  bool readOnly = false;



  final _EmpolyeeNametext = TextEditingController();
  final _EmpolyeeTypetext = TextEditingController();
  final _EmpolyeeSalarytext = TextEditingController();
  final _EmpolyeeAddharcardnotext = TextEditingController();
  final _EmpolyeeDatetext = TextEditingController();
  final _UserPersonContactNumbertext = TextEditingController();

  bool _EmpolyeeNamevalidate = false;
  bool _EmpolyeeTypevalidate = false;
  bool _EmpolyeeSalaryvalidate = false;
  bool _EmpolyeeAddharcardnovalidate = false;
  bool _EmpolyeeDatevalidate = false;
  bool _UserPersonContactNumbervalidate = false;

  String EmpolyeeName;
  String EmpolyeeType;
  String EmpolyeeDate;
  String EmpolyeeSalary;
  String EmpolyeeAddharCardNo;
  String UserPersonContactNumber;


//---------------Tablet Mode Start-------------//
  Widget _buildTabletAddEmpolyeePage() {
    void handleClick(String value) {
      switch (value) {
        case 'Add Sales':
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => AddSalesNew()));
          break;
        case 'Import Sales':
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => ImportSales()));

          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.user),
            SizedBox(
              width: 20.0,
            ),
            Text('Add Empolyee'),
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
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Add Sales',
                'Import Sales',
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Material(
              shape: Border.all(color: Colors.blueGrey, width: 5),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              controller: _EmpolyeeNametext,
                              obscureText: false,
                              onChanged: (value) {
                                EmpolyeeName = value;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Empolyee Name',
                                errorText: _EmpolyeeNamevalidate
                                    ? 'Enter Empolyee Name'
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 40,
                              //  width: tabletWidth,
                              child: DropdownSearch(
                                isFilteredOnline: true,
                                showClearButton: true,
                                showSearchBox: true,
                                items: ["Manager", "Steward","Watchmen","Captian","Other"],
                                label: "Employee Type",
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (value) {
                                  EmpolyeeType = value;
                                  print(EmpolyeeType);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              controller: _EmpolyeeAddharcardnotext,
                              obscureText: false,
                              onChanged: (value) {
                                EmpolyeeAddharCardNo = value;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Addhar Card Number',
                                errorText:
                                _EmpolyeeAddharcardnovalidate ? 'Enter Addhar Card Number' : null,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10.0),
                            child: DateTimeField(
                              controller: _EmpolyeeDatetext,
                              format: format,
                              keyboardType: TextInputType.number,
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate:
                                    currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                              },
                              autovalidate: autoValidate,
                              style: labelTextStyle,
                              validator: (date) =>
                              date == null ? 'Invalid date' : null,
                              onChanged: (date) => setState(() {
                                EmpolyeeDate = date.toString();
                              }),
                              onSaved: (date) => setState(() {
                                EmpolyeeDate = date.toString();
                                print('Selected value Date: $EmpolyeeDate');
                                savedCount++;
                              }),
                              resetIcon:
                              showResetIcon ? Icon(Icons.delete) : null,
                              readOnly: readOnly,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Empolyee Joining Date',
                                errorText: _EmpolyeeDatevalidate
                                    ? 'Enter Empolyee Joining Date'
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              controller: _EmpolyeeSalarytext,
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              onChanged: (value) {
                                EmpolyeeSalary = value;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Empolyee Salary',
                                errorText: _EmpolyeeSalaryvalidate
                                    ? 'Enter Empolyee Salary'
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Visibility(
                            visible: false,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: _UserPersonContactNumbertext,
                                obscureText: false,

                                onChanged: (value) {
                                  UserPersonContactNumber = value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Person Contact Number',
                                  errorText: _UserPersonContactNumbervalidate
                                      ? 'Enter Person Contact Number'
                                      : null,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    FlatButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue),
                      ),
                      textColor: Colors.white,
                      onPressed: () async {

                        print(EmpolyeeName);
                        print(EmpolyeeType);
                        print(EmpolyeeDate);
                        print(EmpolyeeSalary);
                        print(EmpolyeeAddharCardNo);
                        print(UserPersonContactNumber);

                        if(EmpolyeeName == null || EmpolyeeType == null){
                          _EmpolyeeNametext.text.isEmpty
                              ? _EmpolyeeNamevalidate = true
                              : _EmpolyeeNamevalidate = false;
                          _EmpolyeeTypetext.text.isEmpty
                              ? _EmpolyeeTypevalidate = true
                              : _EmpolyeeTypevalidate = false;
                        }

                        if(EmpolyeeAddharCardNo == null){
                          setState(() {
                            EmpolyeeAddharCardNo = "";
                          });
                        }
                        if(EmpolyeeDate == null){
                          setState(() {
                            EmpolyeeDate = "";
                          });

                        }

                        if(EmpolyeeSalary == null){
                          setState(() {
                            EmpolyeeSalary = "";
                          });
                        }

                        // setState(() {
                        //   AppDatabase().insertNewEmp(Employee(
                        //     Empid : 0,
                        //     Empname: EmpolyeeName,
                        //     Emptype: EmpolyeeType,
                        //     Empaddhar: EmpolyeeAddharCardNo,
                        //     Empsalary: EmpolyeeSalary,
                        //     Empjdate: EmpolyeeDate,
                        //   ));
                        // });

                        var response = await createNewEmp.insertnewemp(EmpolyeeName, EmpolyeeType, EmpolyeeAddharCardNo, EmpolyeeSalary, EmpolyeeDate);
                        var resid = response["resid"];
                        print(resid);
                        if(resid == 200){
                          _showMyDialog("Employee Added",Colors.blue);
                        }else{
                          _showMyDialog("Error",Colors.red);
                        }

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Add Empolyee",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

//---------------Tablet Mode End-------------//

  Future<void> _showMyDialog(String msg, Color col) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
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
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

}
