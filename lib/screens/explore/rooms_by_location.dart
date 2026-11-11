import 'package:airbnb_cybersoft/models/room_model.dart';
import 'package:airbnb_cybersoft/screens/explore/explore_utils/rooms_list_view.dart';
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
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: RoomsListView(rooms: rooms),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 80,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
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
                ),
              ],
            ),
            Expanded(child: const SizedBox()),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
