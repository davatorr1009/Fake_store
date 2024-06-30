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
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
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
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              // Título del producto
              Text(
                product.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              // Precio del producto
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              // Categoría del producto
              Text(
                'Categoría: ${product.category}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              // Descripción del producto
              Text(
                'Descripción:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(product.description),
              
              ElevatedButton( // Botón para agregar al carrito
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false).addProduct(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Producto agregado al carrito')),
                  );
                },
                child: Text('Agregar al Carrito'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



