import 'package:airbnb_cybersoft/utils/svg_icon.dart';
import 'package:flutter/material.dart';

final List<Map<String, String>> navBarItems = const [
  {'label': 'Explore', 'icon': 'assets/icons/navbar_icon/Search.svg'},
  {'label': 'Wishlist', 'icon': 'assets/icons/navbar_icon/Heart.svg'},
  {'label': 'Trips', 'icon': 'assets/icons/navbar_icon/airbnb.svg'},
  {'label': 'Inbox', 'icon': 'assets/icons/navbar_icon/Message.svg'},
  {'label': 'Profile', 'icon': 'assets/icons/navbar_icon/User.svg'},
];

final List<Map<String, String>> tabBarItems = const [
  {'label': 'OMG!', 'icon': 'assets/icons/category_icon/U.F.O..svg'},
  {'label': 'Beach', 'icon': 'assets/icons/category_icon/Beach.svg'},
  {'label': 'Amazing pool', 'icon': 'assets/icons/category_icon/Pool.svg'},
  {'label': 'Islands', 'icon': 'assets/icons/category_icon/Island.svg'},
  {'label': 'Arctic', 'icon': 'assets/icons/detail_room_icon/Arctic.svg'},
];

final List<Map<String, dynamic>> roomConvenients = [
  {
    'tag': 'mayGiat',
    'label': 'Washing machine',
    'icon': normalSvgIcon(assetName: 'assets/icons/detail_room_icon/Door.svg'),
  },
  {
    'tag': 'tivi',
    'label': 'Lagre TV, easy to enjoy media',
    'icon': normalSvgIcon(
      assetName: 'assets/icons/detail_room_icon/river_view.svg',
    ),
  },
  {
    'tag': 'banLa',
    'label': 'Steam iron',
    'icon': normalSvgIcon(assetName: 'assets/icons/detail_room_icon/Door.svg'),
  },
  {
    'tag': 'wifi',
    'label': 'Free wi-fi',
    'icon': normalSvgIcon(assetName: 'assets/icons/detail_room_icon/Wifi.svg'),
  },
  {
    'tag': 'dieuHoa',
    'label': 'Air conditioner',
    'icon': normalSvgIcon(
      assetName: 'assets/icons/detail_room_icon/Arctic.svg',
    ),
  },
  {
    'tag': 'bep',
    'label': 'Kitchen',
    'icon': normalSvgIcon(
      assetName: 'assets/icons/detail_room_icon/Kitchen.svg',
    ),
  },
  {
    'tag': 'doXe',
    'label': 'Free parking on permises',
    'icon': normalSvgIcon(assetName: 'assets/icons/detail_room_icon/Car.svg'),
  },
  {
    'tag': 'hoBoi',
    'label': 'Free to use swim pool',
    'icon': normalSvgIcon(assetName: 'assets/icons/category_icon/Pool.svg'),
  },
];

const Color primaryColor = Color.fromARGB(255, 180, 13, 1);
