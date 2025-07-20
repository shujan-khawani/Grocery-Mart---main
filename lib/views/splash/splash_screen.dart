// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:grocery_mart_must_company_flutter_assesement/utils/navigation/elegent_route.dart';
import 'package:grocery_mart_must_company_flutter_assesement/views/authentication/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay for 2 seconds then navigate to Login Page
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, elegantRoute(const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.card_giftcard, size: 80, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              'Grocery Mart',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'online groceries',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
