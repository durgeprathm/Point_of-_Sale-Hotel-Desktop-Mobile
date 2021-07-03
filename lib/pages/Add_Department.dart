import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/Adpater/pos_department_insert.dart';
import 'package:retailerp/Const/constcolor.dart';


import 'Manage_Sales.dart';
import 'dashboard.dart';

class AddDepartment extends StatefulWidget {
  @override
  _AddDepartmentState createState() => _AddDepartmentState();
}

class _AddDepartmentState extends State<AddDepartment> {
  static const int kTabletBreakpoint = 552;
  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileAddDepartment();
    } else {
      content = _buildTabletAddDepartment();
    }

    return content;
  }

  @override
   DepartmentInsert departmentinsert =new DepartmentInsert();
  @override
  String DepartmentName;
  String DepartmentNarration;

  bool _DepartmentNamevalidate = false;
  TextEditingController _DepartmentNametext = TextEditingController();

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletAddDepartment() {
    void handleClick(String value) {
      switch (value) {
        case 'Manage Department':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ManageSales()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.home),
            SizedBox(
              width: 20.0,
            ),
            Text('Add Department'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return RetailerHomePage();
              }));
            },
          ),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Manage Department',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Material(
                shape: Border.all(color: Colors.blueGrey, width: 5),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: _DepartmentNametext,
                                obscureText: false,
                                onChanged: (value) {
                                  DepartmentName = value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Department Name',
                                  errorText: _DepartmentNamevalidate
                                      ? 'Enter Department Name'
                                      : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0),
                              child: TextField(
                                obscureText: false,
                                maxLines: 3,
                                onChanged: (value) {
                                  DepartmentNarration = value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Narration',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Material(
                          child: FlatButton(
                            color: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black12),
                            ),
                            textColor: Colors.white,
                            onPressed: () {
                              print("buton pressed");
                              // Respond to button press
                              setState(() {
                                if (DepartmentName == null) {
                                  _DepartmentNametext.text.isEmpty
                                      ? _DepartmentNamevalidate = true
                                      : _DepartmentNamevalidate = false;
                                } else {
                                  print("in if");
                                  print(DepartmentName);
                                  print(DepartmentNarration);
                                  var result= departmentinsert.getDepartmentInsert(
                                       DepartmentName,
                                       DepartmentNarration
                                   );
                                  if (result == null) {
                                    _showMyDialog('Filed !', Colors.red);
                                  } else {
                                    _showMyDialog(
                                        'Data Successfully Save !', Colors.green);
                                  }
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                "Save",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //--------Tablet Mode End-------------//

  //---------Mobile View-------------------//
  Widget _buildMobileAddDepartment() {
    void handleClick(String value) {
      switch (value) {
        case 'Manage Department':
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ManageSales()));
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.home),
            SizedBox(
              width: 20.0,
            ),
            Text('Add Department'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return RetailerHomePage();
              }));
            },
          ),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Manage Department',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical:120.0,horizontal: 8.0 ),
          child: Material(
            shape: Border.all(color: Colors.blueGrey, width: 5),
            child: Column(children: [
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  controller: _DepartmentNametext,
                  obscureText: false,
                  onChanged: (value) {
                    DepartmentName = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Department Name',
                    errorText: _DepartmentNamevalidate
                        ? 'Enter Department Name'
                        : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  obscureText: false,
                  maxLines: 3,
                  onChanged: (value) {
                    DepartmentNarration = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Narration',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Material(
                  color: PRODUCTRATEBG,
                  borderRadius: BorderRadius.circular(10.0),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        if (DepartmentName == null) {
                          _DepartmentNametext.text.isEmpty
                              ? _DepartmentNamevalidate = true
                              : _DepartmentNamevalidate = false;
                        } else {
                          print(DepartmentName);
                          print(DepartmentNarration);
                          var result=departmentinsert.getDepartmentInsert(
                              DepartmentName,
                              DepartmentNarration
                          );
                          if (result == null) {
                            _showMyDialog('Filed !', Colors.red);
                          } else {
                            _showMyDialog(
                                'Data Successfully Save !', Colors.green);
                          }
                        }
                      });
                    },
                    minWidth: 100.0,
                    height: 35.0,
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

//---------Mobile View End-------------------//
//--------insert popup Start-------------------------------
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
                },
              ),
            ],
          ),
        );
      },
    );
  }
  //---------------------------------------

}
