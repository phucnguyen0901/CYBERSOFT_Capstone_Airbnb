import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:airbnb_cybersoft/utils/svg_icon.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key, required this.context});
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
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
      style: IconButton.styleFrom(backgroundColor: secondaryColor),
    );
  }
}
