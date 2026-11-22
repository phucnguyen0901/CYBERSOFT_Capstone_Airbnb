import 'package:airbnb_cybersoft/models/user_model.dart';
import 'package:airbnb_cybersoft/providers/user_provider.dart';
import 'package:airbnb_cybersoft/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditBottomSheet extends StatefulWidget {
  const EditBottomSheet({super.key, required this.user});
  final ThongTinNguoiDung user;

  @override
  State<EditBottomSheet> createState() => _EditBottomSheetState();
}

class _EditBottomSheetState extends State<EditBottomSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _birthdayController;
  late final String _currentAvatar;
  late bool? _gender;

  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  @override
  void initState() {
    _currentAvatar = widget.user.avatar!;
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone);
    _birthdayController = TextEditingController(text: widget.user.birthday);
    _gender = widget.user.gender;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  Future<void> _edit() async {
    if (_isSubmitting || !(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      final userProvider = context.read<UserProvider>();
      await userProvider.updateUserInfo(
        id: userProvider.user.id!,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        birthday: _birthdayController.text.trim(),
        gender: _gender!,
        role: userProvider.user.role,
      );
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (err) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(err.toString())));
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
        _header(context),
        const Divider(),
        _avatar(),
        const SizedBox(height: 32),
        Form(
          key: _formKey,
          child: Column(
            children: [
              _buildEditTile(
                label: 'Name',
                validator: requiredValidator,
                controller: _nameController,
              ),
              const SizedBox(height: 16, child: Divider()),
              _buildEditTile(
                label: 'Email',
                controller: _emailController,
                validator: (input) =>
                    input!.isValidEmail() ? null : 'Check your email again!',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16, child: Divider()),
              _buildEditTile(
                label: 'Phone',
                validator: requiredValidator,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16, child: Divider()),
              _buildEditTile(
                label: 'Birthday',
                validator: requiredValidator,
                controller: _birthdayController,
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 16, child: Divider()),
              _selectGender(),
              const SizedBox(height: 16, child: Divider()),
            ],
          ),
        ),
      ],
    );
  }

  Row _header(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close),
        ),
        const Expanded(
          child: Center(
            child: Text('Edit profile', style: TextStyle(fontWeight: .bold)),
          ),
        ),
        TextButton(
          onPressed: () => _edit(),
          child: const Text(
            'Save',
            style: TextStyle(decoration: .underline, color: Colors.black),
          ),
        ),
      ],
    );
  }

  SizedBox _avatar() {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: CircleAvatar(
          radius: 100,
          backgroundImage: NetworkImage(_currentAvatar),
          onBackgroundImageError: (exception, stackTrace) {
            Container(
              color: Colors.grey,
              child: Icon(Icons.image_not_supported),
            );
          },
        ),
      ),
    );
  }

  SizedBox _buildEditTile({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType? keyboardType = TextInputType.text,
  }) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Text(label),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              validator: validator,
              textAlign: .end,
              style: TextStyle(fontWeight: .bold),
              decoration: InputDecoration(
                border: .none,
                contentPadding: EdgeInsets.zero,
              ),
              errorBuilder: (context, errorText) => Align(
                alignment: .bottomEnd,
                heightFactor: 0,
                child: Text(errorText),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _selectGender() {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          const Text('Gender'),
          Expanded(child: const SizedBox()),
          RadioGroup(
            groupValue: _gender,
            onChanged: (newValue) {
              setState(() {
                _gender = newValue;
              });
            },
            child: Row(
              children: [
                Radio(value: true),
                const Text('Male'),
                const SizedBox(width: 16),
                Radio(value: false),
                const Text('Female'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
