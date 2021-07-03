import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddBankDetails extends StatefulWidget {
  @override
  _AddBankDetailsState createState() => _AddBankDetailsState();
}

class _AddBankDetailsState extends State<AddBankDetails> {
  @override

  final _Banknametext = TextEditingController();
  final _BankBranchtext = TextEditingController();
  final _BankAccountNotext = TextEditingController();
  final _BankIFSCcodetext = TextEditingController();
  final _BankAccountTypetext = TextEditingController();
  final _UPINumbertext = TextEditingController();


  bool _Banknamevalidate = false;
  bool _BankBranchvalidate = false;
  bool _BankAccountNovalidate = false;
  bool _BankIFSCcodevalidate = false;
  bool _BankAccountTypevalidate = false;
  bool _UPINumbervalidate = false;


  String Bankname;
  String BankBranch;
  String BankAccountNo;
  String BankIFSCcode;
  String BankAccountType;
  String UPINumber;
  // SupplierInsert supplierinsert = new  SupplierInsert();


  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        // Supplier Account Details
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Material(
            shape: Border.all(color: Colors.blueGrey, width: 5),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _Banknametext,
                            obscureText: false,
                            onChanged: (value) {
                              Bankname=value;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Supplier Bank Name',
                              errorText: _Banknamevalidate ? 'Enter Bank Name' : null,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _BankBranchtext,
                            obscureText: false,
                            onChanged: (value) {
                              BankBranch=value;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Supplier Bank Branch Name',
                              errorText: _BankBranchvalidate ? 'Enter Bank Branch Name' : null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _BankAccountNotext,
                            obscureText: false,
                            onChanged: (value) {
                              BankAccountNo=value;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Supplier Account Number',
                              errorText: _BankAccountNovalidate ? 'Enter Account Number' : null,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _BankIFSCcodetext,
                            obscureText: false,
                            onChanged: (value) {
                              BankIFSCcode=value;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Supplier Bank IFSC Code',
                              errorText: _BankIFSCcodevalidate ? 'Enter IFSC Code' : null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          // child: TextField(
                          //   obscureText: false,
                          //   decoration: InputDecoration(
                          //     border: OutlineInputBorder(),
                          //     labelText: 'Supplier Account Type',
                          //   ),
                          // ),
                          child: DropdownSearch(
                            items: ["Current", "Saving"],
                            label: "Supplier Company license Type",

                            onChanged: print,
                            // selectedItem: "Tunisia",
                            validator: (String item) {
                              if (item == null)
                                return "Required field";
                              else if (item == "Brazil")
                                return "Invalid item";
                              else
                                return null;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _UPINumbertext,
                            obscureText: false,
                            onChanged: (value) {
                              UPINumber=value;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Supplier UPI Number',
                              errorText: _UPINumbervalidate ? 'Enter UPI Number' : null,
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

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Material(
            child: FlatButton(
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black12),
              ),
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  if(Bankname == null || BankBranch == null || BankAccountNo == null || BankIFSCcode == null || UPINumber == null )
                  {
                    _Banknametext.text.isEmpty ? _Banknamevalidate = true : _Banknamevalidate = false;
                    _BankBranchtext.text.isEmpty ? _BankBranchvalidate = true : _BankBranchvalidate = false;
                    _BankAccountNotext.text.isEmpty ? _BankAccountNovalidate = true : _BankAccountNovalidate = false;
                    _BankIFSCcodetext.text.isEmpty ? _BankIFSCcodevalidate = true : _BankIFSCcodevalidate = false;
                    _UPINumbertext.text.isEmpty ? _UPINumbervalidate = true : _UPINumbervalidate = false;
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                // child: FaIcon(FontAwesomeIcons.arrowRight),
                child: Text(
                  "Add Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
