import 'package:flutter/material.dart';
import 'package:grocery_mart_must_company_flutter_assesement/views/screens/main_tab_view.dart';
import 'package:grocery_mart_must_company_flutter_assesement/utils/navigation/elegent_route.dart';
import 'package:grocery_mart_must_company_flutter_assesement/utils/reusable%20components/auth_button.dart';
import 'package:grocery_mart_must_company_flutter_assesement/utils/reusable%20components/custom_text_field.dart';
import 'package:grocery_mart_must_company_flutter_assesement/views/authentication/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.store,
                  size: MediaQuery.of(context).size.height * 0.1,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 40),

              // Title
              const Text(
                'Login',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              // Subtitle
              const Text(
                'Enter your email and password',
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 32),

              // Email field
              CustomTextField(
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),

              const SizedBox(height: 20),

              // Password field
              CustomTextField(
                labelText: 'Password',
                isPassword: true,
                controller: _passwordController,
              ),

              const SizedBox(height: 10),

              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Login Button
              AuthButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    elegantRoute(const MainTabView()),
                  );
                },
                label: 'Log In',
              ),

              const SizedBox(height: 20),

              // Sign up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        elegantRoute(const SignupScreen()),
                      );
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
