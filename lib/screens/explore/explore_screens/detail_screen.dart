import 'package:airbnb_cybersoft/models/room_model.dart';
import 'package:airbnb_cybersoft/screens/explore/explore_widgets/room_location.dart';
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
      body: Stack(children: [_mainBody(), _topBar(context)]),
      bottomSheet: _bottomSheet(),
    );
  }

  SafeArea _topBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          children: [
            _buildButton(Icon(Icons.arrow_back_rounded), context),
            const Expanded(child: SizedBox()),
            _buildButton(
              normalSvgIcon(
                assetName: 'assets/icons/detail_room_icon/Upload.svg',
              ),
              null,
            ),
            SizedBox(width: 8),
            _buildButton(
              normalSvgIcon(
                assetName: 'assets/icons/detail_room_icon/Menu.svg',
              ),
              null,
            ),
          ],
        ),
      ),
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
                _roomConveniences(),
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

  SizedBox _roomConveniences() {
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

  SafeArea _bottomSheet() {
    return SafeArea(
      child: BottomSheet(
        onClosing: () {},

        backgroundColor: Colors.grey[100],
        builder: (context) {
          return Padding(
            padding: const EdgeInsetsGeometry.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.monetization_on_outlined),
                    const SizedBox(width: 8),
                    Text(
                      '${room.giaTien}\$ per. night ',
                      style: const TextStyle(fontWeight: .bold, fontSize: 18),
                    ),
                  ],
                ),
                Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: primaryColor,
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Reserve',
                      style: TextStyle(color: Colors.white, fontWeight: .bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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

  IconButton _buildButton(Widget icon, BuildContext? context) {
    return IconButton(
      padding: const EdgeInsets.all(4),
      onPressed: () {
        if (context != null) {
          Navigator.of(context).pop();
        }
      },
      icon: icon,
      color: Colors.black,
      style: IconButton.styleFrom(backgroundColor: Colors.white),
    );
  }
}
