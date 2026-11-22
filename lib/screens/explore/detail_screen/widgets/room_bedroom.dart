import 'package:airbnb_cybersoft/models/room_model.dart';
import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:airbnb_cybersoft/utils/svg_icon.dart';
import 'package:flutter/material.dart';

class RoomBedroom extends StatelessWidget {
  const RoomBedroom({super.key, required this.room});

  final PhongViewModel room;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          const Text(
            'Where you\'ll sleep?',
            style: TextStyle(fontWeight: .bold, fontSize: titleFontSize),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: secondaryColor,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                normalSvgIcon(
                  assetName: 'assets/icons/detail_room_icon/Bed.svg',
                ),
                const SizedBox(height: 4),
                const Text('Bedroom', style: TextStyle(fontWeight: .bold)),
                Text('${room.giuong.toString()} standard bed(s)'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
