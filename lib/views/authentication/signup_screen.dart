import 'package:flutter/material.dart';
import '../../utils/reusable components/auth_button.dart';
import '../../utils/reusable components/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                'Sign Up',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              // Subtitle
              const Text(
                'Create your account',
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 32),

              // Name field
              CustomTextField(
                labelText: 'Full Name',
                controller: _nameController,
              ),

              const SizedBox(height: 20),

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

              const SizedBox(height: 20),

              // Confirm Password field
              CustomTextField(
                labelText: 'Confirm Password',
                isPassword: true,
                controller: _confirmPasswordController,
              ),

              const SizedBox(height: 30),

              // Signup Button
              AuthButton(label: 'Sign Up', isLoading: false, onPressed: () {}),

              const SizedBox(height: 20),

              // Login link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Log In',
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
