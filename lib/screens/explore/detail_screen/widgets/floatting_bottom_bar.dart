import 'package:airbnb_cybersoft/models/room_model.dart';
import 'package:airbnb_cybersoft/providers/auth_provider.dart';
import 'package:airbnb_cybersoft/screens/reservation/screens/reservation_screen.dart';
import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key, required this.room});

  final PhongViewModel room;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    return SafeArea(
      child: BottomSheet(
        onClosing: () {},
        enableDrag: false,
        backgroundColor: Colors.grey[100],
        builder: (context) {
          return Padding(
            padding: const EdgeInsetsGeometry.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.monetization_on_outlined),
                    const SizedBox(width: 8),
                    Text(
                      '${room.giaTien}\$ per. night ',
                      style: const TextStyle(fontWeight: .bold, fontSize: 18),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    if (authProvider.isLogin != false) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ReservationScreen(room: room),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(_errorSnackBar());
                    }
                  },

                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 48,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: primaryColor,
                    ),
                    child: const Text(
                      'Reserve',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: .bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  SnackBar _errorSnackBar() {
    return SnackBar(
      duration: Duration(seconds: 3),
      content: Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          'Please sign in your account to continue!',
          style: TextStyle(fontWeight: .bold),
        ),
      ),
    );
  }
}
