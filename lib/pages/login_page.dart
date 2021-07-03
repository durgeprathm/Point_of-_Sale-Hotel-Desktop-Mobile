import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/Adpater/manager_login.dart';
import 'package:retailerp/pages/dashboard.dart';
import 'package:retailerp/utils/const.dart';
import 'package:retailerp/utils/modal_progress_hud.dart';
import 'package:retailerp/widgets/form_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ManagerLogin managerLogin = new ManagerLogin();
  String Username;
  String Password;
  bool showspinnerlog = false;

  final _usernametext = TextEditingController();
  final _passwordtext = TextEditingController();

  bool _usernamevalidate = false;
  bool _passwordvalidate = false;
  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileView();
    } else {
      content = _buildTabletView();
    }
    return content;
  }

  Widget _buildTabletView() {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return new Scaffold(
      body: ModalProgressHUD(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("Images/restaurant_img.jpg"),
                  fit: BoxFit.cover)),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(60),
                    ),
                    Container(
                      width: ScreenUtil.getInstance().setWidth(500),
//      height: ScreenUtil.getInstance().setHeight(500),
                      padding: EdgeInsets.only(bottom: 1),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 15.0),
                                blurRadius: 15.0),
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, -10.0),
                                blurRadius: 10.0),
                          ]),
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 20.0),
                                  Center(
                                    child: Image(
                                      image: AssetImage("Images/aruntelgirni.jpg"),
                                      width: 200,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Username",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(20))),
                            TextField(
                              controller: _usernametext,
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.left,
                              onChanged: (value) {
                                Username = value;
                              },
                              decoration: InputDecoration(
                                  hintText: "username",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                  errorText: _usernamevalidate
                                      ? 'Enter Username'
                                      : null),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Password",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(20))),
                            TextField(
                              controller: _passwordtext,
                              onChanged: (value) {
                                Password = value;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                  errorText: _passwordvalidate
                                      ? 'Enter Password'
                                      : null),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(35),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: InkWell(
                                    child: Container(
                                      width: ScreenUtil.getInstance()
                                          .setWidth(250),
                                      height: ScreenUtil.getInstance()
                                          .setHeight(180),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          PrimaryColor,
                                          PrimaryColor,
                                        ]
                                            //     colors: [
                                            //   Color(0xFF17ead9),
                                            //   Color(0xFF6078ea)
                                            // ]
                                            ),
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //       // color: Color(0xFF6078ea).withOpacity(.3),
                                        //       color: PrimaryColor,
                                        //       offset: Offset(0.0, 8.0),
                                        //       blurRadius: 8.0)
                                        // ]
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () async {
                                            setState(() {
                                              _usernametext.text.isEmpty
                                                  ? _usernamevalidate = true
                                                  : _usernamevalidate = false;

                                              _passwordtext.text.isEmpty
                                                  ? _passwordvalidate = true
                                                  : _passwordvalidate = false;

                                              var errorCheck =
                                                  !_usernamevalidate &&
                                                      !_passwordvalidate;

                                              if (errorCheck) {
                                                checkLogin();
                                              } else {
                                                _scaffoldKey.currentState
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Incorrect Username Or Password"),
                                                  backgroundColor: PrimaryColor,
                                                ));
                                              }
                                            });
                                          },
                                          child: Center(
                                            child: Text("LOGIN",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Poppins-Bold",
                                                    fontSize: 20,
                                                    letterSpacing: 1.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: <Widget>[
                            //     Text(
                            //       "Forgot Password?",
                            //       style: TextStyle(
                            //           color: Colors.blue,
                            //           fontFamily: "Poppins-Medium",
                            //           fontSize: ScreenUtil.getInstance().setSp(28)),
                            //     )
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(80)),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(40),
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(40),
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(30),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        inAsyncCall: showspinnerlog,
      ),
    );
  }

  Widget _buildMobileView() {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showspinnerlog,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Image.asset("assets/image_01.png"),
                ),
                Expanded(
                  child: Container(),
                ),
                Expanded(child: Image.asset("assets/image_02.png"))
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/logo.png",
                            width: ScreenUtil.getInstance().setWidth(110),
                            height: ScreenUtil.getInstance().setHeight(110),
                          ),
                          Text("LOGO",
                              style: TextStyle(
                                  fontFamily: "Poppins-Bold",
                                  fontSize: ScreenUtil.getInstance().setSp(46),
                                  letterSpacing: .6,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(180),
                    ),
                    Container(
                      width: double.infinity,
//      height: ScreenUtil.getInstance().setHeight(500),
                      padding: EdgeInsets.only(bottom: 1),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 15.0),
                                blurRadius: 15.0),
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, -10.0),
                                blurRadius: 10.0),
                          ]),
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Login",
                                style: TextStyle(
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(45),
                                    fontFamily: "Poppins-Bold",
                                    letterSpacing: .6)),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Username",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(26))),
                            TextField(
                              controller: _usernametext,
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.left,
                              onChanged: (value) {
                                Username = value;
                              },
                              decoration: InputDecoration(
                                  hintText: "username",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                  errorText: _usernamevalidate
                                      ? 'Enter Username'
                                      : null),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("PassWord",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(26))),
                            TextField(
                              controller: _passwordtext,
                              onChanged: (value) {
                                Password = value;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                  errorText: _passwordvalidate
                                      ? 'Enter Password'
                                      : null),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(35),
                            ),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            width: ScreenUtil.getInstance().setWidth(330),
                            height: ScreenUtil.getInstance().setHeight(100),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                PrimaryColor,
                                PrimaryColor,
                              ]
                                  //     colors: [
                                  //   Color(0xFF17ead9),
                                  //   Color(0xFF6078ea)
                                  // ]
                                  ),
                              borderRadius: BorderRadius.circular(6.0),
                              // boxShadow: [
                              //   BoxShadow(
                              //       // color: Color(0xFF6078ea).withOpacity(.3),
                              //       color: PrimaryColor,
                              //       offset: Offset(0.0, 8.0),
                              //       blurRadius: 8.0)
                              // ]
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  setState(() {
                                    _usernametext.text.isEmpty
                                        ? _usernamevalidate = true
                                        : _usernamevalidate = false;

                                    _passwordtext.text.isEmpty
                                        ? _passwordvalidate = true
                                        : _passwordvalidate = false;

                                    bool errorCheck = !_usernamevalidate &&
                                        !_passwordvalidate;

                                    if (errorCheck) {
                                      checkLogin();
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "Incorrect Username Or Password",
                                        toastLength: Toast.LENGTH_SHORT,
                                        backgroundColor: Colors.black38,
                                        textColor: Color(0xffffffff),
                                        gravity: ToastGravity.BOTTOM,
                                      );
                                      // _scaffoldKey.currentState
                                      //     .showSnackBar(SnackBar(
                                      //   content: Text(
                                      //       "Incorrect Username Or Password"),
                                      //   backgroundColor: PrimaryColor,
                                      // ));
                                    }
                                  });

                                },
                                child: Center(
                                  child: Text("LOGIN",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins-Bold",
                                          fontSize: 18,
                                          letterSpacing: 1.0)),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(40),
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(40),
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(30),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  void checkLogin() async {
    setState(() {
      showspinnerlog = true;
    });
    var result = await managerLogin.getUser(Username, Password);
    print(result);
    var resid = result["resid"];
    // print(resid);
    if (resid == 200) {

      var username = result["username"];
      var usertype = result["usertype"];
      var name = result["name"];
      var contactno = result["contactno"];
      var permission = result["permission"];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("username", username);
      prefs.setString("usertype", usertype);
      prefs.setString("name", name);
      prefs.setString("contactno", contactno);
      prefs.setString("permission", permission);

      print("USERNAME:///$username");
      print("usertype:///$usertype");
      print("name:///$name");
      print("contactno:///$contactno");
      print("permission:///$permission");

      setState(() {
        showspinnerlog = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => RetailerHomePage()));
    } else {
      setState(() {
        showspinnerlog = false;
      });
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Incorrect Username Or Password"),
        backgroundColor: PrimaryColor,
      ));
    }
  }

}
