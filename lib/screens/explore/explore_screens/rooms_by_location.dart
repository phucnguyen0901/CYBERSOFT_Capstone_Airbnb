import 'package:airbnb_cybersoft/models/room_model.dart';
import 'package:airbnb_cybersoft/screens/explore/explore_widgets/rooms_tile_view.dart';
import 'package:airbnb_cybersoft/services/room_service.dart';
import 'package:flutter/material.dart';

class RoomsByLocation extends StatefulWidget {
  const RoomsByLocation({
    super.key,
    required this.maViTri,
    required this.diaChi,
  });
  final int maViTri;
  final String diaChi;

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
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: rooms.length,
          itemBuilder: (context, index) {
            var room = rooms[index];
            return RoomsTileView(room: room);
          },
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      toolbarHeight: 80,
      title: Container(
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
                const Text('Location: ', style: TextStyle(fontSize: 12)),
                const SizedBox(height: 4),
                Text(
                  widget.diaChi,
                  style: const TextStyle(fontSize: 16, fontWeight: .bold),
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
              ],
            ),
            Expanded(child: const SizedBox()),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
