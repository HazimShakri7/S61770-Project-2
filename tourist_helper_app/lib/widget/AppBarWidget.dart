// AppBarWidget.dart

import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  MyAppBar()
      : super(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 100, 186, 226),
                  Color.fromARGB(255, 0, 92, 198),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Text(
            'Tourist Helper App',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),

        );
}