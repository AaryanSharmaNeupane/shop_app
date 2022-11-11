import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});
  static const routeName = "/edit_screen";

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final imageUrlController = TextEditingController();
  final form = GlobalKey<FormState>();
  //var isInit = true;

  var isLoading = false;

  var editedProduct = Product(
    id: 'apple',
    title: '',
    description: '',
    price: 0.0,
    imageUrl: '',
  );

  var initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  void saveForm() {
    final isValid = form.currentState!.validate();
    if (!isValid) return;
    form.currentState!.save();
    setState(() {
      isLoading = true;
    });

    // if (editedProduct.id != 'apple') {
    //   Provider.of<ProductsProvider>(context, listen: false)
    //       .updateProduct(editedProduct.id, editedProduct);
    // } else {
    Provider.of<ProductsProvider>(context, listen: false)
        .addProduct(editedProduct)
        .then((_) {
      Navigator.of(context).pop();
      setState(() {
        isLoading = false;
      });
    });
    //}
  }

  // @override
  // void didChangeDependencies() {
  //   if (isInit) {
  //     final productId = ModalRoute.of(context)?.settings.arguments;
  //     if (productId != null) {
  //       editedProduct = Provider.of<ProductsProvider>(context)
  //           .findById(productId as String);
  //       initValues = {
  //         'title': editedProduct.title,
  //         'price': editedProduct.price.toString(),
  //         'description': editedProduct.description,
  //         'imageUrl': '',
  //       };
  //       imageUrlController.text = editedProduct.imageUrl;
  //     }
  //   }
  //   isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
        actions: [
          IconButton(
            onPressed: saveForm,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: form,
                child: ListView(
                  children: [
                    TextFormField(
                      // initialValue: initValues['title'],
                      decoration: const InputDecoration(labelText: "Title"),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        if (newValue != null) {
                          editedProduct = Product(
                            id: editedProduct.id,
                            title: newValue,
                            description: editedProduct.description,
                            price: editedProduct.price,
                            imageUrl: editedProduct.imageUrl,
                            isFavourite: editedProduct.isFavourite,
                          );
                        } else {
                          return;
                        }
                      },
                    ),
                    TextFormField(
                        // initialValue: initValues['price'],
                        decoration: const InputDecoration(labelText: "Price"),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter price';
                          }
                          if (double.tryParse(value) == null) {
                            return "Please enter valid number";
                          }
                          if (double.parse(value) <= 0) {
                            return "Enter number greater than 0";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          newValue != null
                              ? editedProduct = Product(
                                  id: editedProduct.id,
                                  title: editedProduct.title,
                                  description: editedProduct.description,
                                  price: double.parse(newValue),
                                  imageUrl: editedProduct.imageUrl,
                                  isFavourite: editedProduct.isFavourite,
                                )
                              : null;
                        }),
                    TextFormField(
                        // initialValue: initValues['description'],
                        decoration:
                            const InputDecoration(labelText: "Description"),
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          newValue != null
                              ? editedProduct = Product(
                                  id: editedProduct.id,
                                  title: editedProduct.title,
                                  description: newValue,
                                  price: editedProduct.price,
                                  imageUrl: editedProduct.imageUrl,
                                  isFavourite: editedProduct.isFavourite,
                                )
                              : null;
                        }),
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: Container(
                            child: imageUrlController.text.isEmpty
                                ? const Text("Enter a Url")
                                : FittedBox(
                                    child: Image.network(
                                      imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration:
                                const InputDecoration(labelText: "Image URL"),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: imageUrlController,
                            enableInteractiveSelection: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter url';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              newValue != null
                                  ? editedProduct = Product(
                                      id: editedProduct.id,
                                      title: editedProduct.title,
                                      description: editedProduct.description,
                                      price: editedProduct.price,
                                      imageUrl: newValue,
                                      isFavourite: editedProduct.isFavourite,
                                    )
                                  : null;
                            },
                            onFieldSubmitted: (_) {
                              saveForm();
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
