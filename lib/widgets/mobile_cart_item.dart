import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/providers/recipe.dart';

class MobileCartItem extends StatelessWidget {
  // final String id;
  // final String productId;
  // final double quantity;
  // final String title;
  final RecipeItems recipeItems;

  MobileCartItem(this.recipeItems);

  // MobileCartItem(
  //   this.id,
  //   this.productId,
  //   this.quantity,
  //   this.title,
  // );

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
            child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  padding: EdgeInsets.all(5),
                ),
              ),
              title: Text(recipeItems.title),
              subtitle: Text('Qty: ${recipeItems.quantity}'),
              trailing: IconButton(
                onPressed: () {
                  Provider.of<Recipe>(context, listen: false)
                      .deleteTask(recipeItems);
                  print('PRo title : ${recipeItems.id}');
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          );
        }));
  }

}
