// ignore_for_file: prefer_const_constructors

/* Author: Hazim Shakri
   Date: 30/12/2023, Time: 4:02 PM
   Purpose: To create a A4Profile for Tourist Helper Application
*/
import 'package:flutter/material.dart';
import 'package:tourist_helper_app/widget/AppBarWidget.dart';
import 'package:tourist_helper_app/widget/BottomBarWidget.dart';
import 'package:tourist_helper_app/widget/Drawer.dart';

class About_Us extends StatelessWidget {
  final String username;

  const About_Us({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 123, 210, 241),
              Color.fromARGB(255, 123, 210, 241),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          //bottom container
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(10.0),
              color: Colors.blue[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1.0),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About Us',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5.0),
                  ],
                ),
              ),
            ),
            // Main Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "PUBLISHER'S NOTE @ HAZIMSHAKRI",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Our mission is to assist tourists in exploring new places and making their travel experiences memorable and to ensure the quality of tourism.',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Register the place before start the tour and acquire the 'Perks' for every place. Make sure the feedback is rated before or after touring the place so our team can slightly get feedback and improve the 'Perks'.",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Feel free to use our application to enjoy the benefits on registered places, ask questions, and get helpful information for your journey.',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Stay, share and enjoy the app!',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Rectangle box at the bottom with home icons and text
            buildBottomBar(context),
          ],
        ),
      ),
      endDrawer: MyDrawer(
        username: username,
      ),
    );
  }
}
