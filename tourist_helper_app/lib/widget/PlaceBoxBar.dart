//For all Destination

import 'package:flutter/material.dart';

class PlaceBoxBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.circular(1.0),
      ),
      child: const Text(
        'Place',
        style: TextStyle(
          fontSize: 23.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}