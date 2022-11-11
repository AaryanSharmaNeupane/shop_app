import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

import 'product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
    // Product(
    //   id: 'p5',
    //   title: 'Audi',
    //   description: 'Fastest Thing alive!',
    //   price: 88888,
    //   imageUrl:
    //       'https://cdni.autocarindia.com/utils/imageresizer.ashx?n=https://cms.haymarketindia.net/model/uploads/modelimages/Audi-A5-Sportback-120420212020.jpg&w=350&h=251&q=90&c=1',
    // ),
    // Product(
    //   id: 'p6',
    //   title: 'Football',
    //   description: 'Just roll it!',
    //   price: 9.99,
    //   imageUrl:
    //       'https://cdn.shopify.com/s/files/1/0712/4751/products/SMA-01_400x.jpg?v=1629409085',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouriteOnly {
    return _items.where((prod) => prod.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndGet() async {
    const url =
        "https://shop-app-571d7-default-rtdb.asia-southeast1.firebasedatabase.app/products.json";
    final response = await http.get(Uri.parse(url));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<Product> loadedProduct = [];
    extractedData.forEach((prodId, prodData) {
      loadedProduct.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl']));
    });
    _items = loadedProduct;
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    const url =
        "https://shop-app-571d7-default-rtdb.asia-southeast1.firebasedatabase.app/products.json";
    final response = await http.post(Uri.parse(url),
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavourite': product.isFavourite,
        }));

    final newProduct = Product(
        id: json.decode(response.body)['name'],
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        title: product.title);
    _items.insert(0, newProduct);
    notifyListeners();
  }

  // void updateProduct(String id, Product newProduct) {
  //   final prodIndex = items.indexWhere((prod) => prod.id == id);
  //   if (prodIndex >= 0) {
  //     items[prodIndex] = newProduct;
  //     notifyListeners();
  //   }
  // }
}
