import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/EhotelAdapter/fetch_customizedproduct.dart';
import 'package:retailerp/Adpater/insert_converteddata.dart';
import 'package:retailerp/models/CutomizedProductModel.dart';
import 'package:retailerp/models/menu_model.dart';
import 'package:retailerp/pages/add_recipe.dart';
import 'package:retailerp/utils/const.dart';

class ConversionPage extends StatefulWidget {
  @override
  _ConversionPageState createState() => _ConversionPageState();
}

class _ConversionPageState extends State<ConversionPage> {

  TextEditingController textEditingController = new TextEditingController();
  FetchCustomizedProduct fetchCustomizedProduct = new FetchCustomizedProduct();
  List<CustoProductModel> cpList = [];
  String prodctPrice;
  InsertConvertedData insertConvertedData = new InsertConvertedData();
  double qty;
  String cproductid;
  String _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
  bool showmsg = false;


  @override
  void initState() {
    _getCPNameList();
  }




  _getCPNameList() async {
    var response = await fetchCustomizedProduct.getCustomizedProduct();
    var productsd = response["CustomizedProductlist"];
    print(productsd.length);
    List<CustoProductModel> cplistTemp = [];
    for (var n in productsd) {
      CustoProductModel pro = CustoProductModel(
          n['CustomizedProductId'],
          n['CustomizedProductName'],
          n['CustomizedProductPrice'],
          n['CustomizedProductDate'],
          n['Productid'],
          n['Productname'],
          n['Productquntity'],
          n['Productcatid']);
      cplistTemp.add(pro);
    }

    setState(() {
      cpList = cplistTemp;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversion"),
      ),
      body:  SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownSearch<CustoProductModel>(
                        items: cpList,
                        // mode: Mode.BOTTOM_SHEET,
                        isFilteredOnline: true,
                        showClearButton: true,
                        showSearchBox: true,
                        label: 'Customize Product',
                        autoValidateMode:
                        AutovalidateMode.onUserInteraction,
                        validator: (CustoProductModel u) => u == null
                            ? "customize product field is required "
                            : null,
                        // onFind: (String filter) => getDatas(),
                        onChanged: (CustoProductModel data) {
                              setState(() {
                                cproductid = data.cpid.toString();
                                prodctPrice = data.cpprice.toString();
                                print("CPID/////////////$cproductid");
                              });
                        },
                      ),
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.plusCircle,
                        color: PrimaryColor,
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return AddRecipe();
                        }));
                    },
                    ),
                    Expanded(
                      child: TextField(
                        obscureText: false,
                        onChanged: (value) {
                          qty = double.parse(value);
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Qty*',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: prodctPrice != null ? Text("Product Price: $prodctPrice") : Text("")
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Visibility(
                  visible: showmsg,
                    child: Text("Error Please try again ...!",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)),
                Material(
                  elevation: 5.0,
                  color: PrimaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                  child: MaterialButton(
                    onPressed: () async {
                      var response = await insertConvertedData.insertedConvertedData(cproductid, _selectdate, qty.toStringAsFixed(2));
                      print("////////////////////////////$response");
                      var resid = response["resid"];
                      if(resid == 200){
                        Navigator.pop(context);
                      }else{
                        setState(() {
                          showmsg = true;
                        });
                      }
                    },
                    minWidth: 150,
                    height: 60.0,
                    child: Text(
                      'Convert',
                      style: btnTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
