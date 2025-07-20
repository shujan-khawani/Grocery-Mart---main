import 'package:flutter/material.dart';
import 'package:grocery_mart_must_company_flutter_assesement/controllers/nav_bar_controller.dart';
import 'package:grocery_mart_must_company_flutter_assesement/utils/reusable%20components/custom_nav_bar.dart';
import 'package:grocery_mart_must_company_flutter_assesement/views/favorites/favourites.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import '../cart/cart_screen.dart';

class MainTabView extends StatelessWidget {
  const MainTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BottomNavController>(context);
    final List<Widget> tabs = const [
      HomePage(),
      CartScreen(),
      FavouritesPage(),
    ];

    return Scaffold(
      body: IndexedStack(index: controller.currentIndex, children: tabs),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: controller.currentIndex,
        onTap: controller.updateIndex,
        itemCount: tabs.length,
      ),
    );
  }
}
