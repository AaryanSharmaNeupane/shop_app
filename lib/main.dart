import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopify',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        secondaryHeaderColor: Colors.deepOrange,
        fontFamily: "Lato",
      ),
      debugShowCheckedModeBanner: false,
      home: ProductOverviewScreen(),
    );
  }
}
