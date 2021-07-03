import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/models/sales_model.dart';
import 'package:retailerp/utils/const.dart';

class SalesItemWidget extends StatelessWidget {
  final SalesItem salesItems;
  Function latestSubTotalAmount;

  SalesItemWidget(this.salesItems, this.latestSubTotalAmount);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black12,
        child: Consumer<SalesModel>(builder: (context, cart, child) {
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
                    Text(
                      "Rate: Rs. ${salesItems.SalesProductRate}  -  Qty: ${salesItems.SalesProductQty.toString()} -  GST: ${salesItems.SalesGST.toString()}",
                      style: headsTextStyle,
                    ),
                  ],
                ),
                subtitle: Text(
                  // 'Subtotal Total: \Rs.${(salesItems.SalesProductRate * salesItems.SalesProductQty)}',
                  'Subtotal Total: \Rs.${(salesItems.SalesProductSubTotal)}',
                  style: headsTextStyle,
                ),
                trailing: IconButton(
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
              ),
            ),
          );
        }));
  }

  void getsubTotalAmount(subamount) {
    latestSubTotalAmount(subamount);
  }
}
