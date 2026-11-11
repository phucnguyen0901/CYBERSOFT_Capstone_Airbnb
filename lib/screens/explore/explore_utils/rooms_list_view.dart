import 'package:airbnb_cybersoft/models/room_model.dart';
import 'package:airbnb_cybersoft/screens/explore/detail_screen.dart';
import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:flutter/material.dart';

class RoomsListView extends StatelessWidget {
  const RoomsListView({super.key, required this.rooms});

  final List<PhongViewModel> rooms;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rooms.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
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
                _roomImages(room),
                const SizedBox(height: 16),
                _roomName(room),
                const SizedBox(height: 8),
                // _distance(),
                // _calendar(),
                _roomPrice(room),
                const SizedBox(height: 48),
              ],
            ),
          ),
        );
      },
    );
  }

  Row _roomPrice(PhongViewModel room) {
    return Row(
      children: [
        const Icon(
          Icons.monetization_on_outlined,
          size: 18,
          color: primaryColor,
        ),
        const SizedBox(width: 8),
        Text(
          '${room.giaTien}\$ per. night',
          style: const TextStyle(fontWeight: .bold, color: primaryColor),
        ),
      ],
    );
  }

  // Row _calendar() {
  //   return Row(
  //     children: [
  //       const Icon(Icons.calendar_month_outlined, size: 18, color: Colors.grey),
  //       const SizedBox(width: 8),
  //       Text('Jul 2 - 7', style: const TextStyle(color: Colors.grey)),
  //     ],
  //   );
  // }

  // Row _distance() {
  //   return Row(
  //     children: [
  //       const Icon(Icons.location_on_outlined, size: 18, color: Colors.grey),
  //       const SizedBox(width: 8),
  //       Text('1.699 kilometers', style: const TextStyle(color: Colors.grey)),
  //     ],
  //   );
  // }

  Row _roomName(PhongViewModel room) {
    return Row(
      crossAxisAlignment: .start,
      children: [
        Expanded(
          child: Text(
            room.tenPhong,
            style: const TextStyle(fontWeight: .bold, fontSize: 14),
          ),
        ),
        const SizedBox(width: 16),
        Row(
          children: [
            const Icon(Icons.star, size: 14),
            const SizedBox(width: 4),
            const Text('4.87 (71)'),
          ],
        ),
      ],
    );
  }

  ClipRRect _roomImages(PhongViewModel room) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(24),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.network(
          room.hinhAnh,
          fit: .cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey[300],
            child: const Center(child: Icon(Icons.image_not_supported)),
          ),
        ),
      ),
    );
  }
}
