/*Author: Hazim Shakri
Date: 5/12/2023
Purpose: To the initialRoute and routes for navigation of screens.
*/

import 'package:flutter/material.dart';
import 'package:tourist_helper_app/screen/ASign-in.dart';
import 'package:tourist_helper_app/screen/BCreateAccount.dart';
import 'package:tourist_helper_app/screen/A2ViewLocation.dart';
import 'package:tourist_helper_app/screen/A3RegisterPlace.dart';
// import 'package:tourist_helper_app/screen/A4Profile.dart';

import 'package:tourist_helper_app/place/AJohor.dart';
import 'package:tourist_helper_app/place/BMelaka.dart';
import 'package:tourist_helper_app/place/CTerengganu.dart';
import 'package:tourist_helper_app/place/DKelantan.dart';
import 'package:tourist_helper_app/place/EPenang.dart';
import 'package:tourist_helper_app/place/FSabah.dart';

// import 'package:tourist_helper_app/profilecontent/Registered_Place.dart';
// import 'package:tourist_helper_app/profilecontent/Q_&_A.dart';
// import 'package:tourist_helper_app/profilecontent/Contact_Us.dart';
// import 'package:tourist_helper_app/profilecontent/About_Us.dart';


import 'screen/A1Home.dart';

import 'package:provider/provider.dart';
import 'package:tourist_helper_app/model/registration_provider.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RegistrationProvider(),
      child: MyApp(username: '',),
    ),
  );
}

class MyApp extends StatelessWidget{
  final String username;
  
  const MyApp({super.key, required this.username});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
    //    fontFamily: 'Poppins',
  useMaterial3: true,
),
debugShowCheckedModeBanner: false,

      initialRoute: '/',
      routes: {
        '/': (context) => A1Home(),
        '/ASign-In': (context) => ASignIn(),
        '/BCreate-Account': (context) => BCreateAccount(),
        '/A2View-Location': (context) => A2ViewLocation(username: username),
        '/A3Register-Place': (context) => A3RegisterPlace(username: username),
        // '/A4Pro-file': (context) => A4Profile(username: username),

        '/1-Johor': (context) => AJohor(),
        '/2-Melaka': (context) => BMelaka(),
        '/3-Terengganu': (context) => CTerengganu(),
        '/4-Kelantan': (context) => DKelantan(),
        '/5-Penang': (context) => EPenang(),
        '/6-Sabah': (context) => FSabah(),

        // '/Registered-Place': (context) => Registered_Place(username: username),
        // '/Question-Answer': (context) => Question_Answer(),
        // '/Contact-Us': (context) => Contact_Us(),
        // '/About-Us': (context) => About_Us(),

      },
    );
  }
}