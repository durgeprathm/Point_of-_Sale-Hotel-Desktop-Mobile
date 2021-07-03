import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/pages/add_product_rate_screen.dart';
import 'package:retailerp/pages/manage_product_rate.dart';
import '../widgets/cutom_submenu_list_item.dart';

class ProductRateMenuList extends StatefulWidget {
  @override
  _ProductRateMenuListState createState() => _ProductRateMenuListState();
}

class _ProductRateMenuListState extends State<ProductRateMenuList> {
  Widget appBarTitle = Text("Product Rate");

  void _selectdItem(int id) {
    switch (id) {
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return AddProductRateScreen();
        }));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return ManageProductRate();
        }));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenOrien = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            screenOrien == Orientation.portrait
                ? CutomSubMenuListItem.copywith2(
                    1,
                    'Add Rate',
                    Color(0xffE57373),
                    FaIcon(FontAwesomeIcons.calculator,
                        size: 35.0, color: Colors.white),
                    2,
                    'Manage Rate',
                    Color(0xffBA68C8),
                    FaIcon(FontAwesomeIcons.calculator,
                        size: 35.0, color: Colors.white),
                    _selectdItem)
                : CutomSubMenuListItem.copywith2(
                    1,
                    'Add Rate',
                    Color(0xffE57373),
                    FaIcon(FontAwesomeIcons.calculator,
                        size: 50.0, color: Colors.white),
                    2,
                    'Manage Rate',
                    Color(0xffBA68C8),
                    FaIcon(FontAwesomeIcons.calculator,
                        size: 50.0, color: Colors.white),
                    _selectdItem),
          ],
        ),
      ),
    );
  }
}
