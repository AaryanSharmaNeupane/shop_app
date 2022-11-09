import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    void productDetail() {
      Navigator.of(context)
          .pushNamed(ProductDetailScreen.routeName, arguments: product.id);
    }

    return InkWell(
      onTap: productDetail,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          header: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: Icon(product.isFavourite
                  ? Icons.favorite
                  : Icons.favorite_outline_outlined),
              onPressed: () {
                product.toggleIsFavouriteStatus();
              },
              color: Theme.of(context).secondaryHeaderColor,
            ),
            title: Text(
              "\$${product.price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 12,
                overflow: TextOverflow.fade,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                var snackBar = SnackBar(
                  content: const Text("Added to the cart!"),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                      label: "UNDO",
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      }),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
