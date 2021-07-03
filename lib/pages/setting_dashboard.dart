import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/pages/AddShop_Details.dart';
import 'package:retailerp/pages/Create_User.dart';
import 'package:retailerp/pages/Forget_Password.dart';



class SettingDashboard extends StatefulWidget {
  @override
  _SettingDashboardState createState() => _SettingDashboardState();
}

class _SettingDashboardState extends State<SettingDashboard> {
  @override
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;
  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery
        .of(context)
        .size
        .shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileSettingDashboard();
    } else {
      content = _buildTabletSettingDashboard();
    }

    return content;
  }
  //-------------------------------------------
//---------------Tablet Mode Start-------------//
  Widget _buildTabletSettingDashboard() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:Row(
          children: [
            FaIcon(FontAwesomeIcons.cog),
            SizedBox(
              width: 10.0,
            ),
            Text('Settings'),
          ],
        ),
        // backgroundColor:APPBARRBG,

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child:GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return ShopDetails();
                          }));
                        },
                        child: Material(
                          color: EMPBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child:Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FaIcon(FontAwesomeIcons.desktop,
                                  color:Colors.white,
                                  size: 50.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Shop Details',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          elevation: 10.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    Expanded(
                      child:GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return CreateUser();
                          }));
                        },
                        child: Material(
                          color:PRODUCTRATEBG ,
                          borderRadius: BorderRadius.circular(10.0),
                          child:Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FaIcon(FontAwesomeIcons.users,
                                  color:Colors.white,
                                  size: 50.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('Create Users',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),),
                              )
                            ],
                          ),
                          elevation: 10.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    Expanded(
                      child:Material(
                        color:PURCHASEBG,
                        borderRadius: BorderRadius.circular(10.0),
                        child:Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FaIcon(FontAwesomeIcons.user,
                                color:Colors.white,
                                size: 50.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('Profile',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),),
                            )
                          ],
                        ),
                        elevation: 10.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child:GestureDetector(
                        // onTap: () {
                        //   Navigator.of(context)
                        //       .push(MaterialPageRoute(builder: (_) {
                        //     return ForgetPassword();
                        //   }));
                        // },
                        child: Visibility(
                          visible: false,
                          child: Material(
                            color: SALESBG,
                            borderRadius: BorderRadius.circular(10.0),
                            child:Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: FaIcon(FontAwesomeIcons.key,
                                    color:Colors.white,
                                    size: 50.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Forget Password',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            elevation: 10.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    Expanded(
                      child:GestureDetector(
                        // onTap: () {
                        //   Navigator.of(context)
                        //       .push(MaterialPageRoute(builder: (_) {
                        //     return LangChange();
                        //   }));
                        // },
                        child: Visibility(
                          visible: false,
                          child: Material(
                            color:REPROTGENBG ,
                            borderRadius: BorderRadius.circular(10.0),
                            child:Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: FaIcon(FontAwesomeIcons.print,
                                    color:Colors.white,
                                    size: 50.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('Language',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                )
                              ],
                            ),
                            elevation: 10.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    Expanded(
                      child:Visibility(
                        visible: false,
                        child: Material(
                          color:SETTINGSBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child:Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FaIcon(FontAwesomeIcons.user,
                                  color:Colors.white,
                                  size: 50.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('Profile',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),),
                              )
                            ],
                          ),
                          elevation: 10.0,
                        ),
                      ),
                    ),
                  ],
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
  Widget _buildMobileSettingDashboard() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.cog),
            SizedBox(
              width: 10.0,
            ),
            Text('Settings'),
          ],
        ),
// backgroundColor:APPBARRBG,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return ShopDetails();
                          }));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: EMPBG,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(FontAwesomeIcons.desktop,
                                    size: 35.0, color: Colors.white),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Shop Details',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          elevation: 10.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return CreateUser();
                          }));
                        },
                        child: Material(
                          color:PRODUCTRATEBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.users,
                                  color: Colors.white,
                                  size: 35.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Create Users',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          elevation: 10.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Material(
                        color:PURCHASEBG,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: FaIcon(
                                FontAwesomeIcons.user,
                                color: Colors.white,
                                size: 35.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Profile',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        elevation: 10.0,
                      ),
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return ForgetPassword();
                          }));
                        },
                        child: Material(
                          color: SALESBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.key,
                                  color: Colors.white,
                                  size: 35.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Forget Password',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          elevation: 10.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
//                          Navigator.of(context)
//                              .push(MaterialPageRoute(builder: (_) {
//                            return ProductMenuList();
//                          }));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color:REPROTGENBG,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.print,
                                  size: 35.0,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Language',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          elevation: 10.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
//                          Navigator.of(context)
//                              .push(MaterialPageRoute(builder: (_) {
//                            return ProductRateMenuList();
//                          }));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color:SETTINGSBG,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(FontAwesomeIcons.user,
                                    size: 35.0, color: Colors.white),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Theme',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          elevation: 10.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  //---------------Mobile Mode End-------------//


}
