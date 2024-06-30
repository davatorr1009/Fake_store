import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Elimina la sombra de la AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Flecha de retroceso negra
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card( // Utiliza un Card para contener los detalles del producto
            elevation: 2, // Agrega una ligera sombra al Card
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagen del producto
                  Image.network(
                    product.image,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 16),
                  // Nombre del producto
                  Text(
                    product.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  // Precio del producto
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),
                  // Descripción del producto
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton( // Botón flotante "Add to Cart"
        onPressed: () {
          Provider.of<CartProvider>(context, listen: false).addProduct(product);
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product added to the cart')),
          );
        },
        backgroundColor: Colors.black, // Color de fondo del botón
        child: Icon(Icons.add_shopping_cart, color: Colors.white), // Ícono blanco
      ),
    );
  }
}



