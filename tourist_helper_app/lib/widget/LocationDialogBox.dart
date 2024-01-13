//5.1.2023
//Got an idea to create a dialog box when user enter the ViewLocation.dart
import 'package:flutter/material.dart';

class LocationDialogBox {
  static Future<void> showWelcomeDialog(BuildContext context) async {

    final AnimationController animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: Navigator.of(context),
    );
    animationController.forward();
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animationController,
            curve: Curves.fastOutSlowIn,
          ),
        child: AlertDialog(
          title: const Text(
            'Information!',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Welcome to Tourist Helper Application!',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 15.0),
              Text(
                "Please note that in this app, there are only 3 special places listed with 'Perks' for each state:",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 8.0),
              Text('- Place 1'),
              Text('- Place 2'),
              Text('- Place 3'),
              SizedBox(height: 15.0),
              Text(
                "Stay tuned with the upcoming update on the application for more special 'Perks' and places!",
                style: TextStyle(
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          actions: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'CLOSE',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        );
      },
    );
  }
}