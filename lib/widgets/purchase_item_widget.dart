import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/models/purchase_model.dart';
import 'package:retailerp/utils/const.dart';

class PurchaseItemWidget extends StatelessWidget {
  final PurchaseItem purchaseItems;
  Function latestSubTotalAmount;

  PurchaseItemWidget(this.purchaseItems, this.latestSubTotalAmount);
  static const int kTabletBreakpoint = 552;
  @override
  Widget build(BuildContext context) {
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
                      "${purchaseItems.PurchaseProductName}",
                      style: headsTextStyle,
                    ),
                    Text(
                      "Rate: Rs. ${purchaseItems.PurchaseProductRate}  -  Qty: ${purchaseItems.PurchaseProductQty.toString()} -  GST: ${purchaseItems.PurchaseGST.toString()}",
                      style: headsTextStyle,
                    ),
                  ],
                ),
                subtitle: Text(
                  // 'Subtotal Total: \Rs.${(salesItems.SalesProductRate * salesItems.SalesProductQty)}',
                  'Subtotal Total: \Rs.${(purchaseItems.PurchaseProductSubTotal)}',
                  style: headsTextStyle,
                ),
                trailing: IconButton(
                  onPressed: () {
                    Provider.of<PurchaseModel>(context, listen: false)
                        .removeItem(purchaseItems);
                    getsubTotalAmount(cart.totalAmount);
                    print('PRo title : ${purchaseItems.PurchaseProductName}');
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
