import 'package:airbnb_cybersoft/models/booking_model.dart';
import 'package:airbnb_cybersoft/models/room_model.dart';
import 'package:airbnb_cybersoft/providers/user_provider.dart';
import 'package:airbnb_cybersoft/screens/explore/screens/detail_screen.dart';
import 'package:airbnb_cybersoft/services/reservation_service.dart';
import 'package:airbnb_cybersoft/services/room_service.dart';
import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityListView extends StatefulWidget {
  const ActivityListView({super.key});

  @override
  State<ActivityListView> createState() => _ActivityListViewState();
}

class _ActivityListViewState extends State<ActivityListView> {
  List<DatPhongViewModel> history = [];
  List<PhongViewModel> rooms = [];

  @override
  void initState() {
    _getHistory();
    super.initState();
  }

  void _getHistory() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final maNguoiDung = userProvider.user.id!;
    ReservationService.getRoomsByUserID(maNguoiDung)
        .then((values) {
          setState(() {
            history = values;
          });
          for (var item in history) {
            _getRoomInfo(item.maPhong);
          }
        })
        .catchError((err) {});
  }

  void _getRoomInfo(int id) {
    RoomService.getRoomByID(id)
        .then((value) {
          setState(() {
            rooms.add(value);
          });
        })
        .catchError((onError) {});
  }

  String dateTime(String dtString) {
    int y = DateTime.parse(dtString).year;
    int m = DateTime.parse(dtString).month;
    int d = DateTime.parse(dtString).day;
    return '$d-$m-$y';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      reverse: true,
      itemCount: rooms.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        var reserveInfo = history[index];
        var room = rooms[index];
        return GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DetailScreen(room: room)),
          ),
          child: SizedBox(
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(24),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      room.hinhAnh,
                      fit: .cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image_not_supported),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: .start,
                  children: [
                    Expanded(
                      child: Text(
                        room.tenPhong,
                        style: const TextStyle(fontWeight: .bold),
                        maxLines: 2,
                        overflow: .ellipsis,
                      ),
                    ),
                    const SizedBox(width: 32),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.grey,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'From ${dateTime(reserveInfo.ngayDen)} to ${dateTime(reserveInfo.ngayDi)}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.people_outlined,
                      color: Colors.grey,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${reserveInfo.soLuongKhach.toString()} guest(s)',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.monetization_on_outlined,
                      size: 20,
                      color: primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${room.giaTien}\$ per. night',
                      style: const TextStyle(
                        fontWeight: .bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        );
      },
    );
  }
}
