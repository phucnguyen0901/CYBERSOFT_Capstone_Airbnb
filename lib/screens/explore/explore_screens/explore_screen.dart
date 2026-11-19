import 'package:airbnb_cybersoft/models/room_model.dart';
import 'package:airbnb_cybersoft/screens/explore/explore_screens/search_screen.dart';
import 'package:airbnb_cybersoft/services/room_service.dart';
import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:airbnb_cybersoft/screens/explore/explore_widgets/rooms_tile_view.dart';
import 'package:airbnb_cybersoft/utils/svg_icon.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<PhongViewModel> rooms = [];

  @override
  void initState() {
    RoomService.getRooms()
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
    return DefaultTabController(
      length: tabBarItems.length,
      child: Scaffold(
        appBar: _appBar(),
        floatingActionButton: _MapButton(),
        body: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: rooms.length,
          itemBuilder: (context, index) {
            var room = rooms[index];
            return RoomsTileView(room: room);
          },
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      toolbarHeight: 80,
      centerTitle: true,
      title: GestureDetector(
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const SearchScreen()));
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            children: [
              const Icon(Icons.search_rounded),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'Where to?',
                    style: TextStyle(fontSize: 16, fontWeight: .bold),
                  ),
                  Text(
                    'Anywhere - Any week - Add guest',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Expanded(child: const SizedBox()),
              const Icon(Icons.filter_list),
            ],
          ),
        ),
      ),
      bottom: TabBar(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelPadding: const EdgeInsets.symmetric(horizontal: 24),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.black,
        labelColor: Colors.black,
        tabs: List.generate(tabBarItems.length, (index) {
          final tabBarItem = tabBarItems[index];
          return Tab(
            icon: normalSvgIcon(assetName: tabBarItem['icon']),
            text: tabBarItem['label'],
          );
        }),
      ),
    );
  }
}

class _MapButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(100),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisSize: .min,
        children: [
          const Text(
            'Map',
            style: TextStyle(color: Colors.white, fontWeight: .bold),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.map, color: Colors.white),
        ],
      ),
    );
  }
}
