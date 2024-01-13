import 'package:flutter/material.dart';

Widget buildBottomBar(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 100, 186, 226),
          Color.fromARGB(255, 0, 92, 198),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    // child: Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //   children: <Widget>[
    //     _buildIcon(Icons.home, 'Home'),
    //     _buildIcon(Icons.location_on, 'Location'),
    //     _buildIcon(Icons.app_registration, 'Register'),
    //     _buildIcon(Icons.person, 'Profile'),
    //   ],
    // ),
  );
}

Widget _buildIcon(IconData icon, String label) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          icon,
          size: 30.0,
          color: const Color.fromARGB(255, 0, 92, 198),
        ),
      ),
      const SizedBox(height: 4.0),
      Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14.0,
        ),
      ),
    ],
  );
}