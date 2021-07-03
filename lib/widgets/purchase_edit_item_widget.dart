import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/models/purchase_model.dart';
import 'package:retailerp/utils/const.dart';

class PurchaseEditItemWidget extends StatelessWidget {
  final PurchaseItem purchaseItems;
  Function latestSubTotalAmount;
  Function selEditData;

  PurchaseEditItemWidget(
      this.purchaseItems, this.latestSubTotalAmount, this.selEditData);

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
                        "${purchaseItems.PurchaseProductName}",
                        style: headsTextStyle,
                      ),
                      shortestSide > kTabletBreakpoint
                          ? Text(
                              "Rate: Rs. ${purchaseItems.PurchaseProductRate}  -  Qty: ${purchaseItems.PurchaseProductQty.toString()} -  GST: ${purchaseItems.PurchaseGST.toString()}",
                              style: headsTextStyle,
                            )
                          : Text(
                              "Rate: Rs. ${purchaseItems.PurchaseProductRate}  -  Qty: ${purchaseItems.PurchaseProductQty.toString()}\nGST: ${purchaseItems.PurchaseGST.toString()}",
                              style: headsTextStyle,
                            ),
                    ],
                  ),
                  subtitle: Text(
                    // 'Subtotal Total: \Rs.${(salesItems.SalesProductRate * salesItems.SalesProductQty)}',
                    'Subtotal Total: \Rs.${(purchaseItems.PurchaseProductSubTotal)}',
                    style: headsTextStyle,
                  ),
                  trailing: Container(
                    width: 100.0,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            getPurPorduct(
                                purchaseItems.Purchaseid,
                                purchaseItems.PurchaseProductName,
                                purchaseItems.PurchaseProductRate,
                                purchaseItems.PurchaseGST,
                                purchaseItems.PurchaseProductQty,
                                purchaseItems.PurchaseProductSubTotal,
                                purchaseItems);
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Provider.of<PurchaseModel>(context, listen: false)
                                .removeItem(purchaseItems);
                            getsubTotalAmount(cart.totalAmount);
                            print(
                                'PRo title : ${purchaseItems.PurchaseProductName}');
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
      String proSubTotal, PurchaseItem purchaseItem) {
    selEditData(proId, productName, productRate, proGST, productQty,
        proSubTotal, purchaseItem);
  }
}
