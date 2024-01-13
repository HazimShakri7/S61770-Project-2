// ignore_for_file: prefer_const_constructors

/* Author: Hazim Shakri
   Date: 30/12/2023, Time: 4:02 PM
   Purpose: To create a A4Profile for Tourist Helper Application
*/
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:tourist_helper_app/profilecontent/About_Us.dart';
import 'package:tourist_helper_app/profilecontent/Contact_Us.dart';
import 'package:tourist_helper_app/profilecontent/Q_&_A.dart';
import 'package:tourist_helper_app/profilecontent/Registered_Place.dart';
import 'package:tourist_helper_app/widget/AppBarWidget.dart';
import 'package:tourist_helper_app/widget/BottomBarWidget.dart';
import 'package:tourist_helper_app/widget/Drawer.dart';


class A4Profile extends StatefulWidget {
  final String username;

  const A4Profile({super.key, required this.username});

  @override
  _A4ProfileState createState() => _A4ProfileState();
}

class _A4ProfileState extends State<A4Profile> {
  TextEditingController _nameController = TextEditingController();
  
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    } 
  }

  _showEditNameDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Edit Your Name', 
          style: TextStyle(color: Colors.black)),
        content: TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            hintText: 'Enter your name:', 
            hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w100)),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
            ),
            child: Text(
              'Cancel', 
              style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                // Save the edited name
              });
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
            ),
            child: Text(
              'Save', 
              style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.username);
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
                      'Profile',
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
            //Circle Avatar with image upload function
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.white,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? Icon(
                        Icons.add_a_photo_outlined,
                        size: 40.0,
                        color: Colors.grey[800],
                      )
                    : null,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      //Name
                      GestureDetector(
                        onTap: () {
                          _showEditNameDialog();
                        },
                        child: Row(
                          children: [
                            Text(
                              _nameController.text.isEmpty
                                  ? 'Your Name'
                                  : _nameController.text,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Icon(
                              Icons.edit,
                              color: Colors.blue.shade900,
                              size: 25.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //Registered_Place
            buildMenuCard('Registered Place', Icons.place, '/Registered-Place'),
            // Q_&_A
            buildMenuCard('Q & A', Icons.question_answer, '/Question-Answer'),
            // Contact_Us
            buildMenuCard('Contact Us', Icons.email, '/Contact-Us'),
            // About_Us
            buildMenuCard('About Us', Icons.info, '/About-Us'),
            // Logout
            buildMenuCard('Logout', Icons.logout, '/'),

            // Rectangle box at the bottom with home icons and text
            buildBottomBar(context),
          ],
        ),
      ),
      endDrawer: MyDrawer(username: widget.username,),
    );
  }

  Widget buildMenuCard(String title, IconData icon, String route) {
    return GestureDetector(
      onTap: () {
        // Add navigation functionality to the specified route
        if(route == '/Registered-Place'){
          Navigator.push(context, MaterialPageRoute(builder: (ctx){
          return Registered_Place(username: widget.username);
        }) );
        }else if(route == '/Question-Answer'){
             Navigator.push(context, MaterialPageRoute(builder: (ctx){
          return Question_Answer(username: widget.username);
        }) );
        }else if(route == '/Contact-Us'){
          Navigator.push(context, MaterialPageRoute(builder: (ctx){
          return Contact_Us(username: widget.username);
        }) );
        }else if(route == 'About-Us'){
          Navigator.push(context, MaterialPageRoute(builder: (ctx){
          return About_Us(username: widget.username);
        }) );
        }else if(route == '/'){
          Navigator.popAndPushNamed(context,'/');
        }
      },
      child: Card(
        margin: const EdgeInsets.all(20.0),
        elevation: 2.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: route == '/' ? Colors.red: Colors.blue.shade900,
            width: 3.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: Colors.blue.shade900,
                size: 30.0,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style:  TextStyle(
                    fontSize: 20.0,
                    color: route == '/' ? Colors.red:Color.fromARGB(255, 0, 90, 163),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if(route != '/')
              const Icon(
                Icons.arrow_forward_ios,
                color: Color.fromARGB(255, 0, 90, 163),
                size: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}