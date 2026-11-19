import 'package:airbnb_cybersoft/models/room_model.dart';
import 'package:airbnb_cybersoft/screens/explore/widgets/floatting_bottom_bar.dart';
import 'package:airbnb_cybersoft/screens/explore/widgets/floatting_top_bar.dart';
import 'package:airbnb_cybersoft/screens/explore/widgets/review_container.dart';
import 'package:airbnb_cybersoft/screens/explore/widgets/room_conveniences.dart';
import 'package:airbnb_cybersoft/screens/explore/widgets/room_location.dart';
import 'package:airbnb_cybersoft/utils/divider_widget.dart';
import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:airbnb_cybersoft/utils/svg_icon.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.room});
  final PhongViewModel room;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _mainBody(),
          TopBar(context: context),
        ],
      ),
      bottomSheet: BottomBar(room: room),
    );
  }

  SingleChildScrollView _mainBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              room.hinhAnh,
              fit: .fitHeight,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[300],
                child: const Center(child: Icon(Icons.image_not_supported)),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                _roomName(),
                const SizedBox(height: 16),
                _starRate(),
                const SizedBox(height: 16),
                RoomLocation(room: room),
                const DividerWidget(),
                Text(room.moTa),
                const DividerWidget(),
                _bedroom(),
                const DividerWidget(),
                RoomConveniences(room: room),
                const DividerWidget(),
                ReviewContainer(),
                const DividerWidget(),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text _roomName() {
    return Text(
      room.tenPhong,
      style: const TextStyle(fontSize: titleFontSize, fontWeight: .bold),
    );
  }

  Row _starRate() {
    return const Row(
      children: [Icon(Icons.star_rounded), Text('5.0 . '), Text('3 reviews')],
    );
  }

  SizedBox _bedroom() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          const Text(
            'Where you\'ll sleep',
            style: TextStyle(fontWeight: .bold, fontSize: titleFontSize),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
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
