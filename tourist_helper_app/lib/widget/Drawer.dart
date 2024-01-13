// drawer.dart
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:tourist_helper_app/screen/A2ViewLocation.dart';
import 'package:tourist_helper_app/screen/A3RegisterPlace.dart';
import 'package:tourist_helper_app/screen/A4Profile.dart';

class MyDrawer extends StatelessWidget {
  final String username;

  const MyDrawer({super.key, required this.username});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 100, 186, 226),
                  Color.fromARGB(255, 0, 92, 198),
                ],
              ),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.location_on, color: Colors.blue.shade900),
            title: const Text(
              'Location',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (ctx){
                return A2ViewLocation(username: username);
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.app_registration_rounded, color: Colors.blue.shade900),
            title: const Text(
              'Register',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(context,MaterialPageRoute(builder: ((context) {
                return A3RegisterPlace(username: username);
              })));
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.blue.shade900),
            title: const Text(
              'Profile',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(context,MaterialPageRoute(builder: ((context) {
                return A4Profile(username: username);
              })));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.blue.shade900),
            title: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.popAndPushNamed(context,'/');
            },
          ),
        ],
      ),
    );
  }
}