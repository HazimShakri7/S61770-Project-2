/*
Author: Haz
Time: 11:42 PM
Date: 5/1/2023
*/

import 'package:flutter/material.dart';
import 'package:tourist_helper_app/widget/AppBarWidget.dart';
import 'dart:ui';
import 'package:tourist_helper_app/widget/PlaceBoxBar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/cupertino.dart'; //for toggle switch bar

class AJohor extends StatefulWidget {
  @override
  _AJohorState createState() => _AJohorState();
}

class _AJohorState extends State<AJohor> {
  PageController _pageController = PageController();
  int currentPage = 0; // Track the current page index

  List<String> imagePaths = [
    'images/Johor1.1.jpg',
    'images/Johor1.2.jpg',
    'images/Johor1.3.jpg',
  ];

  List<String> imageTitles = [
    'LEGOLAND',
    'OPERA HOUSE',
    'IB BUILDING',
  ];

  // Track the visibility of the popup
  bool isPopupVisible = false;

  // Toggle index for the rectangle box
  int selectedToggleIndex = 0;

  // Content for Place 1, Place 2, and Place 3
  List<String> content = [
    "Intro\nLegoland Malaysia Resort is a theme park in Iskandar Puteri, Johor, Malaysia. It opened on 15 September 2012 with over 40 interactive rides, shows and attractions. It is the first Legoland theme park in Asia and sixth in the world upon its establishment.\n\nPerks\n- Free Entry for age < 10\n- Free 5 Coupons for 5 counters\n- 50% Discount for Hotel",
    "Intro\nQueen Zarith Sofia Opera House (English: Permaisuri Zarith Sofiah Opera House) is an opera house in Johor Bahru, Johor, Malaysia. This building is named after Raja Zarith Sofiah, the consort of the Sultan of Johor Sultan Ibrahim Ismail ibni Almarhum Sultan Iskandar.\n\nPerks\n- Priority seating for a live performance\n- Backstage tour\n- Access to an exclusive lounge",
    "Intro\nThe Sultan Ibrahim Building (Malay: Bangunan Sultan Ibrahim; Jawi: باڠونن سلطان إبراهيم) is a former state secretariat building of Johor. It is located at Bukit Timbalan in Johor Bahru. The building was constructed between 1936 and 1939 and was completed in 1940 as the British colonial government attempted to streamline the state's administration.\n\nPerks\n- Guided architectural tour\n- Invitation to special events\n- Complimentary access to the rooftop",
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
