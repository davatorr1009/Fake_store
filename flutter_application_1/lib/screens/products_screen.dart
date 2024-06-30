import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/product_provider.dart';
import 'package:flutter_application_1/screens/add_product_screen.dart';
import 'package:flutter_application_1/screens/cart_screen.dart';
import 'package:flutter_application_1/screens/products_detail_screen.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import '../models/globals.dart'; 

class ProductsScreen extends StatefulWidget {
  final List<Product> products;

  ProductsScreen({required this.products});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  //List<Product> _products = [];

 @override
  void initState() {
  super.initState();
  Provider.of<ProductProvider>(context, listen: false).fetchProducts(); // Cargar productos al inicio
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
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
       body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          final products = productProvider.products;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                onTap: () { Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(product: product),),
                  ); },
                leading: Container(
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage( // Usa CachedNetworkImage directamente
                      imageUrl: product.image,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                title: Text(product.title),
                subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
