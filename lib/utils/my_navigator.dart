import 'package:flutter/material.dart';
import 'package:retailerp/pages/login_page.dart';
import '../pages/dashboard.dart';

class MyNavigator {
  static void goToDashboard(BuildContext context) {
    // Navigator.pushNamed(context, RetailerHomePage.id);
   Navigator.pushReplacement(
       context, MaterialPageRoute(builder: (context) => RetailerHomePage()));
  }

  static void goToLogin(BuildContext context) {
    // Navigator.pushNamed(context, LoginPage.id);
   Navigator.pushReplacement(
       context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
