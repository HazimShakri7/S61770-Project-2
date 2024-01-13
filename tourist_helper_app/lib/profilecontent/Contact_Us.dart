// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, camel_case_types, must_be_immutable

/* Author: Hazim Shakri
   Date: 30/12/2023, Time: 4:02 PM
   Purpose: To create a A4Profile for Tourist Helper Application
*/
import 'package:flutter/material.dart';
import 'package:tourist_helper_app/widget/AppBarWidget.dart';
import 'package:tourist_helper_app/widget/BottomBarWidget.dart';
import 'package:tourist_helper_app/widget/Drawer.dart';
import 'package:url_launcher/url_launcher.dart';


class Contact_Us extends StatelessWidget {
  final String username;
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

   Contact_Us({super.key, required this.username});

  Future<void> sendEmail() async {
    try {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path:
            'mailto:s61770@ocean.umt.edu.my', // Replace with your email address
        queryParameters: {
          'subject': Uri.encodeComponent(subjectController.text),
          'body': Uri.encodeComponent(messageController.text),
        },
      );

      if (await canLaunch(emailLaunchUri.toString())) {
        await launch(emailLaunchUri.toString());
      } else {
        throw 'Could not launch email';
      }
    } catch (e) {
      print('Error sending email: $e');
    }
  }

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
                      'Contact Us',
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
            // Email form
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Your Email',
                      hintText: 'user@example.com',
                    ),
                  ),
                  TextField(
                    controller: subjectController,
                    decoration: InputDecoration(
                      labelText: 'Subject',
                      hintText: 'Enter subject',
                    ),
                  ),
                  TextField(
                    controller: messageController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Message',
                      hintText: 'Enter your message',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: sendEmail,
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0),
                        )),
                    child: Text(
                      'Send Email',
                      style: TextStyle(
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.bold,
                      ),
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
      endDrawer: MyDrawer(username: username,),
    );
  }
}
