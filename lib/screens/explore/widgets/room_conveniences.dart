import 'package:airbnb_cybersoft/models/room_model.dart';
import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:airbnb_cybersoft/utils/svg_icon.dart';
import 'package:flutter/material.dart';

class RoomConveniences extends StatelessWidget {
  const new({super.key, required this.room});

  final PhongViewModel room;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          const Text(
            'What\'s this place offer',
            style: TextStyle(fontSize: titleFontSize, fontWeight: .bold),
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: .start,
            children: [
              if (room.mayGiat) _buildConvenient('mayGiat'),
              if (room.banLa) _buildConvenient('banLa'),
              if (room.dieuHoa) _buildConvenient('dieuHoa'),
              if (room.bep) _buildConvenient('bep'),
              if (room.tivi) _buildConvenient('tivi'),
              if (room.doXe) _buildConvenient('doXe'),
              if (room.wifi) _buildConvenient('wifi'),
              if (room.hoBoi) _buildConvenient('hoBoi'),
            ],
          ),
        ],
      ),
    );
  }

  Row _buildConvenient(String tag) {
    Map<String, dynamic> convenience = {};
    for (var item in roomConvenients) {
      if (item['tag'] == tag) {
        convenience = item;
      }
    }
    return Row(
      children: [
        normalSvgIcon(assetName: convenience['icon']),
        const SizedBox(width: 16),
        Text(convenience['label'], maxLines: 2, overflow: .ellipsis),
      ],
    );
  }
}
