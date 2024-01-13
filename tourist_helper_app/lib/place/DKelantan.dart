/*
Author: Haz
Time: 11:50 PM
Date: 5/1/2023
*/

import 'package:flutter/material.dart';
import 'package:tourist_helper_app/widget/AppBarWidget.dart';
import 'dart:ui';
import 'package:tourist_helper_app/widget/PlaceBoxBar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/cupertino.dart'; //for toggle switch bar

class DKelantan extends StatefulWidget {
  @override
  _DKelantanState createState() => _DKelantanState();
}

class _DKelantanState extends State<DKelantan> {
  PageController _pageController = PageController();
  int currentPage = 0; // Track the current page index

  List<String> imagePaths = [
    'images/Kelantan1.1.jpg',
    'images/Kelantan1.2.jpg',
    'images/Kelantan1.3.jpg',
  ];

  List<String> imageTitles = [
    'PASAR SITI',
    'ISTANA JAHAR',
    'MASJID MUHAMMADI',
  ];

  // Track the visibility of the popup
  bool isPopupVisible = false;

  // Toggle index for the rectangle box
  int selectedToggleIndex = 0;

  // Content for Place 1, Place 2, and Place 3
  List<String> content = [
    "Intro\nThe market's name is derived from Khadija bint Khuwaylid, the wife of Prophet Muhammad[1] who was a businesswoman on that time. Thus, this market also is dominated by women sellers.\n\nPerks\n- Culinary masterclass showcasing local market ingredients\n- Exclusive discounts at stalls\n- Guided historical tours of the market",
    "Intro\nThe Istana Jahar was a royal residence in Kota Bharu, Kelantan, Malaysia. It was built in 1855 by Sultan Muhammad II of Kelantan for his grandson Raja Bendahara Long Kundor. The palace has a pentagon-shaped porte-cochère with the first floor balcony from which members of the royal family could watch ceremonies held in front of the palace. It was named after a jahar tree which was growing in the grounds at the time\n\nPerks\n- Private tours of the palace's historical rooms\n- Traditional Malay cultural performances within the palace grounds\n- Special invitations to events celebrating local heritage.",
    "Intro\nThe Muhammadi Mosque is a famous mosque in Malaysia in general, and in Kelantan in particular. It is a State Mosque and is located in Kota Bharu. The name of the Muhammadi Mosque was taken in conjunction with the name of Sultan Muhammad IV who greatly contributed to the State of Kelantan. It is also called as 'Masjid Besar' among some Kelantan people.\n\nPerks\n- Islamic art and architecture workshops\n- Guided tours of the mosque\n- Participation in community service programs", //(benefit)
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
