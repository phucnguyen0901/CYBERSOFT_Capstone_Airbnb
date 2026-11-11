import 'package:airbnb_cybersoft/models/room_model.dart';
import 'package:airbnb_cybersoft/utils/constant.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.room});
  final PhongViewModel room;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(children: [_mainBody(), _topBar(context)]),
    );
  }

  SafeArea _topBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            _buildButton(context),
            Expanded(child: SizedBox()),
            _buildButton(context),
            SizedBox(width: 8),
            _buildButton(context),
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
              widget.room.hinhAnh,
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
                Text(
                  widget.room.tenPhong,
                  style: const TextStyle(fontSize: 24, fontWeight: .bold),
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Icon(Icons.star),
                    Text('5.0 . '),
                    Text('3 reviews'),
                  ],
                ),
                const SizedBox(height: 16),
                Text('123 ABC street, DEF ward, GHI city'),
                const SizedBox(height: 48, child: Divider(color: Colors.grey)),
                Text(widget.room.moTa),
                const SizedBox(height: 48, child: Divider(color: Colors.grey)),

                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      '\$ ${widget.room.giaTien.toString()}',
                      style: const TextStyle(fontWeight: .bold, fontSize: 16),
                    ),
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: primaryColor,
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Reserve',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: .bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconButton _buildButton(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      style: IconButton.styleFrom(backgroundColor: Colors.white),
    );
  }
}
