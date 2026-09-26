import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  List<CartItem> get itemList => _items.values.toList();

  int get totalItemCount {
    int count = 0;
    for (final item in _items.values) {
      count += item.quantity;
    }
    return count;
  }

  double get subtotal {
    double total = 0;
    for (final item in _items.values) {
      total += item.totalPrice;
    }
    return total;
  }

  double get discount {
    return subtotal > 2000 ? subtotal * 0.10 : 0;
  }

  double get finalTotal {
    return subtotal - discount;
  }

  bool get isEmpty => _items.isEmpty;

  void addToCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity++;
    } else {
      _items[product.id] = CartItem(product: product);
    }
    notifyListeners();
  }

  void increaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      _items[productId]!.quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      if (_items[productId]!.quantity > 1) {
        _items[productId]!.quantity--;
      } else {
        _items.remove(productId);
      }
      notifyListeners();
    }
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
