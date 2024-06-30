import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/cart_provider.dart';
import 'package:flutter_application_1/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart'; 

void main() {
 runApp(
    MultiProvider( // Usar MultiProvider para múltiples providers
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(), 
    );
  }
}
