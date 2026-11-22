import 'package:airbnb_cybersoft/models/booking_model.dart';
import 'package:airbnb_cybersoft/providers/activity_provider.dart';
import 'package:airbnb_cybersoft/screens/reservation/screens/reservation_screen.dart';
import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReservationBottomBar extends StatelessWidget {
  const ReservationBottomBar({
    super.key,
    required this.widget,
    required this.dayCount,
    required this.reserveInfo,
  });

  final ReservationScreen widget;
  final int dayCount;
  final DatPhongViewModel reserveInfo;

  @override
  Widget build(BuildContext context) {
    final activityProvider = context.read<ActivityProvider>();
    return SafeArea(
      child: BottomSheet(
        onClosing: () {},
        enableDrag: false,
        backgroundColor: Colors.grey[100],
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.monetization_on_outlined),
                    const SizedBox(width: 8),
                    Text(
                      'Total:   ${widget.room.giaTien * dayCount}\$',
                      style: const TextStyle(fontWeight: .bold, fontSize: 18),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: (dayCount == 0)
                      ? null
                      : () async {
                          await activityProvider.booking(reserveInfo);
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                        },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 32,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: (dayCount == 0) ? Colors.grey : primaryColor,
                    ),
                    child: const Text(
                      'Reserve now!',
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
