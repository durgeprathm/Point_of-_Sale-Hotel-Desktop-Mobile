import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/LedgerManagement/Models/ledgermodel.dart';
import 'package:retailerp/providers/recipe.dart';
import 'package:retailerp/utils/const.dart';

class SupplierCartItem extends StatelessWidget {
  final Supplier supplierItem;

  SupplierCartItem(this.supplierItem);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black12,
        child: Consumer<Recipe>(builder: (context, cart, child) {
          return Card(
            margin: EdgeInsets.symmetric(
              horizontal: 2,
              vertical: 2,
            ),
            child: Padding(
              padding: EdgeInsets.all(1),
              child: ListTile(
                leading: CircleAvatar(
                  child: Padding(
                    padding: EdgeInsets.all(1),
                  ),
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Supplier License Type:',style: hintListTextStyle,),
                    Text(
                        '${supplierItem.SupplierLicenseType}'),
                  ],
                ),
                subtitle: Text(
                    'Supplier License Name: ${supplierItem.SupplierLicenseName}'),
                trailing: IconButton(
                  onPressed: () {
                    Provider.of<SupplierProvider>(context, listen: false)
                        .removeItem(supplierItem);
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

// return
// Dismissible(
// key: ValueKey(id),
// background: Container(
//   color: Theme.of(context).errorColor,
//   child: Icon(
//     Icons.delete,
//     color: Colors.white,
//     size: 40,
//   ),
//   alignment: Alignment.centerRight,
//   padding: EdgeInsets.only(right: 20),
//   margin: EdgeInsets.symmetric(
//     horizontal: 15,
//     vertical: 4,
//   ),
// ),
// direction: DismissDirection.endToStart,
// confirmDismiss: (direction) {
//   return showDialog(
//     context: context,
//     builder: (ctx) => AlertDialog(
//       title: Text('Are you sure?'),
//       content: Text(
//         'Do you want to remove the item from the cart?',
//       ),
//       actions: <Widget>[
//         FlatButton(
//           child: Text('No'),
//           onPressed: () {
//             Navigator.of(ctx).pop(false);
//           },
//         ),
//         FlatButton(
//           child: Text('Yes'),
//           onPressed: () {
//             Navigator.of(ctx).pop(true);
//           },
//         ),
//       ],
//     ),
//   );
// },
// onDismissed: (direction) {
//   Provider.of<Recipe>(context, listen: false).removeItem(productId);
// },
//     Container(
//   color: Colors.black12,
//   child: Card(
//     margin: EdgeInsets.symmetric(
//       horizontal: 15,
//       vertical: 4,
//     ),
//     child: Padding(
//       padding: EdgeInsets.all(8),
//       child: ListTile(
//         leading: CircleAvatar(
//           child: Padding(
//             padding: EdgeInsets.all(5),
//           ),
//         ),
//         title: Text(title),
//         subtitle: Text('Qty: ${quantity}'),
//         trailing: IconButton(
//           onPressed: () {
//             Provider.of<Recipe>(context, listen: false)
//                 .removeItem(productId);
//           },
//           icon: Icon(
//             Icons.delete,
//             color: Colors.red,
//           ),
//         ),
//       ),
//     ),
//   ),
// );
// );
}
