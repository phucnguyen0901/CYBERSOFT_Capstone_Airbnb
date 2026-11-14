import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Image.asset(
                  'assets/logo/app_logo.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Welcome to',
                  style: TextStyle(fontSize: titleFontSize),
                ),
                const Text(
                  'Airbnb Cybersoft',
                  style: TextStyle(
                    fontSize: headerFontSized,
                    fontWeight: .bold,
                    // color: primaryColor,
                  ),
                ),
                const SizedBox(height: 48),
                InkWell(
                  onTap: () {
                    _bottomSheetModal(context, isSignin: true);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: primaryColor),
                      color: primaryColor,
                    ),
                    padding: const EdgeInsetsGeometry.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    child: const Text(
                      'Sign in to continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: .bold,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 80,
                    vertical: 8,
                  ),
                  child: Divider(),
                ),
                const Text(
                  'Don\'t have an account?',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {
                    _bottomSheetModal(context, isSignin: false);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(),
                    ),
                    padding: const EdgeInsetsGeometry.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    child: const Text(
                      'Sign up for today',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: .bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _bottomSheetModal(BuildContext context, {required bool isSignin}) {
    String label = (isSignin) ? 'Sign in' : 'Sign up';
    showModalBottomSheet(
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsetsGeometry.all(16),
          child: Column(
            children: [
              Center(
                child: Text(label, style: TextStyle(fontSize: titleFontSize)),
              ),
              const SizedBox(height: 32, child: Divider()),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: primaryColor),
                    color: primaryColor,
                  ),
                  padding: const EdgeInsetsGeometry.symmetric(vertical: 16),
                  child: Center(
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: .bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
