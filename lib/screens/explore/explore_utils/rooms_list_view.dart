import 'package:airbnb_cybersoft/models/room_model.dart';
import 'package:airbnb_cybersoft/screens/explore/detail_screen.dart';
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
                    const SizedBox(width: 16),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14),
                        const SizedBox(width: 4),
                        const Text('4.87 (71)'),
                      ],
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
                Text(
                  '\$${room.giaTien} night',
                  style: const TextStyle(fontWeight: .bold, fontSize: 14),
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
