import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/pages/add_customer_screen.dart';
import 'package:retailerp/pages/credit_customer.dart';
import 'package:retailerp/pages/manage_customer.dart';
import '../widgets/cutom_submenu_list_item.dart';

class CustomerMenuList extends StatefulWidget {
  @override
  _CustomerMenuListState createState() => _CustomerMenuListState();
}

class _CustomerMenuListState extends State<CustomerMenuList> {
  Widget appBarTitle = Text("Customer");

  void _selectdItem(int id) {
    switch (id) {
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return AddCustomerScreen();
        }));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return ManageCustomer();
        }));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return CreditCustomer();
        }));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenOrien = MediaQuery
        .of(context)
        .orientation;
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            screenOrien == Orientation.portrait
                ? getMobileTabs()
                : getTabletsTabs()
          ],
        ),
      ),
    );
  }

  Column getMobileTabs() {
    return Column(
      children: [
        // CutomSubMenuListItem.copywith3(
        //     1,
        //     'Add Customer',
        //     Color(0xffE57373),
        //     FaIcon(FontAwesomeIcons.calculator,
        //         size: 35.0, color: Colors.white),
        //     2,
        //     'Manage Customer',
        //     Color(0xffBA68C8),
        //     FaIcon(FontAwesomeIcons.calculator,
        //         size: 35.0, color: Colors.white),
        //     3,
        //     'Credit Customer',
        //     Color(0xff7986CB),
        //     FaIcon(FontAwesomeIcons.calculator,
        //         size: 35.0, color: Colors.white),
        //     _selectdItem),
        CutomSubMenuListItem.copywith2(
            1,
            'Add Customer',
            Color(0xffE57373),
            FaIcon(FontAwesomeIcons.calculator,
                size: 35.0, color: Colors.white),
            2,
            'Manage Customer',
            Color(0xffBA68C8),
            FaIcon(FontAwesomeIcons.calculator,
                size: 35.0, color: Colors.white),
            _selectdItem),
        CutomSubMenuListItem(
            3,
            'Credit Customer',
            Color(0xff7986CB),
            FaIcon(FontAwesomeIcons.calculator,
                size: 35.0, color: Colors.white),
            _selectdItem),
      ],
    );
  }

  Column getTabletsTabs() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CutomSubMenuListItem.copywith3(
            1,
            'Add Customer',
            Color(0xffE57373),
            FaIcon(FontAwesomeIcons.calculator,
                size: 35.0, color: Colors.white),
            2,
            'Manage Customer',
            Color(0xffBA68C8),
            FaIcon(FontAwesomeIcons.calculator,
                size: 35.0, color: Colors.white),
            3,
            'Credit Customer',
            Color(0xff7986CB),
            FaIcon(FontAwesomeIcons.calculator,
                size: 35.0, color: Colors.white),
            _selectdItem),
        // CutomSubMenuListItem(
        //     4,
        //     'Paid Customer',
        //     Color(0xff4FC3F7),
        //     FaIcon(FontAwesomeIcons.calculator,
        //         size: 35.0, color: Colors.white),
        //     _selectdItem),
      ],
    );
  }
}
