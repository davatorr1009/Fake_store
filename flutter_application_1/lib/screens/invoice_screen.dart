import 'package:flutter/material.dart';
//import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/provider/cart_provider.dart';
//import 'package:flutter_application_1/screens/products_screen.dart';
//import '../provider/product_provider.dart';
import 'package:provider/provider.dart';


class InvoiceScreen extends StatelessWidget {
  final String invoiceCode;
  //List <Product> products = fetchProducts();

  InvoiceScreen({required this.invoiceCode});

   @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;

    double total = 0;
    for (var product in cartItems) {
      total += product.price; // Calcula el total
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Details'), // Título de la AppBar
        backgroundColor: Colors.white, // Color de fondo blanco
        elevation: 0, // Sin sombra
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Flecha de retroceso negra
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección de información de la factura
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Fondo gris claro
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$${total.toStringAsFixed(2)}', // Muestra el total
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Due:'),
                      Text('Invoice #:'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(' Sept 30, 2024'), // Fecha de vencimiento (puedes personalizar)
                      Text(invoiceCode), // Número de factura
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            // Sección de productos
            Text(
              'Products:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final product = cartItems[index];
                  return ListTile(
                    leading: Image.network(
                    product.image,
                    width: 40, // Ajusta el tamaño de la imagen
                    height: 40,),
                    title: Text(product.title),
                    trailing: Text('\$${product.price.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            SizedBox(height: 24),
            // Botón
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[400], // Color de fondo púrpura
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                onPressed: () {
                  cartProvider.clearCart();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Confirm Payment',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}