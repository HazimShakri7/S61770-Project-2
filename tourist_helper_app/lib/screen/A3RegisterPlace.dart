// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

/* Author: Hazim Shakri
   Date: 24/12/2023, Time: 4:02 PM
   Purpose: To create a RegisterPlace for Tourist Helper Application
*/

import 'package:flutter/material.dart';
import 'package:tourist_helper_app/model/registration_model.dart';
import 'package:tourist_helper_app/widget/AppBarWidget.dart';
import 'package:tourist_helper_app/widget/BottomBarWidget.dart';
import 'package:tourist_helper_app/widget/RegistrationDialogBox.dart';
import 'package:tourist_helper_app/widget/Drawer.dart';

// import 'package:provider/provider.dart';
// import 'package:tourist_helper_app/model/registration_provider.dart';

import 'dart:convert'; //for json importer - http.post (json) also for retrieve data
import 'package:http/http.dart' as http; //firebase

class A3RegisterPlace extends StatefulWidget {
  final String username;

  const A3RegisterPlace({super.key, required this.username});

  @override
  _A3RegisterPlaceState createState() => _A3RegisterPlaceState();
}

class _A3RegisterPlaceState extends State<A3RegisterPlace> {
  TextEditingController stateNameController = TextEditingController();
  TextEditingController placeNameController = TextEditingController();

  String? selectedState;
  String? selectedPlace;
  String? selectedImagePath;

  List<Registration> userList = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> _saveItem() async {
    //for firebase

    //firebase link
    final url = Uri.https(
        'touristhelperapplication-default-rtdb.asia-southeast1.firebasedatabase.app',
        'UserData/${widget.username}/RegisteredPlace.json');

    final response = await http.post(
      //to insert the record

      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'State': selectedState,
          'Place': selectedPlace,
          'Image': selectedImagePath,
          'Date': DateTime.now().toIso8601String(),
        },
      ),
    );
    //firebase
    //check the data and status code..
    print(response.body);
    print(response.statusCode);

    //Check the context for widget is NULL
    if (!context.mounted) {
      return;
    }
    //Add the current record into Registered Place at Profile
  }

  void getData() async {
    //firebase link
    final url = Uri.https(
        'touristhelperapplication-default-rtdb.asia-southeast1.firebasedatabase.app',
        'UserData/${widget.username}/RegisteredPlace.json');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Registration> tempList = [];
        Map<String, dynamic> anotherList = json.decode(response.body);

        anotherList.entries.map((e) {
          tempList.add(Registration(
            id: e.key,
            state: e.value['State'],
            place: e.value['Place'],
            imagePath: e.value['Image'],
            date: DateTime.parse(e.value['Date']),
          ));
        });

        if (anotherList.isNotEmpty) {
          userList = tempList;
          print("Data added to the list");
        } else {
          print("Fail to add data");
        }
      }
    } catch (error) {
      print("Error = $error");
    }
  }
  //untuk connect databasebaru sampai sini

  // Image paths mapping
  Map<String, Map<String, String>> imagePaths = {
    'Johor': {
      '1': 'images/Johor1.1.jpg',
      '2': 'images/Johor1.2.jpg',
      '3': 'images/Johor1.3.jpg'
    },
    'Melaka': {
      '1': 'images/Melaka1.1.jpg',
      '2': 'images/Melaka1.2.jpg',
      '3': 'images/Melaka1.3.jpg'
    },
    'Terengganu': {
      '1': 'images/Terengganu1.1.jpg',
      '2': 'images/Terengganu1.2.jpg',
      '3': 'images/Terengganu1.3.jpg'
    },
    'Kelantan': {
      '1': 'images/Kelantan1.1.jpg',
      '2': 'images/Kelantan1.2.jpg',
      '3': 'images/Kelantan1.3.jpg'
    },
    'Penang': {
      '1': 'images/Penang1.1.jpg',
      '2': 'images/Penang1.2.jpg',
      '3': 'images/Penang1.3.jpg'
    },
    'Sabah': {
      '1': 'images/Sabah1.1.jpg',
      '2': 'images/Sabah1.2.jpg',
      '3': 'images/Sabah1.3.jpg'
    },
  };

  @override
  void dispose() {
    stateNameController.dispose();
    placeNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: const Color.fromARGB(255, 123, 210, 241),
      body: Container(
        child: Column(
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
                padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Register Place',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2.0),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.0),
            Padding(
              padding: EdgeInsets.only(left: 7.0, right: 7.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kindly 'Choose State' and 'Select Place' below to acquire the 'Perks'",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Image is automatically generated.",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "To check Registered Place:",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Navigation Menu > Profile > Registered Place",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 3.0, right: 3.0),
                  // State dropdown list
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 255, 255, 255),
                          Color.fromARGB(255, 255, 255, 255),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      hint: Text(
                        '  Choose State:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                      value: selectedState,
                      onChanged: (newValue) {
                        setState(() {
                          selectedState = newValue;
                          selectedPlace = null; //Reset place when state changes
                          selectedImagePath =
                              null; //Reset image path when state changes
                        });
                      },
                      items: [
                        'Johor',
                        'Melaka',
                        'Terengganu',
                        'Kelantan',
                        'Penang',
                        'Sabah',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3.0, right: 3.0),
                  // Place dropdown list
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 255, 255, 255),
                          Color.fromARGB(255, 255, 255, 255),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      hint: Text(
                        '  Select Place:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                      value: selectedPlace,
                      onChanged: (newValue) {
                        setState(() {
                          selectedPlace = newValue;
                          //Update image path based on selected 'state' and 'place'
                          selectedImagePath =
                              imagePaths[selectedState]?[selectedPlace ?? '1'];
                        });
                      },
                      items: [
                        '1',
                        '2',
                        '3',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                //Creating rectangle box to display image
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
                  width: 335.0,
                  height: 250.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1.0),
                      border: Border.all(
                          color: Color.fromARGB(255, 0, 0, 0), width: 0)),
                  child: selectedImagePath != null
                      ? ClipRect(
                          child: OverflowBox(
                            alignment: Alignment.center,
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Image.asset(
                                selectedImagePath!,
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Image.asset(
                            'images/NoImage.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                //Submit button
                ElevatedButton(
                  onPressed: (selectedState != null && selectedPlace != null)
                      ? () {
                          if (selectedState != null && selectedPlace != null) {
                            // Check if the place is already registered
                            bool isPlaceAlreadyRegistered = false;
                            // Provider.of<RegistrationProvider>(context,
                            //         listen: false)
                            //     .registrations
                            //     .any((registration) =>
                            //         registration.state == selectedState &&
                            //         registration.place == selectedPlace);
                            for (final value in userList) {
                              if (value.state == selectedState &&
                                  value.place == selectedPlace) {
                                isPlaceAlreadyRegistered = true;
                                return;
                              }
                              print(
                                  'selected place (firebase) = ${value.state} compare with $selectedState');
                              print(
                                  'selected place (firebase) = ${value.place} compare with $selectedPlace');
                            }
                            print(isPlaceAlreadyRegistered);
                            if (isPlaceAlreadyRegistered) {
                              // Show a dialog if the place is already registered
                              showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  return AlertDialog(
                                    title: Center(
                                      child: Text(
                                        'Error!',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    content: Text(
                                        'This place is already registered.'),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1.0),
                                    ),
                                    actions: [
                                      Center(
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.of(dialogContext).pop();
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                            ),
                                          ),
                                          child: Text(
                                            'Dismiss',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              // Proceed with saving the item
                              _saveItem();
                              // To construct a data object with the selected state and place
                              // Registration registration = Registration(
                              //   state: selectedState!,
                              //   place: selectedPlace!,
                              //   imagePath: selectedImagePath ?? '',
                              // );

                              // To access the RegistrationProvider and add the new registration
                              // Provider.of<RegistrationProvider>(context,
                              //         listen: false)
                              //     .addRegistration(registration);

                              // Both state and place are selected, can click the submit
                              // to call the RegistrationDialogBox.dart widget
                              RegistrationDialogBox
                                  .showRegistrationSuccessDialog(
                                      context, widget.username);
                            }
                          }
                        }
                      // To disable 'Submit' button if either state or place is not selected
                      : null,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: Text(
                    style: TextStyle(
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                    'Submit',
                  ),
                ),
              ],
            ),
            buildBottomBar(context),
          ],
        ),
      ),
      endDrawer: MyDrawer(
        username: widget.username,
      ),
    );
  }
}
