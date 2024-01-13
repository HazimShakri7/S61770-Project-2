//This file is for HomePage

import 'package:flutter/material.dart';

class LetsTourtext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Adding text "Let's Tour the Beautiful World of Malaysia" and breaking them into three lines
        Text(
          " Let's tour the",
          style: TextStyle(
            fontSize: 50.0,
            color: Color.fromARGB(255, 14, 116, 199),
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          " Beautiful World",
          style: TextStyle(
            fontSize: 50.0,
            color: Color.fromARGB(255, 14, 116, 199),
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              " of",
              style: TextStyle(
                fontSize: 50.0,
                color: Color.fromARGB(255, 14, 116, 199),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              " Malaysia",
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}