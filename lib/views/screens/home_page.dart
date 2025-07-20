// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:grocery_mart_must_company_flutter_assesement/utils/navigation/elegent_route.dart';
import 'package:provider/provider.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../utils/reusable components/product_card.dart';
import '../../utils/reusable components/category_card.dart';
import 'product_detail_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../controllers/nav_bar_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);
    final cartController = Provider.of<CartController>(context);
    final List<String> carouselImages = [
      'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1519864600265-abb23847ef2c?auto=format&fit=crop&w=800&q=80',
    ];
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            elevation: 0,
            title: const Text(
              'GroceryMart',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            actions: [
              Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      // Switch to cart tab instead of pushing a new screen
                      Provider.of<BottomNavController>(
                        context,
                        listen: false,
                      ).updateIndex(1);
                    },
                    icon: const Icon(Icons.shopping_cart_outlined),
                  ),
                  if (cartController.totalItems > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cartController.totalItems}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.88,
                  aspectRatio: 16 / 9,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                ),
                items: carouselImages.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.10),
                              blurRadius: 12,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return Container(
                                color: Colors.grey[200],
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: progress.expectedTotalBytes != null
                                        ? progress.cumulativeBytesLoaded /
                                              (progress.expectedTotalBytes ?? 1)
                                        : null,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  color: Colors.grey[200],
                                  child: const Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      size: 40,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _buildSearchBar(context, productController),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: _buildCategoriesSection(context, productController),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: const Text(
                'Featured Products',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final screenHeight = MediaQuery.of(context).size.height;
                  final gridHeight =
                      screenHeight * 0.52; // Responsive height for grid
                  return SizedBox(
                    height: gridHeight,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.72,
                          ),
                      itemCount: productController.products.length,
                      itemBuilder: (context, index) {
                        final product = productController.products[index];
                        return ProductCard(
                          product: product,
                          onAddToCart: () =>
                              cartController.addToCart(product.id),
                          onTap: () {
                            Navigator.push(
                              context,
                              elegantRoute(
                                ProductDetailScreen(productId: product.id),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }

  Widget _buildSearchBar(
    BuildContext context,
    ProductController productController,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(16),
        shadowColor: Colors.black12,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search for products...',
            prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 26),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear, color: Colors.grey, size: 22),
              onPressed: () {
                productController.search('');
                FocusScope.of(context).unfocus();
              },
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1.5,
              ),
            ),
            filled: true,
            fillColor: Colors.grey[100],
          ),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          onChanged: (value) => productController.search(value),
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(
    BuildContext context,
    ProductController productController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 104,
          child: ListView.builder(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: productController.categories.length,
            itemBuilder: (context, index) {
              final category = productController.categories[index];
              return CategoryCard(
                category: category,
                isSelected: productController.selectedCategory == category.id,
                onTap: () => productController.filterByCategory(category.id),
              );
            },
          ),
        ),
      ],
    );
  }
}
