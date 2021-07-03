import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/EhotelModel/StockTransfer.dart';
import 'package:retailerp/utils/const.dart';

class StockTranferItemWidget extends StatelessWidget {
  final StockTranfer StockTranferItems;
  final int index;

  StockTranferItemWidget(this.StockTranferItems,this.index);
 // int number=1;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black12,
        child: Consumer<StockTranferProvider>(builder: (context, cart, child) {
          return Card(
            child: Container(
              child: ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   "Product: ${index+1}",
                    //   style: headsubTextStyle,
                    // ),
                    Text(
                      "Product Name: ${StockTranferItems.StockTranferProductName}",
                      style: headsTextStyle,
                    ),
                  ],
                ),
                subtitle: Text(
                  'Product Quntity:${(StockTranferItems.StockTranferProductQty)}',
                  style: headsTextStyle,
                ),
                trailing: IconButton(
                  onPressed: () {
                    Provider.of<StockTranferProvider>(context, listen: false)
                        .removeItem(StockTranferItems);
                   // getsubTotalAmount(cart.totalAmount);
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

  // void getsubTotalAmount(subamount) {
  //   latestSubTotalAmount(subamount);
  // }
}
