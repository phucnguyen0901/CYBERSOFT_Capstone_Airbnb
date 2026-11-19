// import 'package:airbnb_cybersoft/models/login_model.dart';
import 'package:airbnb_cybersoft/providers/auth_provider.dart';
import 'package:airbnb_cybersoft/providers/user_provider.dart';
import 'package:airbnb_cybersoft/screens/profile/register_widgets/auth_bottom_sheet.dart';
import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                        _bottomSheetModal(context, AuthMode.signIn);
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
                        _bottomSheetModal(context, AuthMode.signUp);
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

  void _bottomSheetModal(BuildContext context, AuthMode mode) {
    showModalBottomSheet<void>(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: AuthBottomSheet(
            mode: mode,
            onSubmit: (data) {
              return _handleAuth(context, data);
            },
          ),
        );
      },
    );
  }

  Future<void> _handleAuth(BuildContext context, AuthFormData data) async {
    final authProvider = context.read<AuthProvider>();
    final userProvider = context.read<UserProvider>();

    final session = switch (data.mode) {
      AuthMode.signIn => await authProvider.signIn(
        email: data.email,
        password: data.password,
      ),
      AuthMode.signUp => await authProvider.signUp(
        name: data.name,
        email: data.email,
        password: data.password,
        phone: data.phone,
      ),
    };

    userProvider.loadUser(session.user);
    authProvider.setLogin(session.token);
  }
}
