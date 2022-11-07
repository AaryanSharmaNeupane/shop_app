import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import './product_item.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products = productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1 / 1.5,
          crossAxisSpacing: 15,
          mainAxisSpacing: 13,
          crossAxisCount: 2),
      itemCount: products.length,
      itemBuilder: (context, index) => ProductItem(
          products[index].id,
          products[index].title,
          products[index].imageUrl,
          products[index].price),
    );
  }
}
