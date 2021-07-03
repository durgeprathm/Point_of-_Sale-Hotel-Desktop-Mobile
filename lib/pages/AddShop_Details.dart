import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retailerp/pages/Shop_details_view_Tab.dart';
import 'package:retailerp/pages/addshop_Tab.dart';
import 'package:retailerp/pages/dashboard.dart';


class ShopDetails extends StatefulWidget {
  @override
  _ShopDetailsState createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  @override
  //------------------------
  static const int kTabletBreakpoint = 552;
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery
        .of(context)
        .size
        .shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileAddShopDetails();
    } else {
      content = _buildTabletAddShopDetails();
    }

    return content;
  }
  //------------------------

//---------------Tablet Mode Start-------------//
  Widget _buildTabletAddShopDetails() {
    void handleClick(String value) {
      switch (value) {
      }
    }

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff01579B),
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Colors.white),
              onPressed: () {

                Navigator.pop(context);
              },
            ),
            title:Row(
              children: [
//            FaIcon(FontAwesomeIcons.cog),
                SizedBox(
                  width: 10.0,
                ),
                Text('Add Shop Details'),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return RetailerHomePage();
                  }));
                },
              ),
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {
                    'Add Printer',
                    'Profile',
                    'Forget Password',
                  }.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],

            bottom:TabBar(
              tabs: [
                Tab(
                  child :Row(
                    children: [
                      FaIcon(FontAwesomeIcons.plus),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text('Add Restaurant Details',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child :Row(
                    children: [
                      FaIcon(FontAwesomeIcons.streetView),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text('View Restaurant Details',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              children: [
                AddRestDetails(),
                ViewResDetails(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  //---------------Tablet Mode Start-------------//
    //---------------Mobile Mode Start-------------//
    Widget _buildMobileAddShopDetails() {
      void handleClick(String value) {
        // switch (value) {
        // case 'Add Printer':
        //   Navigator.push(context,
        //       MaterialPageRoute(
        //           builder: (context) => AddSales()));
        //   break;
        // case 'Profile':
        //   Navigator.push(context, MaterialPageRoute(
        //       builder: (context) => ViewNotes(widget.DBNAME, widget.EID)
        //   ));
        //   break;
        // case 'Forget Password':
        //   Navigator.push(context, MaterialPageRoute(
        //       builder: (context) => ViewNotes(widget.DBNAME, widget.EID)
        //   ));
        //   break;
        //
        // }
      }

      return MaterialApp(
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              // color:Colors.deepPurpleAccent,
              automaticallyImplyLeading: true,
              title:Row(
                children: [
//            FaIcon(FontAwesomeIcons.cog),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('Add Shop Details'),
                ],
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.home, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      // return RetailerHomePage();
                    }));
                  },
                ),
                PopupMenuButton<String>(
                  onSelected: handleClick,
                  itemBuilder: (BuildContext context) {
                    return {
                      'Add Printer',
                      'Profile',
                      'Forget Password',
                    }.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],

              bottom:TabBar(
                tabs: [
                  Tab(
                    child :Row(
                      children: [
                        FaIcon(FontAwesomeIcons.plus),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text('Add Details',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child :Row(
                      children: [
                        FaIcon(FontAwesomeIcons.streetView),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text('View Details',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            body: SafeArea(
              child: TabBarView(
                children: [
                  AddRestDetails(),
                  ViewResDetails(),
                ],
              ),
            ),
          ),
        ),
      );
  }
//---------------Tablet Mode Start-------------//
}

// class ViewResDetails extends StatelessWidget {
//   const ViewResDetails({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Text('View');
//   }
// }



