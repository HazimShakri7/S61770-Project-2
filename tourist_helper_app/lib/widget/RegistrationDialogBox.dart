// for RegisterPage
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tourist_helper_app/screen/A4Profile.dart';
class RegistrationDialogBox {


  static void showRegistrationSuccessDialog(BuildContext context, username ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Loading indicator (2 seconds)
        Future.delayed(Duration(seconds: 2), () {
          // Loading indicator finish
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
                backgroundColor: Colors.white,
                title: Center(
                  child: Text(
                    "Registration Successful!",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Click 'OK' to register other place, or click 'Profile' to check your Registered Place.",
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            fixedSize: Size(200, 30),
                          ),
                          child: Text(
                            "OK",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to the user's profile page when "Profile" is pressed
                            // Navigator.pushNamed(context, '/A4Pro-file', arguments: username);
                            Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                return A4Profile(username: username,);
                            }));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            fixedSize: Size(200, 30),
                          ),
                          child: Text(
                            "Profile",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        });

        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
          ),
        );
      },
    );
  }
}