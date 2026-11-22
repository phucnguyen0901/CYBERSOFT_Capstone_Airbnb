import 'package:flutter/material.dart';

class MapButton extends StatelessWidget {
  const MapButton({super.key});

  @override
  InkWell build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(100),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
      ),
    );
  }
}
