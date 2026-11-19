import 'package:airbnb_cybersoft/models/room_model.dart';
import 'package:airbnb_cybersoft/screens/explore/explore_screens/detail_screen.dart';
import 'package:airbnb_cybersoft/screens/explore/explore_widgets/room_location.dart';
import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:airbnb_cybersoft/utils/divider_widget.dart';
import 'package:flutter/material.dart';

class RoomsTileView extends StatelessWidget {
  const RoomsTileView({super.key, required this.room});
  final PhongViewModel room;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => DetailScreen(room: room))),
      child: SizedBox(
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            _roomImages(room),
            const SizedBox(height: 16),
            _roomName(room),
            const SizedBox(height: 16),
            RoomLocation(room: room),
            const SizedBox(height: 8),
            _roomPrice(room),
            DividerWidget(),
          ],
        ),
      ),
    );
  }

  Row _roomPrice(PhongViewModel room) {
    return Row(
      children: [
        const Icon(
          Icons.monetization_on_outlined,
          size: 20,
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

  Row _roomName(PhongViewModel room) {
    return Row(
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
        Row(
          children: [
            const Icon(Icons.star, size: 20),
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
