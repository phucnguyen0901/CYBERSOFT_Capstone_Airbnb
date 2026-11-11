import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Padding stateSvgIcon({
  String? assetName,
  bool? active = true,
  Color? activeColor = Colors.red,
}) {
  return Padding(
    padding: const EdgeInsets.all(4),
    child: SvgPicture.asset(
      assetName!,
      width: 24,
      height: 24,
      colorFilter: ColorFilter.mode(
        (active == true) ? activeColor as Color : Colors.grey,
        BlendMode.srcIn,
      ),
    ),
  );
}

Padding normalSvgIcon({String? assetName, Color? color = Colors.black}) {
  return Padding(
    padding: const EdgeInsets.all(4),
    child: SvgPicture.asset(
      assetName!,
      width: 24,
      height: 24,
      colorFilter: ColorFilter.mode(color as Color, BlendMode.srcIn),
    ),
  );
}
