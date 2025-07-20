// ignore_for_file: unused_element, unused_element_parameter, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final int itemCount;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      bottom: true,
      child: Material(
        elevation: 0, // No elevation for a simple look
        color: colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ), // More spacious
          child: GNav(
            selectedIndex: currentIndex,
            onTabChange: onTap,
            tabBorderRadius: 18,
            gap: 8, // More gap between icon and text
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ), // Larger padding
            color: Colors.grey.shade400, // Softer unselected color
            activeColor: colorScheme.primary,
            tabBackgroundColor: colorScheme.primary.withOpacity(
              0.12,
            ), // More vibrant active background
            backgroundColor: Colors.transparent,
            rippleColor: colorScheme.primary.withOpacity(0.12), // Ripple effect
            hoverColor: colorScheme.primary.withOpacity(0.08), // Hover effect
            iconSize: 28, // Slightly larger icons
            curve: Curves.easeOutExpo, // Smooth animation
            duration: const Duration(milliseconds: 500), // Smoother transition
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: colorScheme.primary,
              letterSpacing: 0.2,
            ),
            tabs: [
              GButton(icon: Icons.home, text: 'Shop'),
              GButton(text: 'Cart', icon: Icons.shopping_cart),
              GButton(icon: Icons.favorite, text: 'Favorite'),
            ].sublist(0, itemCount),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final bool selected;
  final ValueChanged<int> onTap;
  final bool showBadge;
  final int badgeCount;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.selected,
    required this.onTap,
    this.showBadge = false,
    this.badgeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  size: selected ? 26 : 24,
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
                ),
                if (showBadge)
                  Positioned(
                    right: -6,
                    top: -6,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Center(
                        child: Text(
                          '$badgeCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            FittedBox(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: selected ? 12.5 : 11,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
