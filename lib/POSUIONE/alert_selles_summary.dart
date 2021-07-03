import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retailerp/Adpater/EhotelAdapter/fetch_dailycalculation.dart';
import 'package:retailerp/Const/constcolor.dart';
import 'package:retailerp/models/product_summary.dart';
import 'package:retailerp/utils/const.dart';


class AlertSellsSummary extends StatefulWidget {

  @override
  _AlertSellsSummaryState createState() => _AlertSellsSummaryState();
}

class _AlertSellsSummaryState extends State<AlertSellsSummary> {
  List<ProductSummary> searchProductSummaryList;
  FetchDailyCalculation fetchDailyCalculation = new FetchDailyCalculation();
  String totalCashSum,totalCardSum,totalUPISum;
  String todayscashbill,todayscardbill,todaysUPIbill,TotalBill;
  String _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
  double conversionamt,realtotalbill;


  String UPIModeNameHash, UPIModeCountHash;
  List<String> UPIModeNameArray = [];
  List<String> UPIModeCountArray = [];


  String CardModeNameHash, CardModeCountHash;
  List<String> CardModeNameArray = [];
  List<String> CardModeCountArray = [];



  static const amtTestStyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.blueGrey);

  Future<void> _getDilyCalculation() async {
    var response = await fetchDailyCalculation.getdailyCalculation(_selectdate);

    var totalCashSumTemp = response["totalCashSum"];
    var totalCardSumTemp = response["totalCardSum"];
    var totalUPISumTemp = response["totalUPISum"];

    var todayscashBillTemp = response["todayscashbill"];
    var todayscardBillTemp = response["todayscardbill"];
    var todaysUPIBillTemp = response["todaysUPIbill"];
    var TotalBillTemp = response["totalAmount"];

    UPIModeNameHash = response["UPISubPaymentModeName"].toString();
    UPIModeCountHash = response["UPISubPaymentModeCount"].toString();

    CardModeNameHash  = response["CardSubPaymentModeName"].toString();
    CardModeCountHash  = response["CardSubPaymentModeCount"].toString();

    print(response);

    setState(() {
      totalCashSum = totalCashSumTemp.toString();
      totalCardSum = totalCardSumTemp.toString();
      totalUPISum = totalUPISumTemp.toString();

      realtotalbill = double.parse(totalCashSumTemp.toString()) + double.parse(totalCardSumTemp.toString()) + double.parse(totalUPISumTemp.toString());
      conversionamt = double.parse(TotalBillTemp.toString()) - realtotalbill;


      todayscashbill = todayscashBillTemp.toString();
      todayscardbill = todayscardBillTemp.toString();
      todaysUPIbill = todaysUPIBillTemp.toString();
      TotalBill =  TotalBillTemp.toString();

      UPIModeNameArray = UPIModeNameHash.split("#");
      UPIModeCountArray = UPIModeCountHash.split("#");

      CardModeNameArray = CardModeNameHash.split("#");
      CardModeCountArray = CardModeCountHash.split("#");

    });
    }

  @override
  void initState() {
    _getDilyCalculation();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Sales Summary",
                style: tableColmTextStyle,
              ),
              SizedBox(width: 20,),
            ],
          ),
          Row(
            children: [
              FlatButton(
                child: Text('Close', style: labelCloseTextStyle),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Container(
          // width: MediaQuery.of(context).size.width - 50,
          // height: MediaQuery.of(context).size.height - 80,
          // padding: EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: TotalBill != null ? Text("Total Sale: $Rupees ${realtotalbill.toString()}" , style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.blueGrey,
                    fontSize: 18
                ),) :Text("") ,
              ),
              Divider(
                height: 3,
                thickness: 0.5,
                color: PrimaryColor,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Material(
                        elevation: 2,
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Text("CASH",style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16
                                ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: todayscashbill != null ? Text("Total: ${todayscashbill.toString()}",style: amtTestStyle,): Text(""),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: totalCashSum !=null ? Text("Amount: $Rupees ${totalCashSum.toString()}",style: amtTestStyle): Text(""),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Material(
                        elevation: 2,
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Text("Pay By Card",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 16
                                ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: todayscardbill!=null ? Text("Total: ${todayscardbill.toString()}",style: amtTestStyle,): Text(""),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child:totalCardSum!=null ? Text("Amount: $Rupees ${totalCardSum.toString()}",style: amtTestStyle,): Text(""),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Material(
                        elevation: 2,
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Text("UPI",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 16
                                ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: todaysUPIbill != null ? Text("Total: ${todaysUPIbill.toString()}",style: amtTestStyle,) : Text(""),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: totalUPISum != null ? Text("Amount: $Rupees ${totalUPISum.toString()}",style: amtTestStyle,): Text(""),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Material(
                        elevation: 2,
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Text("Conversion",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 16
                                ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: totalCashSum !=null ? Text("",style: amtTestStyle): Text(""),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: totalCashSum !=null ? Text("Amount: $Rupees ${conversionamt.toString()}",style: amtTestStyle): Text(""),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                height: 3,
                thickness: 0.5,
                color: PrimaryColor,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: totalCardSum !=null ? Text("Pay By Card: $Rupees ${totalCardSum.toString()}",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.blueGrey,
                    fontSize: 18
                ),) : Text("0"),
              ),
              todayscardbill != "0" ?
              DataTable(
                  columns: [
                    DataColumn(
                        label: Expanded(
                          child: Container(
                            child: Text('Sr No',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        )),
                    DataColumn(
                        label: Expanded(
                          child: Container(
                            child: Text('Mode Name',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        )
                    ),
                    DataColumn(
                        label: Expanded(
                          child: Container(
                            child: Text('Total',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        )
                    ),
                    DataColumn(
                        label: Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              child: Text('Amount',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        )
                    ),
                  ],
                  rows: getProductSummaryDataRowListCard()
              ) : Text(""),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 3,
                thickness: 0.5,
                color: PrimaryColor,
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: totalUPISum !=null ? Text("UPI: $Rupees ${totalUPISum.toString()}",style: TextStyle(
                fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                    fontStyle: FontStyle.italic,
                    fontSize: 18
                ),) : Text("0"),
              ),
              todaysUPIbill != "0" ?  DataTable(
          columns: [
            DataColumn(
                label: Expanded(
                  child: Container(
                    child: Text('Sr No',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                )),
            DataColumn(
                label: Expanded(
                  child: Container(
                    child: Text('Mode Name',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                )
            ),
            DataColumn(
                label: Expanded(
                  child: Container(
                    child: Text('Total',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                )
            ),
            DataColumn(
                label: Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Text('Amount',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                )
            ),
          ],
            rows: getProductSummaryDataRowList()
        ) : Text(""),
            ],
          ),
        ),
      ),
    );
  }

  List<DataRow> getProductSummaryDataRowListCard() {
    List<DataRow> myTempDataRow = List();
    for (int i = 0; i < CardModeNameArray.length; i++) {
      myTempDataRow.add(getProdctSummaryRowCard(i));
    }
    return myTempDataRow;
  }

  DataRow getProdctSummaryRowCard(int index) {
    var serNo = index + 1;
    return DataRow(cells: [
      DataCell(Center(child: Text(serNo.toString()))),
      DataCell(Text(CardModeNameArray[index])),
      DataCell(Center(child: Text(CardModeCountArray[index]))),
      DataCell(Align(
          alignment: Alignment.centerRight,
          child: Text(CardModeCountArray[index].toString()))),
    ]);
  }



  List<DataRow> getProductSummaryDataRowList() {
    List<DataRow> myTempDataRow = List();
    for (int i = 0; i < UPIModeNameArray.length; i++) {
      myTempDataRow.add(getProdctSummaryRow(i));
    }
    return myTempDataRow;
  }

  DataRow getProdctSummaryRow(int index) {
    var serNo = index + 1;
    return DataRow(cells: [
      DataCell(Center(child: Text(serNo.toString()))),
      DataCell(Text(UPIModeNameArray[index])),
      DataCell(Center(child: Text(UPIModeCountArray[index]))),
      DataCell(Align(
        alignment: Alignment.centerRight,
          child: Text(UPIModeCountArray[index].toString()))),
    ]);
  }
}
