import 'package:airbnb_cybersoft/models/booking_model.dart';
import 'package:airbnb_cybersoft/models/room_model.dart';
import 'package:airbnb_cybersoft/screens/explore/detail_screen.dart';
import 'package:airbnb_cybersoft/services/reservation_service.dart';
import 'package:airbnb_cybersoft/services/room_service.dart';
import 'package:flutter/material.dart';

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
    _getHistory(73395);
    super.initState();
  }

  void _getHistory(int maNguoiDung) {
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
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
                        style: const TextStyle(fontWeight: .bold, fontSize: 14),
                      ),
                    ),
                    const SizedBox(width: 32),
                    Text(
                      '\$${room.giaTien} night',
                      style: const TextStyle(fontWeight: .bold, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  '1,699 kilometers',
                  style: TextStyle(color: Colors.grey),
                ),
                const Text('Jul 2 - 7', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),

                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }
}
