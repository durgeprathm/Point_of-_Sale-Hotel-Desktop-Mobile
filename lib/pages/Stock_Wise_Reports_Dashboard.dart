import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/Adpater/pos_product_CompanyforStockReports_fetch.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/LocalDbModels/product_model.dart';
import 'package:retailerp/utils/const.dart';



import 'Stock_Catgory_Reports.dart';
import 'Stock_Company_Reports.dart';
import 'Stock_Reports.dart';


class StockWiseReportsDashboard extends StatefulWidget {
  @override
  _StockWiseReportsDashboardState createState() =>
      _StockWiseReportsDashboardState();
}

class _StockWiseReportsDashboardState extends State<StockWiseReportsDashboard> {
  //-------------------------------------------

  List<ProductModel> ProductList = new List();
  List<String> ProductCompanyName = new List();
  static const int kTabletBreakpoint = 552;
  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileStockWiseReportsDashboard();
    } else {
      content = _buildTabletStockWiseReportsDashboard();
    }

    return content;
  }

  @override
  void initState() {
    _getProductCompany();
  } //-------------------------------------------

  //---------------Tablet Mode Start-------------//
  Widget _buildTabletStockWiseReportsDashboard() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.store),
            SizedBox(
              width: 10.0,
            ),
            Text('Stock Wise Reports'),
          ],
        ),
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
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return StockReports();
                          }));
                        },
                        child: Material(
                          color: PURCHASEBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.shoppingCart,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Stock Reports',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
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
                            return StockCatgoryReports();
                          }));
                        },
                        child: Material(
                          color: PRODUCTBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.shoppingBag,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Categery Reports',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
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
                            return StockCompanyReports();
                          }));
                        },
                        child: Visibility(
                          visible: false,
                          child: Material(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(10.0),
                            child: Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '${ProductCompanyName.length}',
                                      style: TextStyle(
                                        fontSize: 30.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Company Reports',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
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
  Widget _buildMobileStockWiseReportsDashboard() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.store),
            SizedBox(
              width: 10.0,
            ),
            Text('Stock Wise Reports'),
          ],
        ),
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
                            return StockReports();
                          }));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: PURCHASEBG,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(FontAwesomeIcons.shoppingCart,
                                    size: 35.0, color: Colors.white),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Stock Reports',
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
                  height: 25.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return StockCatgoryReports();
                          }));
                        },
                        child: Material(
                          color: PRODUCTBG,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.print,
                                  color: Colors.white,
                                  size: 35.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Stock Categery Reports',
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
                    SizedBox(
                      width: 25.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return StockCompanyReports();
                          }));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.pinkAccent,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: FaIcon(FontAwesomeIcons.productHunt,
                                    size: 35.0, color: Colors.white),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Stock Company Wise Reports',
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

  //from server fetching All Product Company Data
  void _getProductCompany() async {
    ProductCompanyFetch productcompanyfetch = new ProductCompanyFetch();
    var getProductCompanyFetchData =
        await productcompanyfetch.getProductCompanyFetch("1");
    var resid = getProductCompanyFetchData["resid"];
    var getProductCompanyFetchsd = getProductCompanyFetchData["product"];
    //print(productcategoryfetchsd.length);
    List<ProductModel> tempgetProductCompanyFetchData = [];
    for (var n in getProductCompanyFetchsd) {
      ProductModel pro = ProductModel.withProductCompanyName(
        n["ProductCompanyName"],
      );
      tempgetProductCompanyFetchData.add(pro);
    }
    setState(() {
      this.ProductList = tempgetProductCompanyFetchData;
    });
    print("//////ProductList/////////${ProductList.length}");

    List<String> tempProductCompanyName = [];
    for (int i = 0; i < ProductList.length; i++) {
      tempProductCompanyName.add(ProductList[i].proComName);
    }
    setState(() {
      this.ProductCompanyName = tempProductCompanyName;
    });
    print(ProductCompanyName);
  }
}
