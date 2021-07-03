import 'dart:async';

import 'package:flutter/material.dart';
import 'package:retailerp/utils/const.dart';
import '../utils/my_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String USERNAME;
  bool USERCHECK = false;

  // ProfileData profileData = new ProfileData();

  Future<void> _getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      USERNAME = prefs.getString('username');

      if (USERNAME == null) {
        print("null......... $USERNAME");
        setState(() {
          USERCHECK = false;
        });
      } else {
        print("null $USERNAME");
        setState(() {
          USERCHECK = true;
        });
      }
    });
    print(USERNAME);
  }

  @override
  void initState() {
    super.initState();
    _getPrefs();
    Timer(Duration(seconds: 5), () => _showNextScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.0),
                      Center(
                        child: Image(
                          image: AssetImage("Images/aruntelgirni.jpg"),
                          width: 400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.0),
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Image(
                        image: AssetImage("Images/qisystems.png"),
                        width: 50,
                      ),
                    ),
                    Text(
                      "Powered By Q.I. Systems",
                      style: subTextStyle,
                    ),
                    Expanded(
                        child: Text(
                      "www.qisystems.in",
                      style: dashboadrNavTextStyle,
                    ))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _showNextScreen() async {
    if (USERCHECK) {
      try {
        MyNavigator.goToDashboard(context);
      } catch (e) {
        print(e);
      }
    } else {
      MyNavigator.goToLogin(context);
    }
  }

}
