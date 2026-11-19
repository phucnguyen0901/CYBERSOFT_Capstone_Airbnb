import 'package:airbnb_cybersoft/models/room_model.dart';
import 'package:airbnb_cybersoft/providers/user_provider.dart';
import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key, required this.room});
  final PhongViewModel room;

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvier = context.read<UserProvider>();
    final maNguoiDung = userProvier.user.id!;
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Trip date',
                  style: TextStyle(fontSize: titleFontSize, fontWeight: .bold),
                ),
                Expanded(child: SizedBox()),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Choose date'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: .end,
              children: [
                Row(
                  mainAxisAlignment: .end,
                  children: [
                    const Text('From: '),
                    const SizedBox(width: 16),
                    const Text('dd-mm-yy'),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: .end,
                  children: [
                    const Text('To:'),
                    const SizedBox(width: 16),
                    const Text('dd-mm-yy'),
                  ],
                ),
                const SizedBox(width: 200, height: 16, child: Divider()),
                const Text(
                  'Booking for: 4 day(s)',
                  style: TextStyle(color: primaryColor, fontWeight: .bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Guest',
                  style: TextStyle(fontSize: titleFontSize, fontWeight: .bold),
                ),
                Expanded(child: SizedBox()),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Choose guest'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: _bottomSheet(),
    );
  }

  SafeArea _bottomSheet() {
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
                      'Total:   ${widget.room.giaTien * 4}\$',
                      style: const TextStyle(fontWeight: .bold, fontSize: 18),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
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
                      'Complete',
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
}
