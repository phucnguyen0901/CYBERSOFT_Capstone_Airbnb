import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:flutter/material.dart';

class DateView extends StatelessWidget {
  const DateView({super.key, required this.range, required this.dayCount});

  final DateTimeRange<DateTime>? range;
  final int dayCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .end,
      children: [
        Row(
          mainAxisAlignment: .end,
          children: [
            Text('From:'),
            const SizedBox(width: 16),
            Text(
              (range == null)
                  ? 'dd-mm-yy'
                  : '${range!.start.day}-${range!.start.month}-${range!.start.year}',
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: .end,
          children: [
            const Text('To:'),
            const SizedBox(width: 16),
            Text(
              (range == null)
                  ? 'dd-mm-yy'
                  : '${range!.end.day}-${range!.end.month}-${range!.end.year}',
            ),
          ],
        ),
        const SizedBox(width: 200, height: 16, child: Divider()),
        Text(
          (range == null)
              ? 'No booking infomation'
              : 'Booking for: $dayCount day(s)',
          style: TextStyle(color: primaryColor, fontWeight: .bold),
        ),
      ],
    );
  }
}
