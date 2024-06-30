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
      print('Error at getting all products $e');
    }
  }  
  void updateProducts(Product newProduct) {
    _products.add(newProduct);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _products.remove(product);
    notifyListeners();
  }
  
}