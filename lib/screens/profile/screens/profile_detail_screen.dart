import 'package:airbnb_cybersoft/models/user_model.dart';
import 'package:airbnb_cybersoft/providers/auth_provider.dart';
import 'package:airbnb_cybersoft/providers/user_provider.dart';
import 'package:airbnb_cybersoft/screens/profile/widgets/edit_bottom_sheet.dart';
import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:airbnb_cybersoft/utils/divider_widget.dart';
import 'package:airbnb_cybersoft/utils/secure_storage.dart';
import 'package:airbnb_cybersoft/utils/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({super.key});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  ThongTinNguoiDung? user;
  String dateTime = '';
  bool _isLoggingOut = false;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    final userProvider = context.read<UserProvider>();
    try {
      final result = await userProvider.getUserInfo(id: userProvider.user.id!);
      if (!mounted) return;
      setState(() {
        user = result.user;
        dateTime = DateTime.parse(result.dateTime).year.toString();
      });
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }
  }

  Future<void> _logout() async {
    if (_isLoggingOut) return;

    final authProvider = context.read<AuthProvider>();

    setState(() => _isLoggingOut = true);
    try {
      await clearToken();
      await clearUserInfo();
      if (!mounted) return;
      Navigator.of(context).pop();
      authProvider.setLogout();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoggingOut = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    user = userProvider.user;
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(16),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                _heading(user!),
                const DividerWidget(),
                normalSvgIcon(
                  assetName: 'assets/icons/detail_room_icon/Verification.svg',
                  color: const Color.fromARGB(255, 12, 101, 15),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Identity verification',
                  style: TextStyle(fontSize: titleFontSize, fontWeight: .bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Show others you\'re really you with the \nidentity verification badge',
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text('Get the badge'),
                  ),
                ),
                const SizedBox(height: 32),
                const Divider(),
                Row(
                  crossAxisAlignment: .start,
                  children: [
                    const Icon(Icons.translate),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: const Text(
                            'Some info is shown in it\'s original language.',
                            maxLines: 2,
                          ),
                        ),

                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Translate',
                            style: TextStyle(decoration: .underline),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Text(
                  'Matt confirmed',
                  style: TextStyle(fontSize: titleFontSize, fontWeight: .bold),
                ),
                const SizedBox(height: 16),
                if (user!.phone != 'string')
                  const Row(
                    children: [
                      Icon(Icons.done),
                      SizedBox(width: 16),
                      Text('Phone number'),
                    ],
                  ),
                const SizedBox(height: 4),
                if (user!.email != 'string')
                  const Row(
                    children: [
                      Icon(Icons.done),
                      SizedBox(width: 16),
                      Text('Email address'),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _heading(ThongTinNguoiDung user) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        CircleAvatar(
          radius: 65,
          backgroundImage: NetworkImage(user.avatar!),
          onBackgroundImageError: (exception, stackTrace) => Container(
            color: Colors.grey,
            child: Icon(Icons.image_not_supported),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          user.name,
          style: const TextStyle(fontSize: headerFontSized, fontWeight: .bold),
        ),
        const SizedBox(height: 8),
        Text('Joined in $dateTime'),
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      leading: BackButton(),
      actions: [
        TextButton(
          onPressed: () {
            _showEditBottomSheet(context);
          },
          child: const Text(
            'Edit',
            style: TextStyle(decoration: .underline, color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: _isLoggingOut ? null : _logout,
          child: const Text(
            'Log out',
            style: TextStyle(decoration: .underline, color: Colors.black),
          ),
        ),
      ],
      actionsPadding: EdgeInsets.only(right: 8),
    );
  }

  void _showEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsetsGeometry.all(16),
          child: EditBottomSheet(user: user!),
        );
      },
    );
  }
}
