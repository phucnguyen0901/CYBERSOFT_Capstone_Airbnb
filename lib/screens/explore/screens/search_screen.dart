import 'package:airbnb_cybersoft/models/location_model.dart';
import 'package:airbnb_cybersoft/screens/explore/screens/rooms_by_location.dart';
import 'package:airbnb_cybersoft/services/location_service.dart';
import 'package:airbnb_cybersoft/utils/svg_icon.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ViTriViewModel> locationList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _getLocation('');
    super.initState();
  }

  void _getLocation(String keyword) {
    LocationService.getLocations(keyword: keyword)
        .then((value) {
          setState(() {
            locationList = value;
          });
        })
        .catchError((err) {
          throw Exception(err);
        });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: _appBar(context),
        bottomSheet: _body(),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: Colors.grey[300],
      leading: SizedBox(
        width: 48,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_circle_left_outlined, size: 32),
          ),
        ),
      ),
      centerTitle: true,
      title: const TabBar(
        labelStyle: TextStyle(fontWeight: .bold, color: Colors.black),
        dividerColor: Colors.transparent,
        indicatorSize: .label,
        indicatorPadding: EdgeInsetsGeometry.only(bottom: 8),
        indicatorColor: Colors.black,
        tabs: [
          Tab(text: 'Stays'),
          Tab(text: 'Experiences'),
        ],
      ),
      actions: [const SizedBox(width: 48)],
    );
  }

  Padding _body() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(16),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: const Icon(Icons.search_rounded),
              hint: const Text('Search here...'),
              suffixIcon: const Icon(Icons.close_rounded),
            ),
            onChanged: (value) {
              _getLocation(value);
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16),
              itemCount: locationList.length,
              itemBuilder: ((context, index) {
                var item = locationList[index];
                return _locationTile(item);
              }),
            ),
          ),
        ],
      ),
    );
  }

  InkWell _locationTile(ViTriViewModel item) {
    final String diaChi =
        '${item.tenViTri}, ${item.tinhThanh}, ${item.quocGia}';
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                RoomsByLocation(maViTri: item.id!, diaChi: diaChi),
          ),
        );
      },
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: (item.hinhAnh.isEmpty)
                    ? Padding(
                        padding: const EdgeInsets.all(8),
                        child: normalSvgIcon(
                          assetName: 'assets/icons/appbar_icon/Location.svg',
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(item.hinhAnh, fit: .cover),
                      ),
              ),
              const SizedBox(width: 16),
              Expanded(child: Text(diaChi)),
            ],
          ),
        ),
      ),
    );
  }
}
