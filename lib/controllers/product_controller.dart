import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends ChangeNotifier {
  final List<Category> categories = [
    Category(id: 'all', name: 'All', icon: Icons.grid_view, color: Colors.grey),
    Category(
      id: 'fruits',
      name: 'Fruits',
      icon: Icons.apple,
      color: Colors.green,
    ),
    Category(
      id: 'vegetables',
      name: 'Vegetables',
      icon: Icons.eco,
      color: Colors.lightGreen,
    ),

    Category(
      id: 'snacks',
      name: 'Snacks',
      icon: Icons.fastfood,
      color: Colors.orange,
    ),
    Category(
      id: 'households',
      name: 'Households',
      icon: Icons.ac_unit,
      color: Colors.cyan,
    ),
  ];

  final List<Product> _allProducts = [
    Product(
      id: '1',
      name: 'Organic Bananas',
      price: 4.99,
      image: 'assets/images/banana.png',
      description: 'Fresh organic bananas.',
      category: 'fruits',
      stock: 7,
    ),
    Product(
      id: '2',
      name: 'Naturel Red Apple',
      price: 4.99,
      image: 'assets/images/apple.png',
      description: 'Nutritious red apples.',
      category: 'fruits',
      stock: 10,
    ),
    Product(
      id: '3',
      name: 'Coffee Jar',
      price: 4.99,
      image: 'assets/images/coffee.png',
      description: 'Refreshing Coca Cola.',
      category: 'all',
      stock: 20,
    ),
    Product(
      id: '4',
      name: 'Sugar',
      price: 1.50,
      image: 'assets/images/sugar.png',
      description: 'Sweetness.',
      category: 'households',
      stock: 15,
    ),
    // Vegetables
    Product(
      id: '5',
      name: 'Honey',
      price: 2.99,
      image: 'assets/images/honey.png',
      description: 'Fresh honey straight from the hive.',
      category: 'households',
      stock: 12,
    ),
    Product(
      id: '6',
      name: 'Salt',
      price: 3.49,
      image: 'assets/images/salt.png',
      description: 'Himalyan salt for cooking.',
      category: 'households',
      stock: 8,
    ),
    Product(
      id: '7',
      name: 'Cucumber',
      price: 2.49,
      image: 'assets/images/cucumber.png',
      description: 'Cucumbers straight from the farm.',
      category: 'vegetables',
      stock: 20,
    ),
    Product(
      id: '8',
      name: 'onion',
      price: 5.99,
      image: 'assets/images/onion.png',
      description: 'Onions for your salads and dishes.',
      category: 'vegetables',
      stock: 10,
    ),
    Product(
      id: '9',
      name: 'Potato',
      price: 2.99,
      image: 'assets/images/potato.png',
      description: 'Fresh Potatoes.',
      category: 'vegetables',
      stock: 15,
    ),
    Product(
      id: '10',
      name: 'Tomato',
      price: 1.99,
      image: 'assets/images/tomato.png',
      description: 'Fresh Onions.',
      category: 'vegetables',
      stock: 18,
    ),
    Product(
      id: '11',
      name: 'Mango',
      price: 2.49,
      image: 'assets/images/mango.png',
      description: 'Sweet and juicy mangoes.',
      category: 'fruits',
      stock: 25,
    ),
    Product(
      id: '12',
      name: 'Lays',
      price: 1.29,
      image: 'assets/images/dairy milk.png',
      description: 'Crispy potato chips.',
      category: 'snacks',
      stock: 30,
    ),
    Product(
      id: '13',
      name: 'Dairy Milk',
      price: 6.99,
      image: 'assets/images/dairy milk.png',
      description: 'Delicious chocolate bar.',
      category: 'snacks',
      stock: 10,
    ),
  ];

  // --- FAVORITES LOGIC ---
  final Set<String> _favoriteProductIds = {};

  ProductController() {
    _filteredProducts = List.from(_allProducts);
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favIds = prefs.getStringList('favoriteProductIds') ?? [];
    _favoriteProductIds.clear();
    _favoriteProductIds.addAll(favIds);
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'favoriteProductIds',
      _favoriteProductIds.toList(),
    );
  }

  void toggleFavorite(String productId) {
    if (_favoriteProductIds.contains(productId)) {
      _favoriteProductIds.remove(productId);
    } else {
      _favoriteProductIds.add(productId);
    }
    _saveFavorites();
    notifyListeners();
  }

  bool isFavorite(String productId) => _favoriteProductIds.contains(productId);

  List<Product> get favoriteProducts =>
      _allProducts.where((p) => _favoriteProductIds.contains(p.id)).toList();

  List<Product> _filteredProducts = [];
  String _searchQuery = '';
  String _selectedCategory = 'all';

  List<Product> get products => _filteredProducts;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;

  void search(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void filterByCategory(String categoryId) {
    _selectedCategory = categoryId;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredProducts = _allProducts.where((product) {
      final matchesCategory =
          _selectedCategory == 'all' || product.category == _selectedCategory;
      final matchesSearch =
          _searchQuery.isEmpty ||
          product.name.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
    notifyListeners();
  }

  Product? getProductById(String id) {
    try {
      return _allProducts.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
}
