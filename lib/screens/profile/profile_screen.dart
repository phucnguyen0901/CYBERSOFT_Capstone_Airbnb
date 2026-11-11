import 'package:airbnb_cybersoft/screens/profile/profile_detail_screen.dart';
import 'package:airbnb_cybersoft/screens/profile/profile_utils/activity_list_view.dart';
import 'package:airbnb_cybersoft/utils/divider_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              const SizedBox(height: 16),
              _header(),
              const DividerWidget(),
              Padding(
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
                child: const Text('Activity', style: TextStyle(fontSize: 24)),
              ),
              const SizedBox(height: 16),
              const ActivityListView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          const SizedBox(height: 16),
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMzkYfwmc1UjcLkt-4kUv7_Gd_vA3ayx6-33dej-XXyw&s=10',
            ),
            onBackgroundImageError: (exception, stackTrace) =>
                Container(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          const Text('John', style: TextStyle(fontSize: 40, fontWeight: .bold)),
          const SizedBox(height: 8),
          TextButton(
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
