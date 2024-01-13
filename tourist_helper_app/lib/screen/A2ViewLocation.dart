// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

/* Author: Hazim Shakri
   Date: 24/12/2023, Time: 4:02 PM
   Purpose: To create a RegisterPlace for Tourist Helper Application
*/

import 'package:flutter/material.dart';
import 'package:tourist_helper_app/widget/AppBarWidget.dart';
import 'package:tourist_helper_app/widget/BottomBarWidget.dart';
import 'package:tourist_helper_app/widget/Drawer.dart';
import 'package:tourist_helper_app/widget/LocationDialogBox.dart';
import 'package:tourist_helper_app/screen/A3RegisterPlace.dart';



class A2ViewLocation extends StatefulWidget {
  final String username;

  const A2ViewLocation({super.key, required this.username});
  
  @override
  State<A2ViewLocation> createState() => _A2ViewLocationState();
}

class _A2ViewLocationState extends State<A2ViewLocation> {
  @override
  Widget build(BuildContext context) {
    //Dialog box when user enter the page
    Future.delayed(Duration.zero, () {
      LocationDialogBox.showWelcomeDialog(context);
    });
    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: const Color.fromARGB(255, 123, 210, 241),
      body: Column(
        //bottom container
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //Destination
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
                    'State',
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

          //Creating 6 boxes in grid view
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //to arrange the columns and rows
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return _buildGridItem(context, index);
                },
              ),
            ),
          ),

          //Finish Review button
          Container(
            height: 30.0,
            margin: EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
            ),
            child: ElevatedButton(
              onPressed: () {
                print(widget.username);
                //Navigate to Register Place
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) {
                      return A3RegisterPlace(username: widget.username); //username: Haz
                    },));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: const Text(
                'Finish Review',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color.fromARGB(255, 7, 79, 137),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Rectangle box at the bottom with home icons and text
          buildBottomBar(context),
        ],
      ),
      endDrawer: MyDrawer(username: widget.username,),
    );
  }

  //Widget _buildGridItem
  Widget _buildGridItem(BuildContext context, int index) {
    List<String> imagePaths = [
      'images/Johor1.jpg', //Johor
      'images/Melaka1.jpg', //Melaka
      'images/Terengganu1.jpg', //Terengganu
      'images/Kelantan1.jpg', //Kelantan
      'images/Penang1.jpg', //Penang
      'images/Sabah1.jpg', //Sabah
    ];
    List<String> imageTitles = [
      'Johor',
      'Melaka',
      'Terengganu',
      'Kelantan',
      'Penang',
      'Sabah',
    ];

    // Define the routes for each destination
    // Related with onPressed button
    List<String> destinationRoutes = [
      '/1-Johor',
      '/2-Melaka',
      '/3-Terengganu',
      '/4-Kelantan',
      '/5-Penang',
      '/6-Sabah',
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {
            // Functionality for NAVIGATION when clicking the image
            // Navigate to a DESTINATION based on the index
            String destinationRoute = index < destinationRoutes.length
                ? destinationRoutes[index]
                : '/'; // Default route
            Navigator.pushNamed(context, destinationRoute);
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset(
                imagePaths[index],
                width: 200.0, //yes
                height: 180.0, //suit for Android emulator
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.black.withOpacity(0.5),
                width: double.infinity,
                height: 40.0,
                padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 8.0),
                child: Text(
                  imageTitles[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
