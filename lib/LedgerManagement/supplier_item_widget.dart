import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/LedgerManagement/Models/ledgermodel.dart';
import 'package:retailerp/utils/const.dart';

class SupplierItemWidget extends StatelessWidget {
  final Supplier supplierItems;
  final int index;

  SupplierItemWidget(this.supplierItems,this.index);
  // int number=1;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black12,
        child: Consumer<SupplierProvider>(builder: (context, cart, child) {
          return Card(
            child: Container(
              child: ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Licence: ${index+1}",
                      style: headsubTextStyle,
                    ),
                    Text(
                      "Licence Type Name: ${supplierItems.SupplierLicenseType}",
                      style: headsTextStyle,
                    ),
                  ],
                ),
                subtitle: Text(
                  'Licence Number:${(supplierItems.SupplierLicenseName)}',
                  style: headsTextStyle,
                ),
                trailing: IconButton(
                  onPressed: () {
                    Provider.of<SupplierProvider>(context, listen: false)
                        .removeItem(supplierItems);
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


}
