import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_products_item.dart';
import '../providers/products_provider.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({super.key});
  static const routeName = "/users-products";

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Your Products"), actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(EditProductScreen.routeName);
          },
          icon: const Icon(Icons.add),
        ),
      ]),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
            itemBuilder: ((context, index) => Column(
                  children: [
                    UserProductsItem(productsData.items[index].title,
                        productsData.items[index].imageUrl),
                    const Divider(
                      color: Colors.grey,
                    ),
                  ],
                )),
            itemCount: productsData.items.length),
      ),
    );
  }
}
