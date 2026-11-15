import 'package:airbnb_cybersoft/providers/auth_provider.dart';
import 'package:airbnb_cybersoft/providers/user_provider.dart';
import 'package:airbnb_cybersoft/services/auth_service.dart';
import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:airbnb_cybersoft/utils/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cfPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String token = '';

  Future<void> hanleSignin() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    authProvider.setLoading(true);

    try {
      final result = await AuthService.signin(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      final token = result.content.token;
      final userData = result.content.user;

      await saveUserInfo(token: token, user: userData);

      authProvider.setLoading(false);
      userProvider.loadUser(userData);
      authProvider.setLogin(token);
    } catch (error) {
      authProvider.setLoading(false);
      throw Exception('Error when signin: $error');
    }
  }

  Future<void> handleSignup() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    var signupData = {
      'name': _userNameController.text.trim(),
      'email': _emailController.text.trim(),
      'password': _passwordController.text.trim(),
      'phone': _phoneController.text.trim(),
    };
    authProvider.setLoading(true);

    try {
      final success = await AuthService.signup(signupData);
      if (success) {
        debugPrint('Signup successful');
        await hanleSignin();
      } else {
        debugPrint('Signup failed');
      }
      authProvider.setLoading(false);
    } catch (error) {
      authProvider.setLoading(false);
      throw Exception('Error when signup: $error');
    }
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _cfPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: SvgPicture.asset(
                  'assets/icons/navbar_icon/app_icon.svg',
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 48),
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
                        padding: const EdgeInsets.symmetric(
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
                      padding: EdgeInsets.symmetric(
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
                        padding: const EdgeInsets.symmetric(
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
          ],
        ),
      ),
    );
  }

  void _bottomSheetModal(BuildContext context, {required bool isSignin}) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _bottomSheetHeader(isSignin: isSignin),
              const SizedBox(height: 48, child: Divider()),
              Column(
                spacing: 16,
                children: [
                  if (!isSignin) _userNameTextField(),
                  if (!isSignin) _phoneTextField(),
                  _emailTexField(),
                  _passwordTextField(),
                  if (!isSignin) _confirmPassword(),
                ],
              ),
              const SizedBox(height: 48),
              _sendReqButton(isSignin: isSignin),
            ],
          ),
        );
      },
    );
  }

  Row _bottomSheetHeader({required bool isSignin}) {
    String label = (isSignin) ? 'Sign in' : 'Sign up';
    return Row(
      children: [
        const SizedBox(width: 40),
        Expanded(
          child: Center(
            child: Text(label, style: const TextStyle(fontSize: titleFontSize)),
          ),
        ),
        SizedBox(
          width: 40,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.close_rounded),
          ),
        ),
      ],
    );
  }

  TextField _userNameTextField() {
    return TextField(
      controller: _userNameController,
      decoration: InputDecoration(
        labelText: 'Your name',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  TextField _phoneTextField() {
    return TextField(
      controller: _phoneController,
      decoration: InputDecoration(
        labelText: 'Phone number',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  TextField _emailTexField() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  TextField _passwordTextField() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  TextFormField _confirmPassword() {
    return TextFormField(
      controller: _cfPasswordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Confirm password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  InkWell _sendReqButton({required bool isSignin}) {
    return InkWell(
      onTap: () {
        if (isSignin) {
          hanleSignin();
        } else {
          handleSignup();
        }
        Navigator.of(context).pop();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: primaryColor),
          color: primaryColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
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
    );
  }
}
