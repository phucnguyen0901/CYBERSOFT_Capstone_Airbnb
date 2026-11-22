import 'package:airbnb_cybersoft/models/room_model.dart';
import 'package:airbnb_cybersoft/services/location_service.dart';
import 'package:flutter/material.dart';

class RoomLocation extends StatefulWidget {
  const RoomLocation({super.key, required this.room, this.color});
  final PhongViewModel room;
  final Color? color;

  @override
  State<RoomLocation> createState() => _RoomLocationState();
}

class _RoomLocationState extends State<RoomLocation> {
  String location = '';

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    LocationService.getLocationByID(maViTri: widget.room.maViTri)
        .then((value) {
          setState(() {
            location =
                '${value.tenViTri}, ${value.tinhThanh}, ${value.quocGia}';
          });
        })
        .catchError((err) {});
  }

  @override
  Widget build(BuildContext context) {
    Color color = (widget.color) ?? Colors.black;
    return Row(
      children: [
        Icon(Icons.location_on_outlined, color: color),
        const SizedBox(width: 8),
        Text(location, style: TextStyle(color: color)),
      ],
    );
  }
}
