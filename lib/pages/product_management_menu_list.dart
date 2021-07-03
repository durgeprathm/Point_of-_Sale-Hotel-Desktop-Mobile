import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/pages/add_barcode_screen.dart';
import 'package:retailerp/pages/add_product_screen.dart';
import 'package:retailerp/pages/conversion.dart';
import 'package:retailerp/pages/import_product_screen.dart';
import 'package:retailerp/pages/menu_Dashboard.dart';
import 'package:retailerp/pages/product_category_menu_list.dart';
import 'package:retailerp/pages/product_menu_list.dart';
import 'package:retailerp/pages/product_rate_menu_list.dart';
import 'package:retailerp/utils/const.dart';
import '../widgets/cutom_submenu_list_item.dart';

class   ProductManagementMenuList extends StatefulWidget {
  @override
  _ProductManagementMenuListState createState() =>
      _ProductManagementMenuListState();
}

class _ProductManagementMenuListState extends State<ProductManagementMenuList> {
  Widget appBarTitle = Text("Product Management");

  void _selectdItem(int id) {
    switch (id) {
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return ProductCategoryMenuList();
        }));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return ProductMenuList();
        }));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return ProductRateMenuList();
        }));
        break;

      case 4:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return MenuDashboard();
          }),
        );
        break;
      case 5:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) {
          return ConversionPage();
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
                ? getMobileTabs(): getTabletsTabs()
          ],
        ),
      ),
    );
  }

  Column getMobileTabs() {
    return Column(
      children: [
        CutomSubMenuListItem.copywith2(
            1,
            'Product Category',
            Color(0xffE57373),
            FaIcon(FontAwesomeIcons.productHunt,
                size: 35.0, color: Colors.white),
            2,
            'Product',
            Color(0xffBA68C8),
            FaIcon(FontAwesomeIcons.shoppingCart,
                size: 35.0, color: Colors.white),
            _selectdItem),
        CutomSubMenuListItem(
            3,
            'Product Rate',
            Color(0xff7986CB),
            FaIcon(FontAwesomeIcons.sortAmountUp,
                size: 35.0, color: Colors.white),
            _selectdItem),
      ],
    );
  }

  Widget getTabletsTabs() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                        return ProductMenuList();
                      }));
                    },
                    child: Material(
                      color: Color(0xffE57373),
                      borderRadius: BorderRadius.circular(10.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: FaIcon(FontAwesomeIcons.calculator,
                                size: 50.0, color: Colors.white),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Product",
                              style: dashboadrTextStyle,
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                        return ProductCategoryMenuList();
                      }));
                    },
                    child: Material(
                      color: Color(0xff81C784),
                      borderRadius: BorderRadius.circular(10.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.book,
                                size: 50.0, color: Colors.white),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Product Category",
                              style: dashboadrTextStyle,
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                        return ProductRateMenuList();
                      }));
                    },
                    child: Material(
                      color: Color(0xff4DD0E1),
                      borderRadius: BorderRadius.circular(10.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: FaIcon(
                              FontAwesomeIcons.personBooth,
                              color: Colors.white,
                              size: 50.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Product Rate",
                              style: dashboadrTextStyle,
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
              height: 20.0,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                        return MenuDashboard();
                      }),
                      );
                    },
                    child: Material(
                      color: EMPBG,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: FaIcon(FontAwesomeIcons.calculator,
                                size: 50.0, color: Colors.white),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Customized Product",
                              style: dashboadrTextStyle,
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
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return ConversionPage();
                      }));

                    },
                    child: Material(
                      color: PRODUCTBG,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.book,
                                size: 50.0, color: Colors.white),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Conversion Product",
                              style: dashboadrTextStyle,
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                        return ProductRateMenuList();
                      }));
                    },
                    child: Visibility(
                      visible: false,
                      child: Material(
                        color: Color(0xff4DD0E1),
                        borderRadius: BorderRadius.circular(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: FaIcon(
                                FontAwesomeIcons.personBooth,
                                color: Colors.white,
                                size: 50.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Product Rate",
                                style: dashboadrTextStyle,
                              ),
                            )
                          ],
                        ),
                        elevation: 10.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
