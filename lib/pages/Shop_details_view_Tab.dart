
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:retailerp/Adpater/pos_shop_update.dart';
import 'package:retailerp/EhotelModel/Shop.dart';
import 'package:retailerp/pages/POS_Shop_update.dart';
import 'package:retailerp/pages/pos_shop_fetch.dart';
import 'package:retailerp/utils/const.dart';

class ViewResDetails extends StatefulWidget {
  @override
  _ViewResDetailsState createState() => _ViewResDetailsState();
}
String logo;

class _ViewResDetailsState extends State<ViewResDetails> {
  PhramaShopUpdate updateshop = new PhramaShopUpdate();
  bool _ShopNamevalidate = false;
  bool _ShopMobilevalidate = false;
  bool _ShopOwnervalidate = false;
  bool _ShopEmailvalidate = false;
  bool _ShopGSTvalidate = false;
  bool _ShopCINvalidate = false;
  bool _ShopPANvalidate = false;
  bool _ShopSSINvalidate = false;
  bool _Shopaddressvalidate = false;


  int shopid;
  String ShopName;
  String ShopMobileNumber;
  String ShopOwner;
  String ShopEmail;
  String ShopGST;
  String ShopCIN;
  String ShopPIN;
  String ShopSSIN;
  String ShopAddress;
  File _image;




  ShopUpdate shopupdate = new ShopUpdate();
  ShopFetch shopfetch = new ShopFetch();
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;
  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery
        .of(context)
        .size
        .shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileAddShopView();
    } else {
      content = _buildTabletAddShopView();
    }

    return content;
  }
  //-------------------------------------------
  List<Shop> ShopList = new List();

  int count;
  TextEditingController _shopNametext = new TextEditingController();
  TextEditingController _ShopMobiletext = TextEditingController();
  TextEditingController _ShopOwnertext = TextEditingController();
  TextEditingController _ShopEmailtext = TextEditingController();
  TextEditingController _ShopGSTtext = TextEditingController();
  TextEditingController _ShopCINtext = TextEditingController();
  TextEditingController _ShopPANtext = TextEditingController();
  TextEditingController _ShopSSINtext = TextEditingController();
  TextEditingController _Shopaddresstext = TextEditingController();
  bool enable = true;
  int ShopDeleteId;



  @override
  void initState() {
    //ShowShopDetails();
    _getShopDetails();

  }

//---------------Tablet Mode Start-------------//
  Widget _buildTabletAddShopView() {
    return SingleChildScrollView(
      child:  ShopList.length ==0
          ? CircularProgressIndicator()
          : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Material(
          shape: Border.all( color: Colors.blueGrey, width: 5),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child:  TextField(
                            controller: _shopNametext,
                            readOnly: enable,
                            enableInteractiveSelection: enable,
                            onChanged: (value) {
                                ShopName=value;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText:  'Shop Name',
                              //    errorText: _ShopNamevalidate ? 'Enter Product Name' : null,
                            ),
                          ),
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _ShopMobiletext,
                          readOnly: enable,
                          enableInteractiveSelection: enable,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                               ShopMobileNumber=value;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText:  'Shop Mobile Number',
                            //   errorText: _ShopMobilevalidate ? 'Enter Product Name' : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _ShopOwnertext,
                          readOnly: enable,
                          enableInteractiveSelection: enable,
                          onChanged: (value) {
                               ShopOwner=value;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Shop Owner Name',
                            //  errorText: _ShopOwnervalidate ? 'Enter Product Name' : null,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _ShopEmailtext,
                          readOnly: enable,
                          enableInteractiveSelection: enable,
                          onChanged: (value) {
                              ShopEmail=value;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Shop E-mail',
                            //     errorText: _ShopEmailvalidate ? 'Enter Product Name' : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _ShopGSTtext,
                          readOnly: enable,
                          enableInteractiveSelection: enable,
                          onChanged: (value) {
                              ShopGST=value;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Shop GST Number',
                            //  errorText: _ShopGSTvalidate ? 'Enter Product Name' : null,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _ShopCINtext,
                          readOnly: enable,
                          enableInteractiveSelection: enable,
                          onChanged: (value) {
                             ShopCIN=value;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Shop CIN Number',
                            //  errorText: _ShopCINvalidate ? 'Enter Product Name' : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _ShopPANtext,
                          readOnly: enable,
                          enableInteractiveSelection: enable,
                          onChanged: (value) {
                             ShopPIN=value;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Shop PAN Number',
                            // errorText: _ShopPANvalidate ? 'Enter Product Name' : null,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _ShopSSINtext,
                          readOnly: enable,
                          enableInteractiveSelection: enable,
                          onChanged: (value) {
                            ShopSSIN=value;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Shop SSIN Number',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // SizedBox(
                    //   height: 20.0,
                    // ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _Shopaddresstext,
                          readOnly: enable,
                          enableInteractiveSelection: enable,
                          onChanged: (value) {
                            ShopAddress = value;
                          },
                          maxLines: 3,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Restaurant Address',
                            errorText: _Shopaddressvalidate
                                ? 'Enter Address Name'
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     SizedBox(
                //       height: 20.0,
                //     ),
                //     Expanded(
                //       child: Padding(
                //         padding: const EdgeInsets.all(10.0),
                //         child: TextField(
                //           controller: _Shopaddresstext,
                //           readOnly: enable,
                //           enableInteractiveSelection: enable,
                //           onChanged: (value) {
                //             //    ShopAddress=value;
                //           },
                //           maxLines: 3,
                //           decoration: InputDecoration(
                //             border: OutlineInputBorder(),
                //             labelText: 'Shop Address',
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text(
                //         'Shop Logo:',
                //         style: inputTextStyle,
                //       ),
                //       SizedBox(
                //         width: 20,
                //       ),
                //       FlatButton(
                //         onPressed: () {
                //           print('Choose Image Call');
                //           // getImage();
                //         },
                //         child: Text('Choose Logo',
                //             style: flatbtnTextStyle),
                //         textColor: PrimaryColor,
                //         shape: RoundedRectangleBorder(
                //             side: BorderSide(
                //                 color: PrimaryColor,
                //                 width: 1,
                //                 style: BorderStyle.solid),
                //             borderRadius: BorderRadius.circular(10)),
                //       ),
                //       SizedBox(
                //         width: 200,
                //       ),
                //       Container(
                //         width: 100,
                //         height: 80,
                //         child: logo == null
                //             ? Center(child: Text('No image selected.'))
                //             : Image.file(
                //           File(logo),
                //           width: 30.0,
                //         ),
                //       )
                //
                //
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 350.0,
                    ),
                    FlatButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue),
                      ),
                      textColor: Colors.white,
                      onPressed: ()  async {
                        setState(() {
                          _showMyDialogedit();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                           "EDIT",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    FlatButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue),
                      ),
                      textColor: Colors.white,
                      onPressed: ()  async {
                            print(shopid);
                            print(ShopName);
                            print(ShopMobileNumber);
                            print(ShopOwner);
                            print(ShopEmail);
                            print(ShopGST);
                            print(ShopCIN);
                            print(ShopPIN);
                            print(ShopSSIN);
                            print(ShopAddress);
                            _showMyDialogUpdate();

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "UPDATE",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
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
  Widget _buildMobileAddShopView() {
    return SingleChildScrollView(
      child: ShopList.length == 0
          ? Padding(
        padding: const EdgeInsets.all(40.0),
        child: Material(
          shape: Border.all(color: Colors.blueGrey, width: 5),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                "No Record Found !",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: Colors.red),
              ),
            ),
          ),
        ),
      )
          :
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          shape: Border.all(color: Colors.blueGrey, width: 5),
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  controller: _shopNametext,
                  readOnly: enable,
                  enableInteractiveSelection: enable,
                  onChanged: (value) {
                  //  ShopName=value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Shop Name',
                    errorText: _ShopNamevalidate ? 'Enter Shop Name' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  controller: _ShopMobiletext,
                  readOnly: enable,
                  enableInteractiveSelection: enable,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    ShopMobileNumber=value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Shop Mobile Number',
                    errorText: _ShopMobilevalidate ? 'Enter Shop Mobile Number' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  controller: _ShopOwnertext,
                  readOnly: enable,
                  enableInteractiveSelection: enable,
                  onChanged: (value) {
                    ShopOwner=value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Shop Owner Name',
                    errorText: _ShopOwnervalidate ? 'Enter Shop Owner Name' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  controller: _ShopEmailtext,
                  readOnly: enable,
                  enableInteractiveSelection: enable,
                  onChanged: (value) {
                    ShopEmail=value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Shop E-mail',
                    errorText: _ShopEmailvalidate ? 'Enter Shop E-mail' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  controller: _ShopGSTtext,
                  readOnly: enable,
                  enableInteractiveSelection: enable,
                  onChanged: (value) {
                    ShopGST=value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Shop GST Number',
                    errorText: _ShopGSTvalidate ? 'Enter Shop GST Number' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  controller: _ShopCINtext,
                  readOnly: enable,
                  enableInteractiveSelection: enable,
                  onChanged: (value) {
                    ShopCIN=value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Shop CIN Number',
                    errorText: _ShopCINvalidate ? 'Enter Shop CIN Number' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  controller: _ShopPANtext,
                  readOnly: enable,
                  enableInteractiveSelection: enable,
                  onChanged: (value) {
                    ShopPIN=value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'PAN Number',
                    errorText: _ShopPANvalidate ? 'Enter Shop PAN Number' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  controller: _ShopSSINtext,
                  readOnly: enable,
                  enableInteractiveSelection: enable,
                  onChanged: (value) {
                    ShopSSIN=value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'SSIN Number',
                    errorText: _ShopSSINvalidate ? 'Enter Shop SSIN Number' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: TextField(
                  controller: _Shopaddresstext,
                  readOnly: enable,
                  enableInteractiveSelection: enable,
                  onChanged: (value) {
                    ShopAddress=value;
                  },
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Shop Address',
                    errorText: _Shopaddressvalidate ? 'Enter Shop Address' : null,
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(
              //         'Shop Logo:',
              //         style: inputTextStyle,
              //       ),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       FlatButton(
              //         onPressed: () {
              //           print('Choose Image Call');
              //           // getImage();
              //         },
              //         child: Text('Choose Logo',
              //             style: flatbtnTextStyle),
              //         textColor: PrimaryColor,
              //         shape: RoundedRectangleBorder(
              //             side: BorderSide(
              //                 color: PrimaryColor,
              //                 width: 1,
              //                 style: BorderStyle.solid),
              //             borderRadius: BorderRadius.circular(10)),
              //       ),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(15.0),
              //   child: Container(
              //     width: 100,
              //     height: 80,
              //     child: logo == null
              //         ? Center(child: Text('No image selected.'))
              //         : Image.file(
              //       File(logo),
              //       width: 30.0,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 60.0,
                    ),
                    FlatButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue),
                      ),
                      textColor: Colors.white,
                      onPressed: ()  async {
                        setState(() {
                            _showMyDialogedit();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "EDIT",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    FlatButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue),
                      ),
                      textColor: Colors.white,
                      onPressed: ()  async {
                       // _showMyDialogDelete(ShopDeleteId);
                        _showMyDialogUpdate();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "UPDATE",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );



  }
  //---------------Mobile Mode End-------------//




  // void ShowShopDetails()
  // {
  //   final Future<Database> dbFuture = databaseHelper.initializeDatabase();
  //   dbFuture.then((value) {
  //     Future<List<Shop>> ShopListFuture =
  //     databaseHelper.getShopdetailsList();
  //     ShopListFuture.then((ShopCatList) {
  //       setState(() {
  //         this.ShopList = ShopCatList;
  //         this.count = ShopCatList.length;
  //         this._shopNametext.text = this.ShopList[0].shopname;
  //         this._ShopMobiletext.text = this.ShopList[0].shopmobilenumber;
  //         this._ShopOwnertext.text = this.ShopList[0].shopownername;
  //         this._ShopEmailtext.text = this.ShopList[0].shopemail;
  //         this._ShopGSTtext.text = this.ShopList[0].shopgstnumber;
  //         this._ShopCINtext.text = this.ShopList[0].shopcinnumber;
  //         this._ShopPANtext.text = this.ShopList[0].shoppannumber;
  //         this._ShopSSINtext.text = this.ShopList[0].shopssinnumber;
  //         this._Shopaddresstext.text = this.ShopList[0].shopaddress;
  //         logo= this.ShopList[0].shoplogo;
  //         this.ShopDeleteId = this.ShopList[0].sid;
  //       });
  //     });
  //   });
  // }


  Future<void> _showMyDialogDelete(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child:  AlertDialog(
            title: Text("Want To Delete!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Delete'),
                onPressed: () async {
                  // var result = await databaseHelper
                  //     .deleteShopRecord(id);
                  // if (result != 0) {
                  //   setState(() {
                  //     print('Delete Succcess');
                  //     Navigator.of(context).pop();
                  //   });
                  //
                  // } else {
                  //
                  // }

                },
              ),
            ],
          ),
        );
      },
    );
  }
  //------------------------------------------------

//----------------------dialog for Edit -------------------------
  Future<void> _showMyDialogedit() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              "Want to Edit Information!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: Text('Edit'),
                  onPressed: () async {
                    setState(() {
                      enable = false;
                      Navigator.of(context).pop();
                    });
                  }),
            ],
          ),
        );
      },
    );
  }
  //----------------dialog for edit end--------------------------
//----------------------dialog for Edit -------------------------
  Future<void> _showMyDialogUpdate() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              "Do You Want To Update !",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: Text('Update'),
                  onPressed: () async {
                    setState(() {
                      var result = updateshop.getphramashopUpdate(
                          shopid.toString(),
                          ShopName,
                          ShopMobileNumber,
                          ShopOwner,
                          ShopEmail,
                          ShopGST,
                          ShopCIN,
                          ShopPIN,
                          ShopSSIN,
                          ShopAddress);
                      if (result == null) {
                        Navigator.of(context).pop();
                        _showMyDialog('Filed !', Colors.red);
                      } else {
                        Navigator.of(context).pop();
                        _showMyDialog(
                            'Data Updated Successfully !', Colors.green);
                      }
                      //Navigator.of(context).pop();
                    });
                  }),
            ],
          ),
        );
      },
    );
  }



  Future<void> _showMyDialog(String msg, Color col) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              msg,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: col,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
//----------------dialog for edit end--------------------------
  void _getShopDetails() async {
    ShopFetch shopdatafetch = new ShopFetch();
    var ShopData = await shopdatafetch.getshopfetch("1");
    int resid = ShopData["resid"];
    if (resid == 200) {
      var ShopDatasd = ShopData["shop"];
      print(ShopDatasd.length);
      List<Shop> tempShopDetails = [];
      for (var n in ShopDatasd) {
        Shop pro = Shop.Withoutlogo(
            int.parse(n["ShopId"]),
            n["ShopName"],
            n["ShopMobileNumber"],
            n["ShopOwnerName"],
            n["ShopEmail"],
            n["ShopGSTNumber"],
            n["ShopCINNumber"],
            n["ShopPANNumber"],
            n["ShopSSINNumber"],
            n["ShopAddress"]);
        tempShopDetails.add(pro);
      }
      setState(() {
        this.ShopList = tempShopDetails;
      });
    } else {
      String message = ShopData["message"];
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: PrimaryColor,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
    print("//////ShopDetails/////////$ShopList.length");
    setState(() {
      shopid = int.parse(this.ShopList[0].sid.toString());
      ShopName=ShopList[0].shopname;
      ShopMobileNumber = ShopList[0].shopmobilenumber;
      ShopOwner = ShopList[0].shopownername;
      ShopEmail = ShopList[0].shopemail;
      ShopGST = ShopList[0].shopgstnumber;
      ShopCIN = ShopList[0].shopcinnumber;
      ShopPIN = ShopList[0].shoppannumber;
      ShopSSIN = ShopList[0].shopssinnumber;
      ShopAddress = ShopList[0].shopaddress;



      this._shopNametext.text = ShopList[0].shopname;
      this._ShopMobiletext.text = ShopList[0].shopmobilenumber;
      this._ShopOwnertext.text = ShopList[0].shopownername;
      this._ShopEmailtext.text = ShopList[0].shopemail;
      this._ShopGSTtext.text = ShopList[0].shopgstnumber;
      this._ShopCINtext.text = ShopList[0].shopcinnumber;
      this._ShopPANtext.text = ShopList[0].shoppannumber;
      this._ShopSSINtext.text = ShopList[0].shopssinnumber;
      this._Shopaddresstext.text = ShopList[0].shopaddress;
    });

  }
}

// Padding(
// padding: const EdgeInsets.all(70.0),
// child: Material(
// shape: Border.all(color: Colors.blueGrey, width: 5),
// child: Padding(
// padding: const EdgeInsets.all(40.0),
// child: Center(
// child: Text(
// "No Record Found !",
// style: TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 50.0,
// color: Colors.red),
// ),
// ),
// ),
// ),
// )