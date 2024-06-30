import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/cart_screen.dart';
import 'package:flutter_application_1/screens/products_detail_screen.dart';
import '../models/product.dart';
//import '../models/globals.dart'; 

class ProductsScreen extends StatefulWidget {
  final List<Product> products;

  ProductsScreen({required this.products});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _products = widget.products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: product),
                ),
              );
            },
            leading: Image.network(product.image),
            title: Text(product.title),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}
