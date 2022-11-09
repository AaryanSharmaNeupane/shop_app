import 'package:flutter/material.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductsItem extends StatelessWidget {
  //final String id;
  final String title;
  final String imageUrl;
  const UserProductsItem(this.title, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // IconButton(
            //   onPressed: () {
            //     Navigator.of(context)
            //         .pushNamed(EditProductScreen.routeName, arguments: id);
            //   },
            //   icon: const Icon(Icons.edit),
            //   color: Theme.of(context).primaryColor,
            // ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}
