import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/Adpater/EhotelAdapter/Pos_Create_New_user_Insert.dart';
import 'package:retailerp/helpers/database_helper.dart';

class CreateUser extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
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
      content = _buildTabletCreateUser();
    }

    return content;
  }
  //-------------------------------------------
  PhramaCreateNewUserInsert user = PhramaCreateNewUserInsert();

  DatabaseHelper databaseHelper = new DatabaseHelper();
  @override
  final _UserNametext = TextEditingController();
  final _UserTypetext = TextEditingController();
  final _PassWordtext = TextEditingController();
  final _RePasswordtext = TextEditingController();
  final _UserPresonNametext = TextEditingController();
  final _UserPersonContactNumbertext = TextEditingController();

  bool _UserNamevalidate = false;
  bool _UserTypevalidate = false;
  bool _PassWordvalidate = false;
  bool _RePasswordvalidate = false;
  bool _UserPresonNamevalidate = false;
  bool _UserPersonContactNumbervalidate = false;

  String UserName;
  String UserType;
  String UserCode;
  String PassWord;
  String RePassword;
  String UserPresonName;
  String UserPersonContactNumber;

//---------------Tablet Mode Start-------------//
  Widget _buildTabletCreateUser() {
    void handleClick(String value) {
      switch (value) {
        case 'Add Sales':
          break;
        case 'Import Sales':


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
            Text('User Create'),
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
                              controller: _UserNametext,
                              obscureText: false,
                              onChanged: (value) {
                                UserName = value;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'User Name',
                                errorText: _UserNamevalidate
                                    ? 'Enter User Name'
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
                                items: ["Owner", "Manager"],
                                label: "User Type",
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (value) {
                                  UserType = value;
                                  if(UserType=="Owner")
                                    {
                                      UserCode="1";
                                    }else
                                      {
                                        UserCode="0";
                                      }

                                  print(UserType);
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
                              controller: _PassWordtext,
                              obscureText: true,
                              onChanged: (value) {
                                PassWord = value;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'PassWord',
                                errorText:
                                    _PassWordvalidate ? 'Enter Password' : null,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              controller: _RePasswordtext,
                              obscureText: true,
                              onChanged: (value) {
                                RePassword = value;

                                if(PassWord==RePassword)
                                  {
                                    PassWord=RePassword;
                                  }else {
                                  _RePasswordtext.text.isEmpty
                                      ? _RePasswordvalidate = true
                                      : _RePasswordvalidate = false;
                                    }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Re-Password',
                                errorText: _RePasswordvalidate
                                    ? 'Enter Re-Password'
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
                              controller: _UserPresonNametext,
                              obscureText: false,
                              onChanged: (value) {
                                UserPresonName = value;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Person Name',
                                errorText: _UserPresonNamevalidate
                                    ? 'Enter Person Name'
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
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
                      ],
                    ),
                    FlatButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue),
                      ),
                      textColor: Colors.white,
                      onPressed: () async {
                        print(UserName);
                        print(UserType);
                        print(PassWord);
                        print(RePassword);
                        print(UserPresonName);
                        print(UserPersonContactNumber);

                        if (UserName == null ||
                            UserType == null ||
                            PassWord == null ||
                            RePassword == null ||
                            UserPresonName == null ||
                            UserPersonContactNumber == null) {
                          print("not save in if");
                          _UserNametext.text.isEmpty
                              ? _UserNamevalidate = true
                              : _UserNamevalidate = false;
                          _UserTypetext.text.isEmpty
                              ? _UserTypevalidate = true
                              : _UserTypevalidate = false;
                          _PassWordtext.text.isEmpty
                              ? _PassWordvalidate = true
                              : _PassWordvalidate = false;
                          _RePasswordtext.text.isEmpty
                              ? _RePasswordvalidate = true
                              : _RePasswordvalidate = false;
                          _UserPresonNametext.text.isEmpty
                              ? _UserPresonNamevalidate = true
                              : _UserPresonNamevalidate = false;
                          _UserPersonContactNumbertext.text.isEmpty
                              ? _UserPersonContactNumbervalidate = true
                              : _UserPersonContactNumbervalidate = false;
                        } else {
                          print("save in else");
                          // Shop shop = new Shop.copyWith(
                          //     ShopName,
                          //     ShopMobileNumber,
                          //     ShopOwner,
                          //     ShopEmail,
                          //     ShopGST,
                          //     ShopCIN,
                          //     ShopPIN,
                          //     ShopSSIN,
                          //     ShopAddress,
                          //     _imageFilePath);
                          // var res = await databaseHelper.insertShop(shop);
                          // print(res);
                          var result = user.getPhramaCreateNewUserInsert(
                              UserName,
                              PassWord,
                              UserCode,
                              UserPresonName,
                              UserPersonContactNumber,
                              UserCode);
                          if (result == null) {
                            _showMyDialog('Filed !', Colors.red);
                          } else {
                            _showMyDialog(
                                'Data Successfully Save !', Colors.green);
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Add User",
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
                },
              ),
            ],
          ),
        );
      },
    );
  }

}
