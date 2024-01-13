// ignore_for_file: prefer_const_constructors

/* Author: Hazim Shakri
   Date: 1/1/2024, Time: 2:02 PM
   Purpose: To create a Registered_Place for Tourist Helper Application
*/
/* Author: Hazim Shakri
   Date: 1/1/2024, Time: 2:02 PM
   Purpose: To create a Registered_Place for Tourist Helper Application
*/
import 'package:flutter/material.dart';
import 'package:tourist_helper_app/widget/AppBarWidget.dart';
import 'package:tourist_helper_app/widget/BottomBarWidget.dart';
import 'package:tourist_helper_app/widget/Drawer.dart';

import 'package:provider/provider.dart';
import 'package:tourist_helper_app/model/registration_model.dart';
import 'package:tourist_helper_app/model/registration_provider.dart';
import 'package:tourist_helper_app/widget/DeleteConfirmDialog.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Registered_Place extends StatefulWidget {
  final String username;

  Registered_Place({
    required this.username,
  });

  @override
  State<Registered_Place> createState() => _Registered_PlaceState();
}

class _Registered_PlaceState extends State<Registered_Place> {
  List<Registration> placeList = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

//function to retrieve data from database
  void fetchData() async {
    final url = Uri.https(
      'touristhelperapplication-default-rtdb.asia-southeast1.firebasedatabase.app',
      'UserData/${widget.username}/RegisteredPlace.json',
    );

    try {
      final response = await http.get(url);

      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data = json.decode(response.body);
        print(widget.username);
        if (data == null || data.isEmpty) {
          print('No data found.');
          print(response.body); // Print the entire response body
          return;
        }

        final List<Registration> loadedRegistrations = [];
        print("Debug reqistered_place =. data ${response.body}");
        data.forEach((key, value) {
          if (value is Map && value.isNotEmpty) {
            loadedRegistrations.add(Registration(
              id: key,
              imagePath: value['Image'],
              place: value['Place'],
              state: value['State'],
              date: DateTime.parse(value['Date']),
            ));
          }
        });

        setState(() {
          placeList = loadedRegistrations;
        });

        for (final place in placeList) {
          print('State: ${place.state}');
          print('Place: ${place.place}');
          print('Image: ${place.imagePath}');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        _error = "Error occurred...! Please Try Again Later";
      });
    }
  }

//function to remove data
  void _removeItem(Registration registration) async {
    setState(() {
      placeList.remove(registration);
    });

    final url = Uri.https(
      'touristhelperapplication-default-rtdb.asia-southeast1.firebasedatabase.app',
      'UserData/${widget.username}/RegisteredPlace/${registration.id}.json',
    );

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      print('Failed to delete place from the database.');

      setState(() {
        placeList.add(registration);
      });
    } else {
      print('Delete successful!');
    }
  }

  //Function for d

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    List<Registration> registrations =
        Provider.of<RegistrationProvider>(context).registrations;
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(10.0),
              color: Colors.blue[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1.0),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Registered Place',
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
            Expanded(
              child: placeList.isEmpty
                  ? const Center(
                      child: Text(
                        'No registered places yet.',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: placeList.length,
                      itemBuilder: (context, index) {
                        return buildRegisteredPlaceCard(
                            placeList[index], index, context);
                      },
                    ),
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

  Widget buildRegisteredPlaceCard(
      Registration registration, int index, BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: ListTile(
          leading: Text(
            (index + 1).toString(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          ),
        title: Row(
          children: [
            Image.asset(
              registration.imagePath,
              height: 45.0,
              width: 45.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10.0),
            Text(
              '${registration.state} - ${registration.place}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17.0,
                color: Colors.black,
              ),
            ),
              const Spacer(),
           Text(
                '${formatDate(registration.date)}',
                style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.blue,
                ),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red.shade900,
              ),
              onPressed: () async {
                bool shouldDelete = await DeleteConfirmDialog()
                    .showDeleteConfirmationDialog(context);

                if (shouldDelete) {
                  _removeItem(registration);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Place removed'),
                      action: SnackBarAction(
                        label: 'OK',
                        textColor: Colors.lightBlue,
                        onPressed: () {},
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
