import 'dart:convert';
//import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart'; // Importa el modelo de usuario

class ApiServices {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<User?> authenticateUser(String username, String password) async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      final users = jsonList.map((userJson) => User.fromJson(userJson)).toList();

      for (final user in users) {
        if (user.username == username && user.password == password) {
          return user; // Usuario autenticado
        }
      }
    }

    return null; // Credenciales incorrectas
  }

  
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((productJson) => Product.fromJson(productJson)).toList();
    } else {
      throw Exception('Error al obtener los productos');
    }
  }
  Future<Product> addProduct(Product product) async {
    try {
      //ApiServices apiServices = new ApiServices();
      final response = await http.post(
        Uri.parse('$baseUrl/products'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': product.title,
          'price': product.price,
          'description': product.description,
          'image': product.image,
          'category': product.category,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json
         = jsonDecode(response.body);
        return Product.fromJson(json);
      } else {
        throw Exception('Error al agregar el producto: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en addProduct: $e');
      rethrow;
    }
  }
}
   /*Future<List<Product>> fetchCartByUserId(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/carts?userId=$userId')); // Filtrar por userId

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      if (jsonList.isNotEmpty) {
        final Map<String, dynamic> cartData = jsonList[0]; // Toma el primer carrito (suponiendo que solo hay uno por usuario)
        final List<dynamic> productsData = cartData['products'];

        List<Product> cartProducts = [];
        for (var productData in productsData) {
          final productResponse = await http.get(Uri.parse('$baseUrl/products/${productData['productId']}'));
          if (productResponse.statusCode == 200) {
            final productJson = jsonDecode(productResponse.body);
            final product = Product.fromJson(productJson);
            cartProducts.add(product); // Añade el producto al carrito
          } else {
            throw Exception('Error al obtener el producto con ID ${productData['productId']}');
          }
        }

        return cartProducts; // Retorna la lista de productos del carrito
      } else {
        return []; // Si no hay carrito para el usuario, retorna una lista vacía
      }
    } else {
      throw Exception('Error al obtener el carrito del usuario $userId');
    }
}*/


