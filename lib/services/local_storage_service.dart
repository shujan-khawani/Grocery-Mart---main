import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item.dart';

class LocalStorageService {
  static const String cartKey = 'cart_items';

  Future<void> saveCart(List<CartItem> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = jsonEncode(cartItems.map((e) => e.toJson()).toList());
    await prefs.setString(cartKey, cartJson);
  }

  Future<List<CartItem>> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString(cartKey);
    if (cartJson == null) return [];
    final List<dynamic> decoded = jsonDecode(cartJson);
    return decoded.map((e) => CartItem.fromJson(e)).toList();
  }
}
