import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items => _items;

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
  double calculateTotal() {
    double total = 0;
    for (var item in _items) {
      total += item.price; 
    }
    return total;
  }
  
}
