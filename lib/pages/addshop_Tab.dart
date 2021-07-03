import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/Adpater/EhotelAdapter/pos_shop_fetch.dart';
import 'package:retailerp/EhotelModel/Shop.dart';
import 'package:retailerp/helpers/database_helper.dart';
import 'package:retailerp/models/shop_bank_detail.dart';
import 'package:retailerp/pages/POS_Shop_Insert.dart';
import 'package:retailerp/utils/const.dart';
import 'package:sqflite/sqflite.dart';

class AddRestDetails extends StatefulWidget {
  @override
  _AddRestDetailsState createState() => _AddRestDetailsState();
}

class _AddRestDetailsState extends State<AddRestDetails> {
  //-------------------------------------------
  static const int kTabletBreakpoint = 552;
  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);
    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileAddShopDetails();
    } else {
      content = _buildTabletAddShopDetails();
    }

    return content;
  }
  //-------------------------------------------
  List<String> mAccountType = ['Current', 'Saving'];
  DatabaseHelper databaseHelper = new DatabaseHelper();
  List<Shop> ShopList = new List();
  List<Shop> ShopDetails = new List();
  bool _showProgress = false;
  PhramaShopInsert shopinsert = new PhramaShopInsert();
  List<ShopBankDetailsItems> shopBankItemList = [];

  @override
  final _shopNametext = TextEditingController();
  final _ShopMobiletext = TextEditingController();
  final _ShopOwnertext = TextEditingController();
  final _ShopEmailtext = TextEditingController();
  final _ShopGSTtext = TextEditingController();
  final _ShopCINtext = TextEditingController();
  final _ShopPANtext = TextEditingController();
  final _ShopSSINtext = TextEditingController();
  final _Shopaddresstext = TextEditingController();

  bool _ShopNamevalidate = false;
  bool _ShopMobilevalidate = false;
  bool _ShopOwnervalidate = false;
  bool _ShopEmailvalidate = false;
  bool _ShopGSTvalidate = false;
  bool _ShopCINvalidate = false;
  bool _ShopPANvalidate = false;
  bool _ShopSSINvalidate = false;
  bool _Shopaddressvalidate = false;

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
  final picker = ImagePicker();
  String _imageFilePath;

  bool _bankHolderNamevalidate = false;
  bool _bankNamevalidate = false;
  bool _bankAcNovalidate = false;
  bool _bankIFSCCodevalidate = false;
  bool _ShopDrugNovalidate = false;
  bool _ShopFoodNOvalidate = false;
  bool _ShopDeclarationvalidate = false;
  var cartItem;
  final _bankHolderNametext = TextEditingController();
  final _bankNametext = TextEditingController();
  final _bankAcNotext = TextEditingController();
  final _bankIFSCCodetext = TextEditingController();
  String bankHolderName;
  String bankName;
  String bankAcNo;
  String bankAcType;
  String bankIFSCCode;

//---------------Tablet Mode Start-------------//
  Widget _buildTabletAddShopDetails() {
    return SingleChildScrollView(
        child: Consumer<ShopBankDetails>(builder: (context, cart, child) {
          return       Padding(
            padding: const EdgeInsets.all(20.0),
            child: Material(
              shape: Border.all(color: Colors.blueGrey, width: 5),
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
                            child: TextField(
                              controller: _shopNametext,
                              obscureText: false,
                              onChanged: (value) {
                                ShopName = value;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Restaurant Name',
                                errorText:
                                _ShopNamevalidate ? 'Enter Product Name' : null,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              controller: _ShopMobiletext,
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                ShopMobileNumber = value;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Restaurant Mobile Number',
                                errorText: _ShopMobilevalidate
                                    ? 'Enter Product Name'
                                    : null,
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
                              obscureText: false,
                              onChanged: (value) {
                                ShopOwner = value;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Restaurant Owner Name',
                                errorText: _ShopOwnervalidate
                                    ? 'Enter Product Name'
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              controller: _ShopEmailtext,
                              obscureText: false,
                              onChanged: (value) {
                                ShopEmail = value;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Restaurant E-mail',
                                errorText: _ShopEmailvalidate
                                    ? 'Enter Product Name'
                                    : null,
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
                              obscureText: false,
                              onChanged: (value) {
                                ShopGST = value;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Restaurant GST Number',
                                errorText:
                                _ShopGSTvalidate ? 'Enter Product Name' : null,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              controller: _ShopCINtext,
                              obscureText: false,
                              onChanged: (value) {
                                ShopCIN = value;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Restaurant CIN Number',
                                errorText:
                                _ShopCINvalidate ? 'Enter Product Name' : null,
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
                              obscureText: false,
                              onChanged: (value) {
                                ShopPIN = value;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'PAN Number',
                                errorText:
                                _ShopPANvalidate ? 'Enter Product Name' : null,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              controller: _ShopSSINtext,
                              obscureText: false,
                              onChanged: (value) {
                                ShopSSIN = value;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'SSIN Number',
                                errorText:
                                _ShopSSINvalidate ? 'Enter Product Name' : null,
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
                              obscureText: false,
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
                    Divider(
                      thickness: 1.0,
                      color: primary,
                    ),
                    Row(children: [
                      Expanded(
                        child: TextField(
                          controller: _bankHolderNametext,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {

                             bankHolderName = value;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Bank Holder Name*',
                            errorText: _bankHolderNamevalidate
                                ? 'Enter Bank Holder Name'
                                : null,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _bankNametext,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                           bankName = value;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Bank Name*',
                            //  errorText: _bankNamevalidate ? 'Enter Bank Name' : null,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: DropdownSearch(
                            items: mAccountType,
                          label: "Select Account Type *",
                          showClearButton: true,
                          onChanged: (value) {

                            if (value != null) {
                              bankAcType = value;
                            } else {
                              bankAcType = null;
                            }

                          },
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _bankAcNotext,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            bankAcNo = value;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Bank A/C No*',
                            // errorText:
                            //     _bankAcNovalidate ? 'Enter Bank A/C No' : null,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _bankIFSCCodetext,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            bankIFSCCode = value;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Bank IFSC Code*',
                            errorText: _bankIFSCCodevalidate
                                ? 'Enter Bank IFSC Code'
                                : null,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            print('Add Btn Call');

                            if (_bankHolderNametext.text.isEmpty) {
                              _bankHolderNamevalidate = true;
                            } else {
                              _bankHolderNamevalidate = false;
                            }

                            if (_bankNametext.text.isEmpty) {
                              _bankNamevalidate = true;
                            } else {
                              _bankNamevalidate = false;
                            }

                            if (_bankAcNotext.text.isEmpty) {
                              _bankAcNovalidate = true;
                            } else {
                              _bankAcNovalidate = false;
                            }

                            if (_bankIFSCCodetext.text.isEmpty) {
                              _bankIFSCCodevalidate = true;
                            } else {
                              _bankIFSCCodevalidate = false;
                            }

                            bool errorCheck = (!_bankHolderNamevalidate &&
                                !_bankNamevalidate &&
                                !_bankAcNovalidate &&
                                !_bankIFSCCodevalidate &&
                                bankAcType != null);
                            if (errorCheck) {
                              final purBank = ShopBankDetailsItems(
                                  bankHolderName,
                                  bankName,
                                  bankAcNo,
                                  bankAcType,
                                  bankIFSCCode);

                              Provider.of<ShopBankDetails>(context,
                                  listen: false)
                                  .addPurchaseProduct(purBank);

                              setState(() {
                                cartItem = cart;
                                shopBankItemList = cartItem.pbank;

                                _bankHolderNametext.text = '';
                                bankHolderName = null;
                                bankName = null;
                                _bankNametext.text = '';
                                bankAcNo = null;
                                _bankAcNotext.text = '';
                                // bankAcType = null;
                                bankIFSCCode = null;
                                _bankIFSCCodetext.text = '';
                              });
                            } else {
                              // Fluttertoast.showToast(
                              //   msg: "Check Product data!!!",
                              //   toastLength: Toast.LENGTH_SHORT,
                              //   backgroundColor: Colors.black38,
                              //   textColor: Color(0xffffffff),
                              //   gravity: ToastGravity.BOTTOM,
                              // );
                            }
                          });
                        },
                          icon: FaIcon(
                            FontAwesomeIcons.plusCircle,
                            color: PrimaryColor,
                          )),
                    ]),
                    Visibility(
                      visible: cart.itemCount == 0 ? false : true,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // height: 300,
                          child: cart.itemCount != 0
                              ? DataTable(
                              columnSpacing: 20,
                              columns: [
                                DataColumn(
                                    label: Expanded(
                                      child: Container(
                                        child: Center(
                                          child: Center(
                                            child: Text('Sr No'),
                                          ),
                                        ),
                                      ),
                                    )),
                                DataColumn(
                                    label: Expanded(
                                      child: Container(
                                        child: Center(
                                          child: Text('Name',),
                                        ),
                                      ),
                                    )),
                                DataColumn(
                                    label: Expanded(
                                      child: Container(
                                        child: Center(
                                          child: Text('Bank Name'),
                                        ),
                                      ),
                                    )),
                                DataColumn(
                                    label: Expanded(
                                      child: Container(
                                        child: Center(
                                            child: Text('Bank A/C No.',)),
                                      ),
                                    )),
                                DataColumn(
                                    label: Expanded(
                                      child: Container(
                                        child: Center(
                                          child: Text('Account\Type',),
                                        ),
                                      ),
                                    )),
                                DataColumn(
                                    label: Expanded(
                                      child: Container(
                                        child: Center(
                                          child: Text('IFSC Code',),
                                        ),
                                      ),
                                    )),
                                DataColumn(
                                    label: Expanded(
                                      child: Container(
                                        child: Center(
                                          child: Text('Action',),
                                        ),
                                      ),
                                    )),
                              ],
                              rows: getDataRowList())
                              : Text(''),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Divider(
                      thickness: 1.0,
                      color: primary,
                    ),

                    FlatButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue),
                      ),
                      textColor: Colors.white,
                      onPressed: () async {
                        print(ShopName);
                        print(ShopMobileNumber);
                        print(ShopOwner);
                        print(ShopEmail);
                        print(ShopGST);
                        print(ShopCIN);
                        print(ShopPIN);
                        print(ShopSSIN);
                        print(ShopAddress);

                        if (ShopName == null ||
                            ShopMobileNumber == null ||
                            ShopOwner == null ||
                            ShopEmail == null ||
                            ShopGST == null ||
                            ShopCIN == null ||
                            ShopPIN == null ||
                            ShopSSIN == null ||
                            ShopAddress == null) {
                          print("not save in if");
                          _shopNametext.text.isEmpty
                              ? _ShopNamevalidate = true
                              : _ShopNamevalidate = false;
                          _ShopMobiletext.text.isEmpty
                              ? _ShopMobilevalidate = true
                              : _ShopMobilevalidate = false;
                          _ShopOwnertext.text.isEmpty
                              ? _ShopOwnervalidate = true
                              : _ShopOwnervalidate = false;
                          _ShopEmailtext.text.isEmpty
                              ? _ShopEmailvalidate = true
                              : _ShopEmailvalidate = false;
                          _ShopGSTtext.text.isEmpty
                              ? _ShopGSTvalidate = true
                              : _ShopGSTvalidate = false;
                          _ShopCINtext.text.isEmpty
                              ? _ShopCINvalidate = true
                              : _ShopCINvalidate = false;
                          _ShopPANtext.text.isEmpty
                              ? _ShopPANvalidate = true
                              : _ShopPANvalidate = false;
                          _ShopSSINtext.text.isEmpty
                              ? _ShopSSINvalidate = true
                              : _ShopSSINvalidate = false;
                          _Shopaddresstext.text.isEmpty
                              ? _Shopaddressvalidate = true
                              : _Shopaddressvalidate = false;
                        } else {
                          List<String> bankHolderNameList = new List();
                          List<String> bankNameList = new List();
                          List<String> bankAcNoList = new List();
                          List<String> bankAcTypeList = new List();
                          List<String> bankIFSCCodeList = new List();

                          List<ShopBankDetailsItems> pTempRecipeList = [];
                          pTempRecipeList = cart.pbank;

                          pTempRecipeList.forEach((element) {
                            bankHolderNameList
                                .add(element.bankHolderName.toString());
                            bankNameList.add(element.bankName);
                            bankAcNoList.add(element.bankAcNo);
                            bankAcTypeList.add(element.bankAcType);
                            bankIFSCCodeList.add(element.bankIFSCCode);
                          });
                          String JoinedbankHolderName =
                          bankHolderNameList.join("#");
                          String JoinedbankName = bankNameList.join("#");
                          String JoinedbankAcNo = bankAcNoList.join("#");
                          String JoinedbankAcType = bankAcTypeList.join("#");
                          String JoinedbankIFSCCode = bankIFSCCodeList.join("#");



                          print("save in else");
                          var result = shopinsert.getphramashopinsert(
                              ShopName,
                              ShopMobileNumber,
                              ShopOwner,
                              ShopEmail,
                              ShopGST,
                              ShopCIN,
                              ShopPIN,
                              ShopSSIN,
                              ShopAddress,  cart.itemCount != 0
                              ? JoinedbankHolderName
                              : '',
                              cart.itemCount != 0 ? JoinedbankName : '',
                              cart.itemCount != 0 ? JoinedbankAcNo : '',
                              cart.itemCount != 0 ? JoinedbankAcType : '',
                              cart.itemCount != 0
                                  ? JoinedbankIFSCCode
                                  : '');
                          if (result == null) {
                            _showMyDialog('Filed !', Colors.red);
                          } else {
                            _showMyDialog('Data Successfully Save !', Colors.green);
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Add Shop Details",
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
            ),
          );
        }
    ));
  }

//---------------Tablet Mode End-------------//
  //---------------Mobile Mode Start-------------//
  Widget _buildMobileAddShopDetails() {
    return SingleChildScrollView(
      child: ShopDetails.length >= 1
          ? Padding(
              padding: const EdgeInsets.all(40.0),
              child: Material(
                shape: Border.all(color: Colors.blueGrey, width: 5),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      "Shop Details Already Added !",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          color: Colors.red),
                    ),
                  ),
                ),
              ),
            )
          : Padding(
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
                        obscureText: false,
                        onChanged: (value) {
                          ShopName = value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Shop Name',
                          errorText:
                              _ShopNamevalidate ? 'Enter Shop Name' : null,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: TextField(
                        controller: _ShopMobiletext,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          ShopMobileNumber = value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Shop Mobile Number',
                          errorText: _ShopMobilevalidate
                              ? 'Enter Shop Mobile Number'
                              : null,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: TextField(
                        controller: _ShopOwnertext,
                        obscureText: false,
                        onChanged: (value) {
                          ShopOwner = value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Shop Owner Name',
                          errorText: _ShopOwnervalidate
                              ? 'Enter Shop Owner Name'
                              : null,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: TextField(
                        controller: _ShopEmailtext,
                        obscureText: false,
                        onChanged: (value) {
                          ShopEmail = value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Shop E-mail',
                          errorText:
                              _ShopEmailvalidate ? 'Enter Shop E-mail' : null,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: TextField(
                        controller: _ShopGSTtext,
                        obscureText: false,
                        onChanged: (value) {
                          ShopGST = value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Shop GST Number',
                          errorText:
                              _ShopGSTvalidate ? 'Enter Shop GST Number' : null,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: TextField(
                        controller: _ShopCINtext,
                        obscureText: false,
                        onChanged: (value) {
                          ShopCIN = value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Shop CIN Number',
                          errorText:
                              _ShopCINvalidate ? 'Enter Shop CIN Number' : null,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: TextField(
                        controller: _ShopPANtext,
                        obscureText: false,
                        onChanged: (value) {
                          ShopPIN = value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'PAN Number',
                          errorText:
                              _ShopPANvalidate ? 'Enter Shop PAN Number' : null,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: TextField(
                        controller: _ShopSSINtext,
                        obscureText: false,
                        onChanged: (value) {
                          ShopSSIN = value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'SSIN Number',
                          errorText: _ShopSSINvalidate
                              ? 'Enter Shop SSIN Number'
                              : null,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: TextField(
                        controller: _Shopaddresstext,
                        obscureText: false,
                        onChanged: (value) {
                          ShopAddress = value;
                        },
                        maxLines: 3,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Shop Address',
                          errorText: _Shopaddressvalidate
                              ? 'Enter Shop Address'
                              : null,
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: Row(
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
                    //           getImage();
                    //         },
                    //         child: Text('Choose Logo', style: flatbtnTextStyle),
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
                    //     child: _image == null
                    //         ? Center(child: Text('No image selected.'))
                    //         : Image.file(_image),
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: FlatButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue),
                        ),
                        textColor: Colors.white,
                        onPressed: () async {
                          // print(ShopName);
                          // print(ShopMobileNumber);
                          // print(ShopOwner);
                          // print(ShopEmail);
                          // print(ShopGST);
                          // print(ShopCIN);
                          // print(ShopPIN);
                          // print(ShopSSIN);
                          // print(ShopAddress);
                          // setState(() async {
                          //   if (ShopName != null ||
                          //       ShopMobileNumber != null ||
                          //       ShopOwner != null ||
                          //       ShopEmail != null ||
                          //       ShopGST != null ||
                          //       ShopCIN != null ||
                          //       ShopPIN != null ||
                          //       ShopSSIN != null ||
                          //       ShopAddress != null) {
                          //     print("not empty");
                          //     var result = shopinsert.getphramashopinsert(
                          //         ShopName,
                          //         ShopMobileNumber,
                          //         ShopOwner,
                          //         ShopEmail,
                          //         ShopGST,
                          //         ShopCIN,
                          //         ShopPIN,
                          //         ShopSSIN,
                          //         ShopAddress);
                          //     if (result == null) {
                          //       _showMyDialog('Filed !', Colors.red);
                          //     } else {
                          //       _showMyDialog(
                          //           'Data Successfully Save !', Colors.green);
                          //     }
                          //   } else {
                          //     print("empty");
                          //     _shopNametext.text.isEmpty
                          //         ? _ShopNamevalidate = true
                          //         : _ShopNamevalidate = false;
                          //     _ShopMobiletext.text.isEmpty
                          //         ? _ShopMobilevalidate = true
                          //         : _ShopMobilevalidate = false;
                          //     _ShopOwnertext.text.isEmpty
                          //         ? _ShopOwnervalidate = true
                          //         : _ShopOwnervalidate = false;
                          //     _ShopEmailtext.text.isEmpty
                          //         ? _ShopEmailvalidate = true
                          //         : _ShopEmailvalidate = false;
                          //     _ShopGSTtext.text.isEmpty
                          //         ? _ShopGSTvalidate = true
                          //         : _ShopGSTvalidate = false;
                          //     _ShopCINtext.text.isEmpty
                          //         ? _ShopCINvalidate = true
                          //         : _ShopCINvalidate = false;
                          //     _ShopPANtext.text.isEmpty
                          //         ? _ShopPANvalidate = true
                          //         : _ShopPANvalidate = false;
                          //     _ShopSSINtext.text.isEmpty
                          //         ? _ShopSSINvalidate = true
                          //         : _ShopSSINvalidate = false;
                          //     _Shopaddresstext.text.isEmpty
                          //         ? _Shopaddressvalidate = true
                          //         : _Shopaddressvalidate = false;
                          //   }
                          // });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Add Shop Details",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
//---------------Mobile Mode End-------------//


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

  Future getImage() async {
    print('getImage() Call');
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imageFilePath = pickedFile.path;
        print('_image Path Call : ${_imageFilePath}');
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    _getShopDetails();
    Provider.of<ShopBankDetails>(context, listen: false).clear();
  }

  List<DataRow> getDataRowList() {
    print("shopBankItemList: ${shopBankItemList.length}");
    List<DataRow> myTempDataRow = List();
    for (int i = 0; i < shopBankItemList.length; i++) {
      myTempDataRow.add(getRow(i));
    }
    return myTempDataRow;
  }

  DataRow getRow(int index) {
    var serNo = index + 1;
    return DataRow(cells: [
      DataCell(Center(child: Text(serNo.toString()))),
      DataCell(Center(
          child: Text(shopBankItemList[index].bankHolderName.toString()))),
      DataCell(
          Center(child: Text(shopBankItemList[index].bankName.toString()))),
      DataCell(
          Center(child: Text(shopBankItemList[index].bankAcNo.toString()))),
      DataCell(
          Center(child: Text(shopBankItemList[index].bankAcType.toString()))),
      DataCell(
          Center(child: Text(shopBankItemList[index].bankIFSCCode.toString()))),
      DataCell(
        Center(
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                color: Colors.red,
                onPressed: () {
                  final cartI = cartItem.pbank[index];
                  Provider.of<ShopBankDetails>(context, listen: false)
                      .removeItem(cartI);
                },
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  // void ShowShopDetails() {
  //   final Future<Database> dbFuture = databaseHelper.initializeDatabase();
  //   dbFuture.then((value) {
  //     Future<List<Shop>> ShopListFuture = databaseHelper.getShopdetailsList();
  //     ShopListFuture.then((ShopCatList) {
  //       setState(() {
  //         this.ShopList = ShopCatList;
  //       });
  //     });
  //   });
  // }


  //from server fetching Shop Details data


  void _getShopDetails() async {
    setState(() {
      _showProgress = true;
    });
    ShopFetch shopdatafetch = new ShopFetch();
    var ShopData = await shopdatafetch.getShopFetch("1");
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
        this.ShopDetails = tempShopDetails;
      });
    } else {
      setState(() {
        _showProgress = false;
      });
      String message = ShopData["message"];
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: PrimaryColor,
        textColor: Color(0xffffffff),
        gravity: ToastGravity.BOTTOM,
      );
    }
    setState(() {
      _showProgress = false;
    });
    print("//////ShopDetails/////////$ShopDetails.length");
  }
}
// ShopDetails.length  >= 1
// ? Padding(
// padding: const EdgeInsets.all(70.0),
// child: Material(
// shape: Border.all(color: Colors.blueGrey, width: 5),
// child: Padding(
// padding: const EdgeInsets.all(40.0),
// child: Center(
// child: Text(
// "Shop Details Already Added !",
// style: TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 50.0,
// color: Colors.red),
// ),
// ),
// ),
// ),
// )
