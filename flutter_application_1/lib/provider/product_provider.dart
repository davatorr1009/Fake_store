import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/api_services.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    try {
      _products = await ApiServices().fetchProducts();
      notifyListeners();
    } catch (e) {
      print('Error al obtener los productos: $e');
    }
  }  
  void addProduct(Product product){
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _products.remove(product);
    notifyListeners();
  }
}