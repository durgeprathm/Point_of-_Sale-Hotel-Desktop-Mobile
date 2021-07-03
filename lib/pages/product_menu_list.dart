import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/MobilePages/mobile_add_product_screen.dart';
import 'package:retailerp/pages/add_barcode_screen.dart';
import 'package:retailerp/pages/add_product_screen.dart';
import 'package:retailerp/pages/import_product_screen.dart';
import 'package:retailerp/pages/manage_product.dart';
import '../widgets/cutom_submenu_list_item.dart';

class ProductMenuList extends StatefulWidget {
  @override
  _ProductMenuListState createState() => _ProductMenuListState();
}

class _ProductMenuListState extends State<ProductMenuList> {
  Widget appBarTitle = Text("Product");

  void _selectdItem(int id) {
    var screenOrien = MediaQuery.of(context).orientation;

    switch (id) {
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return ManageProduct();
        }));
        break;
      case 2:
        if (screenOrien == Orientation.portrait) {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return MobileAddProductScreen();
          }));
        } else {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return AddProductScreen();
          }));
        }
        break;

      case 3:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return ImportProductScreen();
        }));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return AddBarcode();
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
        CutomSubMenuListItem.copywith2(
            2,
            'Add Product',
            Color(0xffBA68C8),
            FaIcon(FontAwesomeIcons.calculator,
                size: 35.0, color: Colors.white),
            1,
            'Manage Product',
            Color(0xffE57373),
            FaIcon(FontAwesomeIcons.calculator,
                size: 35.0, color: Colors.white),
            _selectdItem),
        CutomSubMenuListItem.copywith2(
            3,
            'Import Product',
            Color(0xff7986CB),
            FaIcon(FontAwesomeIcons.calculator,
                size: 35.0, color: Colors.white),
            4,
            'Product Barcode',
            Color(0xff4FC3F7),
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
            2,
            'Add Product',
            Color(0xffBA68C8),
            FaIcon(FontAwesomeIcons.calculator,
                size: 35.0, color: Colors.white),
            1,
            'Manage Product',
            Color(0xffE57373),
            FaIcon(FontAwesomeIcons.calculator,
                size: 35.0, color: Colors.white),
            3,
            'Import Product',
            Color(0xff7986CB),
            FaIcon(FontAwesomeIcons.calculator,
                size: 35.0, color: Colors.white),
            _selectdItem),
        CutomSubMenuListItem(
            4,
            'Product Barcode',
            Color(0xff4FC3F7),
            FaIcon(FontAwesomeIcons.calculator,
                size: 35.0, color: Colors.white),
            _selectdItem),
      ],
    );
  }
}
