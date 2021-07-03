import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/providers/recipe.dart';

class MobileEditMenuItem extends StatelessWidget {
  final RecipeItems recipeItems;
  Function selEditData;

  MobileEditMenuItem(this.recipeItems, this.selEditData);

  // MobileEditMenuItem(
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
              trailing: Container(
                width: 100.0,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        getRecipe(recipeItems.id, recipeItems.title,
                            recipeItems.quantity, recipeItems);
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.green,
                      ),
                    ),
                    IconButton(
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
                  ],
                ),
              ),
            ),
          );
        }));
  }

  getRecipe(String id, String title, double quantity, recipeItems) {
    selEditData(id, title, quantity, recipeItems);
  }
}
