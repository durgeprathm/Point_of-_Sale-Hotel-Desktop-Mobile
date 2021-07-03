import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/models/purchase_model.dart';
import 'package:retailerp/models/sales_model.dart';
import 'package:retailerp/utils/const.dart';

class SalesEditItemWidget extends StatelessWidget {
  final SalesItem salesItems;
  Function latestSubTotalAmount;
  Function selEditData;

  SalesEditItemWidget(
      this.salesItems, this.latestSubTotalAmount, this.selEditData);

  static const int kTabletBreakpoint = 552;

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    return Container(
        color: Colors.black12,
        child: Consumer<PurchaseModel>(builder: (context, cart, child) {
          return Card(
            child: Container(
              child: ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${salesItems.SalesProductName}",
                        style: headsTextStyle,
                      ),
                      shortestSide > kTabletBreakpoint
                          ? Text(
                              "Rate: Rs. ${salesItems.SalesProductRate}  -  Qty: ${salesItems.SalesProductQty.toString()} -  GST: ${salesItems.SalesGST.toString()}",
                              style: headsTextStyle,
                            )
                          : Text(
                              "Rate: Rs. ${salesItems.SalesProductRate}  -  Qty: ${salesItems.SalesProductQty.toString()}\nGST: ${salesItems.SalesGST.toString()}",
                              style: headsTextStyle,
                            )
                    ],
                  ),
                  subtitle: Text(
                    // 'Subtotal Total: \Rs.${(salesItems.SalesProductRate * salesItems.SalesProductQty)}',
                    'Subtotal Total: \Rs.${(salesItems.SalesProductSubTotal)}',
                    style: headsTextStyle,
                  ),
                  trailing: Container(
                    width: 100.0,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            getPurPorduct(
                                salesItems.Salesid,
                                salesItems.SalesProductName,
                                salesItems.SalesProductRate,
                                salesItems.SalesGST,
                                salesItems.SalesProductQty,
                                salesItems.SalesProductSubTotal,
                                salesItems);
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Provider.of<SalesModel>(context, listen: false)
                                .removeItem(salesItems);
                            getsubTotalAmount(cart.totalAmount);
                            print('PRo title : ${salesItems.SalesProductName}');
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          );
        }));
  }

  void getsubTotalAmount(subamount) {
    latestSubTotalAmount(subamount);
  }

  void getPurPorduct(proId, productName, productRate, proGST, productQty,
      String proSubTotal, SalesItem salesItems) {
    selEditData(proId, productName, productRate, proGST, productQty,
        proSubTotal, salesItems);
  }
}
