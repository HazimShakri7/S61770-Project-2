/* Author: Hazim Shakri
   Date: 20/12/2023
   Purpose: To create a HomePage for Tourist Helper Application
*/

import 'package:flutter/material.dart';
import 'package:tourist_helper_app/widget/LetsTourtext.dart';
import 'package:tourist_helper_app/widget/AppBarWidget.dart';
import 'package:tourist_helper_app/widget/BottomBarWidget.dart';

class A1Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("images/backgroundhome.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.9),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            LetsTourtext(),
            const SizedBox(height: 200.0),

            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 100, 186, 226),
                    Color.fromARGB(255, 0, 92, 198),
                  ],
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  minimumSize: const Size(325.0, 0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 70.0),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/ASign-In',
                  );
                },
                child: const Text(
                  'Sign-in',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 100, 186, 226),
                    Color.fromARGB(255, 0, 92, 198),
                  ],
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  minimumSize: const Size(325.0, 0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 60.0),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/BCreate-Account',
                  );
                },
                child: const Text(
                  'Create account',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            // Call the bottom bar function
            buildBottomBar(context),
          ],
        ),
      ),
    );
  }
}