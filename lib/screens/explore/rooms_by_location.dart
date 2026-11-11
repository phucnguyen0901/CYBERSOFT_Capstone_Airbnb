import 'package:airbnb_cybersoft/models/room_model.dart';
import 'package:airbnb_cybersoft/screens/explore/detail_screen.dart';
import 'package:airbnb_cybersoft/services/room_service.dart';
import 'package:flutter/material.dart';

class RoomsByLocation extends StatefulWidget {
  const RoomsByLocation({super.key, required this.maViTri});
  final int maViTri;

  @override
  State<RoomsByLocation> createState() => _RoomsByLocation();
}

class _RoomsByLocation extends State<RoomsByLocation> {
  List<PhongViewModel> rooms = [];

  @override
  void initState() {
    RoomService.getRoomByLocation(widget.maViTri)
        .then((value) {
          setState(() {
            rooms = value;
          });
        })
        .catchError((err) {
          throw Exception(err);
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      title: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            children: [
              const Icon(Icons.search_rounded),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'Where to?',
                    style: TextStyle(fontSize: 16, fontWeight: .bold),
                  ),
                  Text(
                    'Anywhere - Any week - Add guest',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Expanded(child: const SizedBox()),
              const Icon(Icons.filter_list),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return ListView.builder(
      itemCount: rooms.length,
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        var room = rooms[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DetailScreen(room: room)),
            );
          },
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
                        style: TextStyle(fontWeight: .bold, fontSize: 14),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Row(
                      children: [
                        Icon(Icons.star, size: 14),
                        const SizedBox(width: 4),
                        Text('4.87 (71)'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('1,699 kilometers', style: TextStyle(color: Colors.grey)),
                Text('Jul 2 - 7', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),
                Text(
                  '\$${room.giaTien} night',
                  style: TextStyle(fontWeight: .bold, fontSize: 14),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }
}
