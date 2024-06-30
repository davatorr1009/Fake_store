import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/cart_provider.dart';
import 'package:flutter_application_1/screens/invoice_screen.dart';
import 'package:provider/provider.dart';



class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.remove_shopping_cart, size: 64),
                  SizedBox(height: 16),
                  Text('Your cart is empty'),
                ],
              ),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = cartItems[index];
                return ListTile(
                  leading: Image.network(
                    product.image,
                    width: 50,
                    height: 50,
                  ),
                  title: Text(product.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Precio: \$${product.price.toStringAsFixed(2)}'),
                      Text('Quantity: 1'), // Asume que se agrega 1 unidad por defecto
                    ],
                  ),
                  trailing: IconButton( // Botón de eliminar
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      cartProvider.removeProduct(product); // Eliminar el producto del carrito
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Product deleted from the cart')),
                      );
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('\$${cartProvider.calculateTotal().toStringAsFixed(2)}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (cartItems.isNotEmpty) {
                final invoiceCode = generateInvoiceCode();
                Navigator.push( // Usar el contexto correcto
                  context,
                  MaterialPageRoute(
                    builder: (context) => InvoiceScreen(invoiceCode: invoiceCode),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Cart is empty')),
                );
              }
            },
        child: Icon(Icons.receipt),
      ),
    );
  }

String generateInvoiceCode() {
    
    final random = Random();
    return 'INV-${random.nextInt(10000)}';
  }
}