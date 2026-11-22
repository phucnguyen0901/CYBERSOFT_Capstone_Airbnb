import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:airbnb_cybersoft/utils/validation.dart';
import 'package:flutter/material.dart';

enum AuthMode { signIn, signUp }

class AuthBottomSheet extends StatefulWidget {
  const AuthBottomSheet({
    super.key,
    required this.mode,
    required this.onSubmit,
  });

  final AuthMode mode;
  final Future<void> Function(AuthFormData data) onSubmit;

  @override
  State<AuthBottomSheet> createState() => _AuthBottomSheetState();
}

class _AuthBottomSheetState extends State<AuthBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cfPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isSubmitting = false;

  bool get _isSignUp => widget.mode == AuthMode.signUp;

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _cfPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_isSubmitting || !(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      await widget.onSubmit(
        AuthFormData(
          mode: widget.mode,
          name: _userNameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          phone: _phoneController.text.trim(),
        ),
      );
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        const SizedBox(height: 32, child: Divider()),
        Form(
          key: _formKey,
          child: Column(
            spacing: 16,
            children: [
              if (_isSignUp)
                _buildTextField(
                  controller: _userNameController,
                  label: 'Your name',
                  validator: requiredValidator,
                ),
              if (_isSignUp)
                _buildTextField(
                  controller: _phoneController,
                  keyboardType: .phone,
                  label: 'Phone number',
                  validator: requiredValidator,
                ),
              _buildTextField(
                controller: _emailController,
                keyboardType: .emailAddress,
                label: 'Email',
                validator: (input) =>
                    input!.isValidEmail() ? null : 'Check your email again!',
              ),
              _buildTextField(
                controller: _passwordController,
                label: 'Password',
                obscureText: true,
                validator: requiredValidator,
              ),
              if (_isSignUp)
                _buildTextField(
                  controller: _cfPasswordController,
                  label: 'Confirm password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value.trim() != _passwordController.text.trim()) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: _isSubmitting ? null : _submit,
            style: FilledButton.styleFrom(
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: _isSubmitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text('Continue'),
          ),
        ),
      ],
    );
  }

  Row _buildHeader() {
    final title = _isSignUp ? 'Sign up' : 'Sign in';
    return Row(
      children: [
        const SizedBox(width: 48),
        Expanded(
          child: Center(
            child: Text(title, style: const TextStyle(fontSize: titleFontSize)),
          ),
        ),
        SizedBox(
          width: 48,
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close_rounded),
          ),
        ),
      ],
    );
  }

  TextFormField _buildTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    TextInputType keyboardType = .text,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class AuthFormData {
  const AuthFormData({
    required this.mode,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  final AuthMode mode;
  final String name;
  final String email;
  final String password;
  final String phone;
}
