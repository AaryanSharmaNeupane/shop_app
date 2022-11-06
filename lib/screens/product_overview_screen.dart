import 'package:flutter/material.dart';
import 'package:shop_app/widgets/product_item.dart';

import '../models/product.dart';

class ProductOverviewScreen extends StatelessWidget {
  final List<Product> loadedProduct = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
    Product(
      id: 'p5',
      title: 'Audi',
      description: 'Fastest Thing alive!',
      price: 88888,
      imageUrl:
          'https://cdni.autocarindia.com/utils/imageresizer.ashx?n=https://cms.haymarketindia.net/model/uploads/modelimages/Audi-A5-Sportback-120420212020.jpg&w=350&h=251&q=90&c=1',
    ),
    Product(
      id: 'p6',
      title: 'Football',
      description: 'Just roll it!',
      price: 9.99,
      imageUrl:
          'https://cdn.shopify.com/s/files/1/0712/4751/products/SMA-01_400x.jpg?v=1629409085',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rustu's"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1 / 1.5,
            crossAxisSpacing: 15,
            mainAxisSpacing: 13,
            crossAxisCount: 2),
        itemCount: loadedProduct.length,
        itemBuilder: (context, index) => ProductItem(
            loadedProduct[index].id,
            loadedProduct[index].title,
            loadedProduct[index].imageUrl,
            loadedProduct[index].price),
      ),
    );
  }
}
