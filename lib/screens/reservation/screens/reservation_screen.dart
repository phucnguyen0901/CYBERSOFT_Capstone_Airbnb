import 'package:airbnb_cybersoft/models/booking_model.dart';
import 'package:airbnb_cybersoft/models/room_model.dart';
import 'package:airbnb_cybersoft/providers/user_provider.dart';
import 'package:airbnb_cybersoft/screens/reservation/widgets/date_picked_view.dart';
import 'package:airbnb_cybersoft/screens/reservation/widgets/date_time_picker.dart';
import 'package:airbnb_cybersoft/screens/reservation/widgets/reservation_bottom_bar.dart';
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
  DateTimeRange? range;
  DateTime? ngayDen;
  DateTime? ngayDi;

  int soLuongKhach = 1;

  @override
  Widget build(BuildContext context) {
    final userProvier = context.watch<UserProvider>();
    final maNguoiDung = userProvier.user.id;
    final maPhong = widget.room.id;
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _pickDate(),
            const SizedBox(height: 16),
            DateView(range: range, dayCount: countDay(range)),
            const SizedBox(height: 32),
            _countGuest(),
          ],
        ),
      ),
      bottomSheet: ReservationBottomBar(
        widget: widget,
        dayCount: countDay(range),
        reserveInfo: DatPhongViewModel(
          id: 0,
          maPhong: maPhong!,
          ngayDen: ngayDen.toString(),
          ngayDi: ngayDi.toString(),
          soLuongKhach: soLuongKhach,
          maNguoiDung: maNguoiDung!,
        ),
      ),
    );
  }

  Row _pickDate() {
    return Row(
      children: [
        const Text('When\'s your trip?', style: TextStyle(fontWeight: .bold)),
        Expanded(child: SizedBox()),
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(16),
              color: secondaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              child: Text('Save the date'),
            ),
          ),
          onTap: () async {
            final date = await showDialog(
              context: context,
              builder: (_) {
                return DateTimePicker();
              },
            );
            setState(() {
              range = date;
            });
          },
        ),
      ],
    );
  }

  Row _countGuest() {
    return Row(
      children: [
        const Text(
          'How many guest are there?',
          style: TextStyle(fontWeight: .bold),
        ),
        const Expanded(child: SizedBox()),
        IconButton.outlined(
          onPressed: (soLuongKhach <= 1)
              ? null
              : () {
                  setState(() {
                    soLuongKhach -= 1;
                  });
                },
          icon: Icon(Icons.remove),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Center(child: Text(soLuongKhach.toString())),
        ),
        IconButton.outlined(
          onPressed: () {
            setState(() {
              soLuongKhach += 1;
            });
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }

  int countDay(DateTimeRange? range) {
    if (range == null) return 0;

    setState(() {
      ngayDen = range.start;
      ngayDi = range.end;
    });

    final startDate = DateTime(
      range.start.year,
      range.start.month,
      range.start.day,
    );

    final DateTime endDate = DateTime(
      range.end.year,
      range.end.month,
      range.end.day,
    );

    final int diffDate = endDate.difference(startDate).inDays;
    final int dateRange = diffDate + 1; //lí do: vì nó chỉ đếm số ngày phía sau, bỏ qua ngày bắt đầu, nó sẽ bằng 0 nếu chọn trùng ngày

    return dateRange;
  }
}
