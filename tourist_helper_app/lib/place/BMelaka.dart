// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables

/*
Author: Haz
Time: 1:24 PM
Date: 25/12/2023
*/

import 'package:flutter/material.dart';
import 'package:tourist_helper_app/widget/AppBarWidget.dart';
import 'dart:ui';
import 'package:tourist_helper_app/widget/PlaceBoxBar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/cupertino.dart'; //for toggle switch bar

class BMelaka extends StatefulWidget {
  @override
  _BMelakaState createState() => _BMelakaState();
}

class _BMelakaState extends State<BMelaka> {
  PageController _pageController = PageController();
  int currentPage = 0; // Track the current page index

  List<String> imagePaths = [
    'images/Melaka1.1.jpg',
    'images/Melaka1.2.jpg',
    'images/Melaka1.3.jpg',
  ];

  List<String> imageTitles = [
    'THE PINES',
    'SKY TOWER',
    'SUL MUSEUM',
  ];

  // Track the visibility of the popup
  bool isPopupVisible = false;

  // Toggle index for the rectangle box
  int selectedToggleIndex = 0;

  // Content for Place 1, Place 2, and Place 3
  List<String> content = [
    "Intro\nOn behalf of THE PINES MELAKA, we would like to welcome guests with a warm ‘Selamat Datang’ to an authentic Melaka stay. Whether guests are here for a relaxing holiday getaway, or pursuing a unique corporate retreat, there is a lot to experience at THE PINES MELAKA.\n\nPerks\n- Complimentary spa treatment\n- Exclusive guided nature walks around\n- Special discounts at the resort's fine",
    "Intro\nThe Shore Sky Tower is the tallest building in Melaka and has an observation deck on the 43rd floor, 163 metres above street level, providing a splendid panoramic 360 degree view of this historic city and the surrounding area.\n\nPerks\n- Fast-track entry and priority access\n- Sunset or sunrise viewing experiences\n- Skywalk adventure with a professional guide",
    "Intro\nMalacca Sultanate Palace Museum (Malay: Muzium Istana Kesultanan Melaka) is a museum located in Malacca City, Malacca, Malaysia. The building is a modern reconstruction of the palace of the Malacca Sultanate, based on the information and data obtained from the Malay Annals.\n\nPerks\n- Interactive workshops\n- Private curator-led tours\n- Access to exclusive cultural performances", //(benefit)
  ];
  

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page?.round() ?? 0;
        selectedToggleIndex = currentPage;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: const Color.fromARGB(255, 123, 210, 241),
      body: Column(
        children: [
          const SizedBox(height: 16.0),
          PlaceBoxBar(),
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: imagePaths.length,
                  itemBuilder: (context, index) {
                    return buildPage(
                      imagePaths[index],
                      imageTitles[index],
                    );
                  },
                ),
                //Left icon
                Positioned(
                  left: 8.0,
                  top: MediaQuery.of(context).size.height / 3 - 45.0,
                  child: IconButton(
                    onPressed: () {
                      if (currentPage > 0) {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                        _showPopup(imageTitles[currentPage - 1]);
                      }
                    },
                    icon: Icon(
                      Icons.arrow_left,
                      size: 50.0,
                      color: Colors.blue[900],
                    ),
                  ),
                ),
                // Information box
                Positioned(
                  left: (MediaQuery.of(context).size.width - 380.0) / 2,
                  top: (MediaQuery.of(context).size.height - 250.0) / 1.9,
                  child: Container(
                    width: 380.0,
                    height: 290.0,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue.shade900,
                        width: 4.0,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Toggle switch for Place 1, Place 2, and Place 3
                        _buildToggleSwitch(),
                        const SizedBox(height: 16.0),
                        // Display information based on the selected title
                        _displayInfoContent(),
                      ],
                    ),
                  ),
                ),
                //Right icon
                Positioned(
                  right: 8.0,
                  top: MediaQuery.of(context).size.height / 3 - 45.0,
                  child: IconButton(
                    onPressed: () {
                      if (currentPage < imagePaths.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                        _showPopup(imageTitles[currentPage + 1]);
                      }
                    },
                    icon: Icon(
                      Icons.arrow_right,
                      size: 50.0,
                      color: Colors.blue[900],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Info bottom icon
          Positioned(
            left: 16.0,
            bottom: 16.0,
            child: GestureDetector(
              onTap: () {
                _showPopup(imageTitles[currentPage]);
              },
              child: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.blue[900],
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage(String imagePath, String title) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          SizedBox(
            height: 200.0,
            child: Stack(
              children: [
                // Static frame around the image
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue.shade900,
                      width: 4.0,
                    ),
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: ClipRRect(
                    child: Image.asset(
                      imagePath,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30.0),
          // Title for image
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue.shade900,
                width: 4.0,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Toggle switch for Place 1, Place 2, and Place 3
  Widget _buildToggleSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
      CupertinoSlidingSegmentedControl<int>(
      children: const {
        0: Text(style: TextStyle(color: Colors.white),'Place 1'),
        1: Text(style: TextStyle(color: Colors.white),'Place 2'),
        2: Text(style: TextStyle(color: Colors.white),'Place 3'),
      },
      groupValue: selectedToggleIndex,
      onValueChanged: (index) {
        if(index !=null){
        setState(() {
          selectedToggleIndex = index;
        });
        }
      },
      thumbColor: Colors.blue.shade900,
      )
      ],
    );
  }

  // Display information content based on the selected title
  Widget _displayInfoContent() {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
        child: Text(
          content[selectedToggleIndex],
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
                        fontWeight: FontWeight.w600,
          ),
        ),
      ),
      ),
    );
  }

  void _showPopup(String title) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        double userRating = 0;

        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
          child: Container(
            height: 300.0,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Rate Your Experience:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Are you Satisfied with the Perks?',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  RatingBar(
                    initialRating: userRating,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 40.0,
                    ratingWidget: RatingWidget(
                      full: const Icon(Icons.star, color: Colors.amber),
                      half: const Icon(Icons.star_half, color: Colors.amber),
                      empty: const Icon(Icons.star_border, color: Colors.amber),
                    ),
                    onRatingUpdate: (rating) {
                      userRating = rating;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      print('User rating: $userRating');
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade900,
                      onPrimary: Colors.white,
                    ),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

