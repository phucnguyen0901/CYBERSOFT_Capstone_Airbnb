import 'package:airbnb_cybersoft/models/user_model.dart';
import 'package:airbnb_cybersoft/providers/user_provider.dart';
import 'package:airbnb_cybersoft/screens/profile/screens/profile_detail_screen.dart';
import 'package:airbnb_cybersoft/screens/profile/widgets/activity_list_view.dart';
import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:airbnb_cybersoft/utils/divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              const SizedBox(height: 16),
              _header(user),
              const DividerWidget(),
              Padding(
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
                child: const Text(
                  'Activity',
                  style: TextStyle(fontSize: titleFontSize),
                ),
              ),
              const SizedBox(height: 16),
              const ActivityListView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(ThongTinNguoiDung user) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          const SizedBox(height: 16),
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(user.avatar!),
            onBackgroundImageError: (exception, stackTrace) => Container(
              color: Colors.grey,
              child: Icon(Icons.image_not_supported),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user.name,
            style: const TextStyle(
              fontSize: headerFontSized,
              fontWeight: .bold,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: const Text(
              'View profile',
              style: TextStyle(
                decoration: .underline,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfileDetailScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
