import 'package:airbnb_cybersoft/models/room_model.dart';
import 'package:airbnb_cybersoft/screens/explore/detail_screen/widgets/floatting_bottom_bar.dart';
import 'package:airbnb_cybersoft/screens/explore/detail_screen/widgets/floatting_top_bar.dart';
import 'package:airbnb_cybersoft/screens/explore/detail_screen/widgets/review_container.dart';
import 'package:airbnb_cybersoft/screens/explore/detail_screen/widgets/room_bedroom.dart';
import 'package:airbnb_cybersoft/screens/explore/detail_screen/widgets/room_conveniences.dart';
import 'package:airbnb_cybersoft/screens/explore/explore_screen/widgets/room_location.dart';
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
                RoomLocation(room: room),
                const DividerWidget(),
                Text(room.moTa),
                const DividerWidget(),
                RoomBedroom(room: room),
                const DividerWidget(),
                RoomConveniences(room: room),
                const DividerWidget(),
                ReviewContainer(maPhong: room.id!),
                const DividerWidget(),
                _notice(),
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

  Row _notice() {
    return Row(
      children: [
        Expanded(
          child: const Text(
            'To protect your payment, never transfer money or communicate outside of the Airbnb Cybersoft website or app.',
            style: TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(width: 24),
        normalSvgIcon(
          assetName: 'assets/icons/detail_room_icon/Airbnb-Protect.svg',
          color: primaryColor,
        ),
      ],
    );
  }
}
