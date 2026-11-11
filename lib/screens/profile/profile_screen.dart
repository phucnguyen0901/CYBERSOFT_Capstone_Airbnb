import 'package:airbnb_cybersoft/models/booking_model.dart';
import 'package:airbnb_cybersoft/models/room_model.dart';
import 'package:airbnb_cybersoft/screens/explore/rooms_by_location.dart';
import 'package:airbnb_cybersoft/screens/profile/profile_detail_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.maNguoiDung});
  final int maNguoiDung;

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  List<DatPhongViewModel> history = [];
  List<PhongViewModel> rooms = [];

  @override
  void initState() {
    super.initState();
  }

  void _getHistory() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            const SizedBox(height: 16),
            _header(),
            const SizedBox(height: 32, child: Divider()),
            Padding(
              padding: const EdgeInsets.all(16),
              child: const Text('Activity', style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 16),
            Expanded(child: RoomsByLocation(maViTri: 1)),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsetsGeometry.all(16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
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
