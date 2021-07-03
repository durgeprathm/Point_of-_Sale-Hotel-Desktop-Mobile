import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/pages/add_product_category_screen.dart';
import 'package:retailerp/pages/manage_product_category.dart';
import '../widgets/cutom_submenu_list_item.dart';

class ProductCategoryMenuList extends StatefulWidget {
  @override
  _ProductCategoryMenuListState createState() =>
      _ProductCategoryMenuListState();
}

class _ProductCategoryMenuListState extends State<ProductCategoryMenuList> {
  Widget appBarTitle = Text("Manage Product Category");

  void _selectdItem(int id) {
    switch (id) {
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return AddProductCategoryScreen();
        }));
        break;

      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) {
          return ManageProductCategory();
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
                    'Add Category',
                    Color(0xffE57373),
                    FaIcon(FontAwesomeIcons.layerGroup,
                        size: 35.0, color: Colors.white),
                    2,
                    'Manage Category',
                    Color(0xffBA68C8),
                    FaIcon(FontAwesomeIcons.stackExchange,
                        size: 35.0, color: Colors.white),
                    _selectdItem)
                : CutomSubMenuListItem.copywith2(
                    1,
                    'Add Category',
                    Color(0xffE57373),
                    FaIcon(FontAwesomeIcons.layerGroup,
                        size: 50.0, color: Colors.white),
                    2,
                    'Manage Category',
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
