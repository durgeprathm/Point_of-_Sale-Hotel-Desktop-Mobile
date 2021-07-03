// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:retailerp/helpers/database_helper.dart';
// import 'package:retailerp/models/supplier.dart';
//
//
// import 'Add_purchase.dart';
// import 'Import_purchase.dart';
// import 'Manage_Purchase.dart';
// import 'Manage_Suppliers.dart';
// import 'dashboard.dart';
//
// class BankSupplierDetalis extends StatefulWidget {
//   @override
//   BankSupplierDetalis(this.supplier);
//   final Supplier supplier;
//   _BankSupplierDetalisState createState() => _BankSupplierDetalisState();
// }
//
// class _BankSupplierDetalisState extends State<BankSupplierDetalis> {
//   DatabaseHelper databaseHelper = new DatabaseHelper();
//   SupplierInsert supplierinsert = new  SupplierInsert();
//   @override
//   final _SupplierCompanyBankNametext=TextEditingController();
//   final _SupplierCompanyBankBranchtext=TextEditingController();
//   final _SupplierCompanyAccountTypetext=TextEditingController();
//   final _SupplierCompanyAccountNumbertext=TextEditingController();
//   final _SupplierCompanyAccountIFSCtext=TextEditingController();
//   final _SupplierCompanyUPINumbertext=TextEditingController();
//
//
//
//   bool _SupplierCompanyBankNamevalidate=false;
//   bool _SupplierCompanyBankBranchvalidate=false;
//   bool _SupplierCompanyAccountTypevalidate=false;
//   bool _SupplierCompanyAccountNumbervalidate=false;
//   bool _SupplierCompanyAccountIFSCvalidate=false;
//   bool _SupplierCompanyUPINumbervalidate=false;
//
//
//
//   String SupplierCompanyBankName;
//   String SupplierCompanyBankBranch;
//   String SupplierCompanyAccountType;
//   String SupplierCompanyAccountNumber;
//   String SupplierCompanyIFSC;
//   String SupplierCompanyUPINumber;
//   Widget build(BuildContext context) {
//      void handleClick(String value) {
//     //     switch (value) {
//     //       case 'Add Purchase':
//     //         Navigator.push(
//     //             context, MaterialPageRoute(builder: (context) => AddPurchase()));
//     //         break;
//     //       case 'Manage Purchase':
//     //         Navigator.push(context,
//     //             MaterialPageRoute(builder: (context) => Managepurchase()));
//     //         break;
//     //       case 'Import Purchase':
//     //         Navigator.push(context,
//     //             MaterialPageRoute(builder: (context) => ImportPurchase()));
//     //         break;
//     //       case 'Manage Suppliers':
//     //         Navigator.push(context,
//     //             MaterialPageRoute(builder: (context) => ManageSuppliers()));
//     //         break;
//     //     }
//      }
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Row(
//           children: [
//             FaIcon(FontAwesomeIcons.user),
//             SizedBox(
//               width: 20.0,
//             ),
//             Text('Add Supplier'),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.home, color: Colors.white),
//             onPressed: () {
//               Navigator.of(context).push(MaterialPageRoute(builder: (_) {
//                 return RetailerHomePage();
//               }));
//             },
//           ),
//           PopupMenuButton<String>(
//             onSelected: handleClick,
//             itemBuilder: (BuildContext context) {
//               return {
//                 'Add Purchase',
//                 'Manage Purchase',
//                 'Import Purchase',
//                 'Manage Suppliers',
//               }.map((String choice) {
//                 return PopupMenuItem<String>(
//                   value: choice,
//                   child: Text(choice),
//                 );
//               }).toList();
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
// //-------------------------------------------------------------
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Material(
//                 shape: Border.all(color: Colors.blueGrey, width: 5),
//                 child: Column(children: [
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Material(
//                       color: Colors.blueGrey,
//                       child: Padding(
//                         padding: const EdgeInsets.all(15.0),
//                         child: Text(
//                           'Supplier Bank Account Information',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20.0,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: TextField(
//                       controller:  _SupplierCompanyBankNametext,
//                       obscureText: false,
//                       onChanged: (value) {
//                          SupplierCompanyBankName=value;
//                       },
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Supplier Bank Name',
//                         errorText: _SupplierCompanyBankNamevalidate ? 'Enter Supplier Bank Name' : null,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: TextField(
//                       controller: _SupplierCompanyBankBranchtext,
//                       obscureText: false,
//                       onChanged: (value) {
//                            SupplierCompanyBankBranch=value;
//                       },
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Supplier Bank Branch Name',
//                           errorText: _SupplierCompanyBankBranchvalidate ? 'Enter Supplier Bank Branch Name' : null,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     // child: TextField(
//                     //   obscureText: false,
//                     //   decoration: InputDecoration(
//                     //     border: OutlineInputBorder(),
//                     //     labelText: 'Supplier Account Type',
//                     //   ),
//                     // ),
//                     child: DropdownSearch(
//                       items: ["Current", "Saving"],
//                       label: "Supplier Company Account Type",
//                       onChanged: (value) {
//                          SupplierCompanyAccountType=value;
//                       },
//                       validator: (String item) {
//                         if (item == null)
//                           return "Required field";
//                         else if (item == "Brazil")
//                           return "Invalid item";
//                         else
//                           return null;
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: TextField(
//                       controller: _SupplierCompanyAccountNumbertext,
//                       obscureText: false,
//                       onChanged: (value) {
//                         SupplierCompanyAccountNumber=value;
//                       },
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Supplier Account Number',
//                         errorText: _SupplierCompanyAccountNumbervalidate ? 'Enter Supplier Account Number' : null,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: TextField(
//                       controller: _SupplierCompanyAccountIFSCtext,
//                       obscureText: false,
//                       onChanged: (value) {
//                         SupplierCompanyIFSC=value;
//                       },
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Supplier Bank IFSC Code',
//                         errorText: _SupplierCompanyAccountIFSCvalidate ? 'Enter Supplier Bank IFSC Code' : null,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: TextField(
//                       controller: _SupplierCompanyUPINumbertext,
//                       obscureText: false,
//                       onChanged: (value) {
//                           SupplierCompanyUPINumber=value;
//                       },
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Supplier UPI Number',
//                          errorText: _SupplierCompanyUPINumbervalidate ? 'Enter Supplier UPI Number' : null,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                     EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
//                     child: Material(
//                       color: Colors.blueGrey,
//                       borderRadius: BorderRadius.circular(10.0),
//                       child: MaterialButton(
//                         onPressed:() async {
//                           if (SupplierCompanyBankName == null ||
//                               SupplierCompanyBankBranch == null ||
//                               SupplierCompanyAccountNumber == null ||
//                               SupplierCompanyAccountType == null ||
//                               SupplierCompanyIFSC == null ||
//                               SupplierCompanyUPINumber == null ) {
//                             _SupplierCompanyBankNametext.text.isEmpty
//                                 ? _SupplierCompanyBankNamevalidate = true
//                                 : _SupplierCompanyBankNamevalidate = false;
//                             _SupplierCompanyBankBranchtext.text.isEmpty
//                                 ? _SupplierCompanyBankBranchvalidate = true
//                                 : _SupplierCompanyBankBranchvalidate = false;
//                             _SupplierCompanyAccountTypetext.text.isEmpty
//                                 ? _SupplierCompanyAccountTypevalidate = true
//                                 : _SupplierCompanyAccountTypevalidate = false;
//                             _SupplierCompanyAccountNumbertext.text.isEmpty
//                                 ? _SupplierCompanyAccountNumbervalidate = true
//                                 : _SupplierCompanyAccountNumbervalidate = false;
//                             _SupplierCompanyAccountIFSCtext.text.isEmpty
//                                 ? _SupplierCompanyAccountIFSCvalidate = true
//                                 : _SupplierCompanyAccountIFSCvalidate = false;
//                             _SupplierCompanyUPINumbertext.text.isEmpty
//                                 ? _SupplierCompanyUPINumbervalidate = true
//                                 : _SupplierCompanyUPINumbervalidate = false;
//                           } else {
//                             print(SupplierCompanyBankName);
//                             print(SupplierCompanyBankBranch);
//                             print(SupplierCompanyAccountType);
//                             print(SupplierCompanyAccountNumber);
//                             print(SupplierCompanyIFSC);
//                             print(SupplierCompanyUPINumber);
//                             Supplier supplier = new Supplier.copyWith(
//                                 widget.supplier.SupplierComapanyName,
//                                 widget.supplier.SupplierComapanyPersonName,
//                                 widget.supplier.SupplierMobile,
//                                 widget.supplier.SupplierMobile,
//                                 widget.supplier.SupplierAddress,
//                                 widget.supplier.SupplierUdyogAadhar,
//                                 widget.supplier.SupplierCINNumber,
//                                 widget.supplier.SupplierGSTType,
//                                 widget.supplier.SupplierGSTNumber,
//                                 widget.supplier.SupplierFAXNumber,
//                                 widget.supplier.SupplierPANNumber,
//                                 widget.supplier.SupplierLicenseType,
//                                 widget.supplier.SupplierLicenseName,
//                                 SupplierCompanyBankName,
//                                 SupplierCompanyBankBranch,
//                                 SupplierCompanyAccountType,
//                                 SupplierCompanyAccountNumber,
//                                 SupplierCompanyIFSC,
//                                 SupplierCompanyUPINumber);
//                             var res = await databaseHelper.insertSupplier(supplier);
//                             //insert data in server
//                             var result=await supplierinsert.getpossupplierinsert(
//                                 widget.supplier.SupplierComapanyName,
//                                 widget.supplier.SupplierComapanyPersonName,
//                                 widget.supplier.SupplierMobile,
//                                 widget.supplier.SupplierMobile,
//                                 widget.supplier.SupplierAddress,
//                                 widget.supplier.SupplierUdyogAadhar,
//                                 widget.supplier.SupplierCINNumber,
//                                 widget.supplier.SupplierGSTType,
//                                 widget.supplier.SupplierGSTNumber,
//                                 widget.supplier.SupplierFAXNumber,
//                                 widget.supplier.SupplierPANNumber,
//                                 widget.supplier.SupplierLicenseType,
//                                 widget.supplier.SupplierLicenseName,
//                                 SupplierCompanyBankName,
//                                 SupplierCompanyBankBranch,
//                                 SupplierCompanyAccountType,
//                                 SupplierCompanyAccountNumber,
//                                 SupplierCompanyIFSC,
//                                 SupplierCompanyUPINumber
//                             );
//                             print("/////result /////$result");
//                             if ( result == null) {
//                               _showMyDialog('Filed !', Colors.red);
//                             } else {
//                               _showMyDialog(
//                                   'Data Save Successfully!', Colors.green);
//                               print("//////in purchase////////$res");
//                             }
//                           }
//                         },
//                         minWidth: 100.0,
//                         height: 35.0,
//                         child: Text(
//                           'Add Supplier Details',
//                           style: TextStyle(color: Colors.white, fontSize: 20.0),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ]),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   Future<void> _showMyDialog(String msg, Color col) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return SingleChildScrollView(
//           child: AlertDialog(
//             title: Text(
//               msg,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: col,
//               ),
//             ),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: <Widget>[],
//               ),
//             ),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
