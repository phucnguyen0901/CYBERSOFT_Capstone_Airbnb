import 'package:airbnb_cybersoft/models/user_model.dart';
import 'package:airbnb_cybersoft/providers/user_provider.dart';
import 'package:airbnb_cybersoft/utils/secure_storage.dart';
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

  bool _gender = true;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone);
    _birthdayController = TextEditingController(text: widget.user.birthday);
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

  void _edit() async {
    final userProvider = context.read<UserProvider>();
    await userProvider.updateUserInfo(
      id: userProvider.user.id!,
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      birthday: _birthdayController.text.trim(),
      gender: _gender,
      role: userProvider.user.role,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Edit profile',
                  style: TextStyle(fontWeight: .bold),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _edit();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Save',
                style: TextStyle(decoration: .underline, color: Colors.black),
              ),
            ),
          ],
        ),
        const Divider(),
        const SizedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: CircleAvatar(backgroundColor: Colors.grey, radius: 80),
          ),
        ),
        const SizedBox(height: 16),
        _buildEditTile('Name', _nameController),
        const SizedBox(height: 16, child: Divider()),
        _buildEditTile('Email', _emailController),
        const SizedBox(height: 16, child: Divider()),
        _buildEditTile('Phone', _phoneController),
        const SizedBox(height: 16, child: Divider()),
        _buildEditTile('Birthday', _birthdayController),
        const SizedBox(height: 16, child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              SizedBox(width: 80, child: Text('Gender')),
              const SizedBox(width: 8),
            ],
          ),
        ),
        const SizedBox(height: 16, child: Divider()),
      ],
    );
  }

  Row _buildEditTile(String label, TextEditingController? controller) {
    return Row(
      children: [
        SizedBox(width: 80, child: Text(label)),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: TextFormField(
            controller: controller,
            textAlign: .end,
            style: TextStyle(fontWeight: .bold),
            decoration: InputDecoration(border: .none),
          ),
        ),
      ],
    );
  }
}
