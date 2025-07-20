import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../services/local_storage_service.dart';

class CartController extends ChangeNotifier {
  final LocalStorageService _storageService = LocalStorageService();
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  CartController() {
    loadCart();
  }

  Future<void> loadCart() async {
    _items = await _storageService.loadCart();
    notifyListeners();
  }

  Future<void> addToCart(String productId) async {
    final index = _items.indexWhere((item) => item.productId == productId);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(productId: productId, quantity: 1));
    }
    await _storageService.saveCart(_items);
    notifyListeners();
  }

  Future<void> removeFromCart(String productId) async {
    _items.removeWhere((item) => item.productId == productId);
    await _storageService.saveCart(_items);
    notifyListeners();
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    final index = _items.indexWhere((item) => item.productId == productId);
    if (index >= 0) {
      _items[index].quantity = quantity;
      if (quantity <= 0) {
        _items.removeAt(index);
      }
      await _storageService.saveCart(_items);
      notifyListeners();
    }
  }

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  void clearCart() async {
    _items.clear();
    await _storageService.saveCart(_items);
    notifyListeners();
  }
}
