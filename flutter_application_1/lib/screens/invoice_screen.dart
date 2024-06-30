import 'package:flutter/material.dart';
//import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/provider/cart_provider.dart';
import 'package:flutter_application_1/screens/products_screen.dart';
import '../provider/product_provider.dart';
import 'package:provider/provider.dart';


class InvoiceScreen extends StatelessWidget {
  final String invoiceCode;
  //List <Product> products = fetchProducts();

  InvoiceScreen({required this.invoiceCode});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items; // Obtener los productos del carrito del provider
    final productProvider = Provider.of<ProductProvider>(context, listen: false);

    double total = 0;
    for (var product in cartItems) { // Usar cartItems para calcular el total
      total += product.price;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Factura'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Código de Factura: $invoiceCode'),
            SizedBox(height: 16),
            Text('Productos:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length, // Usar cartItems.length
                itemBuilder: (context, index) {
                  final product = cartItems[index]; // Usar cartItems[index]
                  return ListTile(
                    title: Text(product.title),
                    trailing: Text('\$${product.price.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            Divider(),
            Text('Total: \$${total.toStringAsFixed(2)}'),
            ElevatedButton( // Botón para finalizar la compra
              onPressed: () {
                cartProvider.clearCart(); // Limpiar el carrito después de confirmar
                Navigator.pushReplacement( // Navegación a ProductsScreen
            context,
            MaterialPageRoute(
               builder: (context) => ProductsScreen(products: productProvider.products),));
              },
              child: Text('Finalizar Compra'),
            ),
          ],
        ),
      ),
    );
  }
}
